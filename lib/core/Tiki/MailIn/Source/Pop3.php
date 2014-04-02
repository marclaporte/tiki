<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

namespace Tiki\MailIn\Source;
use Tiki\MailIn\Exception\TransportException;

class Pop3 implements SourceInterface
{
	private $host;
	private $port;
	private $username;
	private $password;

	function __construct($host, $port, $username, $password)
	{
		$this->host = $host;
		$this->port = (int) $port;
		$this->username = $username;
		$this->password = $password;
	}

	function test()
	{
		try {
			$pop = $this->connect();
			$pop->close();

			return true;
		} catch (TransportException $e) {
			return false;
		}
	}

	function getMessages()
	{
		$pop = $this->connect();
		$toDelete = [];

		foreach ($pop as $i => $source) {
			$message = new Message($i, function () use ($i, & $toDelete) {
				$toDelete[] = $i;
			});
			$from = $source->from ?: $source->{'return-path'};
			$message->setMessageId(str_replace(['<', ']'], '', $source->{'message-id'}));
			$message->setRawFrom($from);
			$message->setSubject($source->subject);
			$message->setHtmlBody($this->getBody($source, 'text/html'));
			$message->setBody($this->getBody($source, 'text/plain'));

			$this->handleAttachments($message, $source);

			yield $message;
		}

		foreach ($toDelete as $i) {
			$pop->removeMessage($i);
		}

		$pop->close();
	}

	private function connect()
	{
		try {
			$pop = new \Zend_Mail_Storage_Pop3([
				'host' => $this->host,
				'port' => $this->port,
				'user' => $this->username,
				'password' => $this->password,
				'ssl' => $this->port == 995,
			]);

			return $pop;
		} catch (\Zend_Mail_Protocol_Exception $e) {
			throw new TransportException(tr("Login failed for POP3 account on %0:%1 for user %2", $this->host, $this->password, $this->username));
		}
	}

	private function getBody($part, $type)
	{
		if (! $part->isMultipart() && 0 === strpos($part->getHeader('Content-Type'), $type)) {
			return $part->getContent();
		}

		if ($part->isMultipart()) {
			for ($i = 1; $i <= $part->countParts(); ++$i) {
				$p = $part->getPart($i);
				if ($ret = $this->getBody($p, $type)) {
					return $ret;
				}
			}
		}
	}

	private function handleAttachments($message, $part)
	{
		$type = $part->getHeader('Content-Type');
		if (0 === strpos($type, 'multipart/mixed') || 0 === strpos($type, 'multipart/related')) {
			// Skip initial content
			for ($i = 2; $i <= $part->countParts(); ++$i) {
				$p = $part->getPart($i);
				if ($p->isMultipart()) {
					continue;
				}
				$headers = $p->getHeaders();

				if (isset($headers['content-id'])) {
					$contentId = $headers['content-id'];
					$contentId = str_replace("<", "", $contentId);
					$contentId = str_replace(">", "", $contentId);
				} elseif (isset($headers['x-attachment-id'])) {
					$contentId = $headers['x-attachment-id'];
				} else {
					$contentId = uniqid();
				}
				$fileName = '';
				$fileType = '';
				$fileData = base64_decode($p->getContent());
				$fileSize = function_exists('mb_strlen') ? mb_strlen($fileData, '8bit') : strlen($fileData);

				if (isset($headers['content-type'])) {
					$type = $headers['content-type'];
					$pos = strpos($type, ';');
					if ($pos === false) {
						$fileType = $type;
					} else {
						$fileType = substr($type, 0, $pos);
					}

					if (preg_match('/name="([^"]+)"/', $type, $parts)) {
						$fileName = $parts[1];
					}
				}

				if (! $fileName && isset($headers['content-disposition'])) {
					$dispo = $headers['content-disposition'];
					if (preg_match('/name="([^"]+)"/', $dispo, $parts)) {
						$fileName = $parts[1];
					}
				}

				$message->addAttachment($contentId, $fileName, $fileType, $fileSize, $fileData);
			}
		}
	}
}
