<?php
// (c) Copyright 2002-2012 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

/**
 * Factory for reports classes
 * 
 * @package Tiki
 * @subpackage Reports
 */
class Reports_Factory
{
	static public function build($className)
	{
		$db = TikiDb::get();
		
		switch($className) {
			case 'Reports_Users':
				return new Reports_Users($db, new DateTime);
			case 'Reports_Cache':
				return new Reports_Cache($db, new DateTime);
			case 'Reports_Manager':
				global $userlib;
				return new Reports_Manager(Reports_Factory::build('Reports_Users'), Reports_Factory::build('Reports_Cache'),
					Reports_Factory::build('Reports_Send'), $userlib);
			case 'Reports_Send':
				global $prefs;
				require_once('lib/webmail/tikimaillib.php');
				return new Reports_Send(new DateTime, new TikiMail);
			default:
				throw new Exception("Unknown class $className");
		}		
	} 
}