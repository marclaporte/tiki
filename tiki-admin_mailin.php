<?php
/**
 * @package tikiwiki
 */
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

require_once ('tiki-setup.php');
include_once ('lib/mailin/mailinlib.php');
//check if feature is on
$access->check_feature('feature_mailin');
$access->check_permission(array('tiki_p_admin_mailin'));

/**
 * @param $pop
 * @param $user
 * @param $pass
 * @return bool
 */
function account_ok($pop, $user, $pass)
{
	include_once ('lib/webmail/net_pop3.php');
	$pop3 = new Net_POP3();
	$pop3->connect($pop);
	$pop3->login($user, $pass);
	if (!$pop3) {
		$pop3->disconnect();
		return false;
	} else {
		$pop3->disconnect();
		return true;
	}
}

// Add a new mail account for the user here
if (!isset($_REQUEST['accountId'])) $_REQUEST['accountId'] = 0;
$smarty->assign('accountId', $_REQUEST['accountId']);
if (isset($_REQUEST['new_acc'])) {
	check_ticket('admin-mailin');
	if (!account_ok($_REQUEST['pop'], $_REQUEST['username'], $_REQUEST['pass'])) {
		$tikifeedback[] = array(
			'num' => 1,
			'mes' => sprintf(tra('Mail-in account %s incorrect'), $_REQUEST['account'])
		);
	} else {
		$mailinlib->replace_mailin_account(
			$_REQUEST['accountId'],
			$_REQUEST['account'],
			$_REQUEST['pop'],
			$_REQUEST['port'],
			$_REQUEST['username'],
			$_REQUEST['pass'],
			$_REQUEST['type'],
			isset($_REQUEST['active']) ? 'y' : 'n',
			isset($_REQUEST['anonymous']) ? 'y' : 'n',
			isset($_REQUEST['admin']) ? 'y' : 'n',
			isset($_REQUEST['attachments']) ? 'y' : 'n',
			isset($_REQUEST['routing']) ? 'y' : 'n',
			$_REQUEST['article_topicId'],
			$_REQUEST['article_type'],
			$_REQUEST['discard_after'],
			isset($_REQUEST['show_inlineImages']) ? 'y' : 'n',
			isset($_REQUEST['save_html']) ? 'y' : 'n',
			$_REQUEST['categoryId'],
			$_REQUEST['namespace'],
			isset($_REQUEST['respond_email']) ? 'y' : 'n',
			isset($_REQUEST['leave_email']) ? 'y' : 'n'
		);

		$tikifeedback[] = array(
			'num' => 1,
			'mes' => sprintf(tra('Mail-in account %s saved'), $_REQUEST['account'])
		);
	}
} else {
	$smarty->assign('confirmation', 0);
}

if (isset($_REQUEST['remove'])) {
	$access->check_authenticity();
	$mailinlib->remove_mailin_account($_REQUEST['remove']);
}

if ($_REQUEST['accountId']) {
	$info = $mailinlib->get_mailin_account($_REQUEST['accountId']);
} else {
	$info['account'] = '';
	$info['username'] = '';
	$info['pass'] = '';
	$info['pop'] = '';
	$info['port'] = 110;
	$info['type'] = 'wiki-put';
	$info['active'] = 'y';
	$info['anonymous'] = 'n';
	$info['admin'] = 'y';
	$info['attachments'] = 'y';
	$info['routing'] = 'y';
	$info['article_topicId'] = '';
	$info['article_type'] = '';
	$info['show_inlineImages'] = 'y';
	$info['save_html'] = 'y';
	$info['categoryId'] = 0;
	$info['namespace'] = '';
	$info['respond_email'] = 'y';
	$info['leave_email'] = 'n';
}
$smarty->assign('info', $info);

// List
$accounts = $mailinlib->list_mailin_accounts(0, -1, 'account_asc', '');
$smarty->assign('accounts', $accounts['data']);

if (isset($_REQUEST['mailin_autocheck'])) {
	if ($_REQUEST['mailin_autocheck'] == 'y' && !(preg_match('/[0-9]+/', $_REQUEST['mailin_autocheckFreq']) && $_REQUEST['mailin_autocheckFreq'] > 0)) {
		$smarty->assign('msg', tra('Frequency should be a positive integer!'));
		$smarty->display('error.tpl');
		die;
	} else {
		$tikilib->set_preference('mailin_autocheck', $_REQUEST['mailin_autocheck']);
		$tikilib->set_preference('mailin_autocheckFreq', $_REQUEST['mailin_autocheckFreq']);
		if ($prefs['mailin_autocheck'] == 'y') {
			$tikifeedback[] = array(
				'num' => 1,
				'mes' => sprintf(tra('Mail-in accounts set to be checked every %s minutes'), $prefs['mailin_autocheckFreq'])
			);
		} else {
			$tikifeedback[] = array(
				'num' => 1,
				'mes' => sprintf(tra('Automatic Mail-in accounts checking disabled'))
			);
		}
	}
}

$artlib = TikiLib::lib('art');

$topics = $artlib->list_topics();
$smarty->assign('topics', $topics);
$types = $artlib->list_types();
$smarty->assign('types', $types);
$smarty->assign('tikifeedback', $tikifeedback);
$smarty->assign('mailin_types', $mailinlib->list_available_types());
ask_ticket('admin-mailin');

// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');
$smarty->display('tiki-admin_mailin.tpl');
