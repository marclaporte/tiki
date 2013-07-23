<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: /cvsroot/tikiwiki/tiki/tiki-admin_include_freetags.php,v 1.9.2.5 2008-02-18 14:03:29 lphuberdeau Exp $
require_once ('tiki-setup.php');
$access->check_script($_SERVER["SCRIPT_NAME"], basename(__FILE__));
if (isset($_REQUEST['save'])) {
	check_ticket('admin-inc-sefurl');
	simple_set_toggle('feature_sefurl');
	simple_set_toggle('feature_sefurl_filter');
	$_REQUEST['feature_sefurl_paths'] = preg_split('/ *[,\/] */', $_REQUEST['feature_sefurl_paths']);
	simple_set_value('feature_sefurl_paths');
	simple_set_toggle('feature_sefurl_title_article');
	simple_set_toggle('feature_sefurl_title_blog');
}
if (!file_exists('.htaccess')) {
	$smarty->assign('warning', tra('If you use apache, you need a .htaccess file to have this feature working'));
}
ask_ticket('admin-inc-sefurl');