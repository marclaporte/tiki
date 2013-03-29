<?php

// $Id: /cvsroot/tikiwiki/tiki/tiki-admin_shoutbox_words.php,v 1.6 2007-10-12 07:55:24 nyloth Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Admin to the filtering of bad shoutbox words
// First commit on cvs by damosoft aka damian

// Initialization
require_once ('tiki-setup.php');

include_once ('lib/shoutbox/shoutboxlib.php');

if ($prefs['feature_shoutbox'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_shoutbox");

	$smarty->display("error.tpl");
	die;
}

if ($tiki_p_admin_shoutbox != 'y') {
	$smarty->assign('errortype', 401);
	$smarty->assign('msg', tra("You do not have permission to use this feature"));
	$smarty->display("error.tpl");
	die;
}

// Do the add bad word form here

if (isset($_REQUEST["add"])) {
	check_ticket('admin-shoutboxwords');
	if(empty($_REQUEST["word"])) {
	        $smarty->assign('msg', tra("You have to provide a word"));
		$smarty->display("error.tpl");
		die;
	}
	$shoutboxlib->add_bad_word($_REQUEST["word"]);
}

if (isset($_REQUEST["remove"]) && !empty($_REQUEST["remove"])) {
	check_ticket('admin-shoutboxwords');
	$shoutboxlib->remove_bad_word($_REQUEST["remove"]);
}

if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'word_asc';
} else {
	$sort_mode = $_REQUEST["sort_mode"];
}

$smarty->assign_by_ref('sort_mode', $sort_mode);

// If offset is set use it if not then use offset =0
// use the maxRecords php variable to set the limit
// if sortMode is not set then use lastModif_desc
if (!isset($_REQUEST["offset"])) {
	$offset = 0;
} else {
	$offset = $_REQUEST["offset"];
}

$smarty->assign_by_ref('offset', $offset);

if (isset($_REQUEST["find"])) {
	$find = $_REQUEST["find"];
} else {
	$find = '';
}

$smarty->assign('find', $find);

$words = $shoutboxlib->get_bad_words($offset, $maxRecords, $sort_mode, $find);

$smarty->assign_by_ref('cant_pages', $words["cant"]);

// Get users (list of users)
$smarty->assign_by_ref('words', $words["data"]);

ask_ticket('admin-shoutboxwords');

// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');

// Display the template
$smarty->assign('mid', 'tiki-admin_shoutbox_words.tpl');
$smarty->display("tiki.tpl");

?>