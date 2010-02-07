<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
$section = 'sheet';
require_once ('tiki-setup.php');
require_once ('lib/sheet/grid.php');

$access->check_feature('feature_sheet');

if (!isset($_REQUEST["sheetId"])) {
	$_REQUEST["sheetId"] = 0;
	$info = array();
} else {
	$info = $sheetlib->get_sheet_info($_REQUEST["sheetId"]);
	if ($tiki_p_admin == 'y' || $tiki_p_admin_sheet == 'y' || $tikilib->user_has_perm_on_object($user, $_REQUEST['sheetId'], 'sheet', 'tiki_p_view_sheet')) $tiki_p_view_sheet = 'y';
	else $tiki_p_view_sheet = 'n';
	$smarty->assign('tiki_p_view_sheet', $tiki_p_view_sheet);
	if ($tiki_p_admin == 'y' || $tiki_p_admin_sheet == 'y' || ($user && $user == $info['author']) || $tikilib->user_has_perm_on_object($user, $_REQUEST['sheetId'], 'sheet', 'tiki_p_edit_sheet')) $tiki_p_edit_sheet = 'y';
	else $tiki_p_edit_sheet = 'n';
	$smarty->assign('tiki_p_edit_sheet', $tiki_p_edit_sheet);
	if ($tiki_p_admin == 'y' || $tiki_p_admin_sheet == 'y' || ($user && $user == $info['author']) || $tikilib->user_has_perm_on_object($user, $_REQUEST['sheetId'], 'sheet', 'tiki_p_view_sheet_history')) $tiki_p_view_sheet_history = 'y';
	else $tiki_p_view_sheet_history = 'n';
	$smarty->assign('tiki_p_view_sheet_history', $tiki_p_view_sheet_history);
}

$access->check_permission('tiki_p_view_sheet');

if (isset($_REQUEST["find"])) {
	$find = $_REQUEST["find"];
} else {
	$find = '';
}
$smarty->assign('find', $find);
$smarty->assign('sheetId', $_REQUEST["sheetId"]);
// Init smarty variables to blank values
$smarty->assign('title', '');
$smarty->assign('description', '');
$smarty->assign('edit_mode', 'n');
$smarty->assign('chart_enabled', (function_exists('imagepng') || function_exists('pdf_new')) ? 'y' : 'n');
// If we are editing an existing gallery prepare smarty variables
if (isset($_REQUEST["edit_mode"]) && $_REQUEST["edit_mode"]) {
	$access->check_permission('tiki_p_edit_sheet');
	check_ticket('sheet');
	// Get information about this galleryID and fill smarty variables
	$smarty->assign('edit_mode', 'y');
	if ($tiki_p_admin == 'y') {
		$users = $tikilib->list_users(0, -1, 'login_asc', '', false);
		$smarty->assign_by_ref('users', $users['data']);
	}
	if ($_REQUEST["sheetId"] > 0) {
		$smarty->assign('title', $info["title"]);
		$smarty->assign('description', $info["description"]);
		$smarty->assign('creator', $info['author']);
		$info = $sheetlib->get_sheet_layout($_REQUEST["sheetId"]);
		$smarty->assign('className', $info["className"]);
		$smarty->assign('headerRow', $info["headerRow"]);
		$smarty->assign('footerRow', $info["footerRow"]);
	} else {
		$smarty->assign('className', 'default');
		$smarty->assign('headerRow', '0');
		$smarty->assign('footerRow', '0');
		$smarty->assign('creator', $user);
	}
}
// Process the insertion or modification of a gallery here
if (isset($_REQUEST["edit"])) {
	$access->check_permission('tiki_p_edit_sheet');
	check_ticket('sheet');
	// Everything is ok so we proceed to edit the gallery
	$smarty->assign('edit_mode', 'y');
	$smarty->assign_by_ref('title', $_REQUEST["title"]);
	$smarty->assign_by_ref('description', $_REQUEST["description"]);
	$smarty->assign_by_ref('className', $_REQUEST["className"]);
	$smarty->assign_by_ref('headerRow', $_REQUEST["headerRow"]);
	$smarty->assign_by_ref('footerRow', $_REQUEST["footerRow"]);
	$gid = $sheetlib->replace_sheet($_REQUEST["sheetId"], $_REQUEST["title"], $_REQUEST["description"], $_REQUEST['creator']);
	$sheetlib->replace_layout($gid, $_REQUEST["className"], $_REQUEST["headerRow"], $_REQUEST["footerRow"]);
	$cat_type = 'sheet';
	$cat_objid = $gid;
	$cat_desc = substr($_REQUEST["description"], 0, 200);
	$cat_name = $_REQUEST["title"];
	$cat_href = "tiki-view_sheets.php?sheetId=" . $cat_objid;
	include_once ("categorize.php");
	$smarty->assign('edit_mode', 'n');
}
if (isset($_REQUEST["removesheet"])) {
	$access->check_permission('tiki_p_edit_sheet');
	$area = 'delsheet';
	if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		$sheetlib->remove_sheet($_REQUEST["sheetId"]);
	} else {
		key_get($area);
	}
}
if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'title_desc';
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
// Get the list of libraries available for this user (or public galleries)
// GET ALL GALLERIES SINCE ALL GALLERIES ARE BROWSEABLE
$sheets = $sheetlib->list_sheets($offset, $maxRecords, $sort_mode, $find);
$smarty->assign_by_ref('cant_pages', $sheets["cant"]);
$smarty->assign_by_ref('sheets', $sheets["data"]);
$cat_type = 'sheet';
$cat_objid = $_REQUEST["sheetId"];
include_once ("categorize_list.php");
include_once ('tiki-section_options.php');
ask_ticket('sheet');
// Display the template
$smarty->assign('mid', 'tiki-sheets.tpl');
$smarty->display("tiki.tpl");
