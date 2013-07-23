<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: /cvsroot/tikiwiki/tiki/tiki-view_sheets.php,v 1.16 2007-10-12 07:55:33 nyloth Exp $
// Based on tiki-galleries.php
$section = 'sheet';
require_once ('tiki-setup.php');
require_once ('lib/sheet/grid.php');
$auto_query_args = array(
	'sheetId',
	'readdate',
	'mode'
);
if ($prefs['feature_sheet'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled") . ": feature_sheet");
	$smarty->display("error.tpl");
	die;
}
if (!isset($_REQUEST['sheetId'])) {
	$smarty->assign('msg', tra("A SheetId is required."));
	$smarty->display("error.tpl");
	die;
}
if ($tiki_p_admin != 'y' && $tiki_p_admin_sheet != 'y' && !$tikilib->user_has_perm_on_object($user, $_REQUEST['sheetId'], 'sheet', 'tiki_p_view_sheet')) {
	$smarty->assign('msg', tra("Access Denied") . ": feature_sheet");
	$smarty->display("error.tpl");
	die;
}
$smarty->assign('sheetId', $_REQUEST["sheetId"]);
$smarty->assign('chart_enabled', (function_exists('imagepng') || function_exists('pdf_new')) ? 'y' : 'n');
// Individual permissions are checked because we may be trying to edit the gallery
// Init smarty variables to blank values
//$smarty->assign('theme','');
$info = $sheetlib->get_sheet_info($_REQUEST["sheetId"]);
if ($tiki_p_admin == 'y' || $tiki_p_admin_sheet == 'y' || ($user && $user == $info['author']) || $tikilib->user_has_perm_on_object($user, $_REQUEST['sheetId'], 'sheet', 'tiki_p_edit_sheet')) $tiki_p_edit_sheet = 'y';
else $tiki_p_edit_sheet = 'n';
$smarty->assign('tiki_p_edit_sheet', $tiki_p_edit_sheet);
$smarty->assign('title', $info['title']);
$smarty->assign('description', $info['description']);
$smarty->assign('page_mode', 'view');
// Process the insertion or modification of a gallery here
$grid = & new TikiSheet;
if (isset($_REQUEST['mode']) && $_REQUEST['mode'] == 'edit' && $tiki_p_edit_sheet != 'y' && $tiki_p_admin != 'y' && $tiki_p_admin_sheet != 'y') {
	$smarty->assign('msg', tra("Access Denied") . ": feature_sheet");
	$smarty->display("error.tpl");
	die;
}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	if ($tiki_p_edit_sheet != 'y' && $tiki_p_admin != 'y' && $tiki_p_admin_sheet != 'y') {
		$smarty->assign('msg', tra("Access Denied") . ": feature_sheet");
		$smarty->display("error.tpl");
		die;
	}
	if (!empty($_REQUEST['s'])) {	// ajax save request from jQuery.sheet
		$handler = & new TikiSheetHTMLTableHandler($_REQUEST['s']);
		$res = $grid->import($handler);
		// Save the changes
		$handler = & new TikiSheetDatabaseHandler($_REQUEST["sheetId"]);
		$grid->export($handler);
		die($res ? 'saved ' . $grid->getColumnCount() . ' x ' . $grid->getRowCount() . ' grid' : 'failed');
	}
	
	// Load data from the form
	$handler = & new TikiSheetFormHandler;
	if (!$grid->import($handler)) $grid = & new TikiSheet;
	// Save the changes
	$handler = & new TikiSheetDatabaseHandler($_REQUEST["sheetId"]);
	$grid->export($handler);
	// Load the layout settings from the database
	$grid = & new TikiSheet;
	$grid->import($handler);
	$handler = & new TikiSheetOutputHandler;
	ob_start();
	$grid->export($handler);
	$smarty->assign('grid_content', ob_get_contents());
	ob_end_clean();
} else {
	$handler = & new TikiSheetDatabaseHandler($_REQUEST["sheetId"]);
	$date = time();
	if (!empty($_REQUEST['readdate'])) {
		$date = $_REQUEST['readdate'];
		if (!is_numeric($date)) $date = strtotime($date);
		if ($date == - 1) $date = time();
	}
	$smarty->assign('read_date', $date);
	$handler->setReadDate($date);
	$grid->import($handler);
	if (isset($_REQUEST['mode']) && $_REQUEST['mode'] == 'edit') {
		$handler = & new TikiSheetFormHandler;
		ob_start();
		$grid->export($handler);
		$smarty->assign('init_grid', ob_get_contents());
		ob_end_clean();
		$smarty->assign('page_mode', 'edit');
		if ($prefs['feature_contribution'] == 'y') {
			$contributionItemId = $_REQUEST['sheetId'];
			include_once ('contribution.php');
		}
	} else {
		$handler = & new TikiSheetOutputHandler;
		ob_start();
		$grid->export($handler);
		$smarty->assign('grid_content', ob_get_contents());
		ob_end_clean();
	}
}
if ($prefs['feature_jquery_sheet'] == 'y') {
	$headerlib->add_jq_onready('
$jq("#edit_button").click( function () {
	var $a = $jq(this).find("a");
	if ($a.text() != "Done") {
		if ($jq("div.tiki_sheet").children().length == 0)  {	// new sheet
			$jq("div.tiki_sheet").append($jq("<table><tbody><tr><td>&nbsp;</td><tr></tbody></table>"));
		}
		$jq("div.tiki_sheet").tiki("sheet", "", {title: "'.$info['title'].'", urlSave: "tiki-view_sheets.php?sheetId='.$_REQUEST['sheetId'].'"});
		$a.attr("temp", $a.text());
		$a.text("Done");
		$jq("#edit_button").parent().find(".button:not(#edit_button)").hide();
		$jq("#save_button").show();
	} else {
		//$jq("div.tiki_sheet").sheet("destroy");
		//$a.text($a.attr("temp"));
		window.location.replace(window.location.href);
	}
	return false;
});
$jq("#save_button").click( function () {
	$jq.sheet.cellEditDone();
	$jq.sheet.saveSheet();
	return false;
}).hide();
');
}
	

if ($prefs['feature_warn_on_edit'] == 'y') {
	if ($tikilib->semaphore_is_set($_REQUEST['sheetId'], $prefs['warn_on_edit_time'] * 60, 'sheet') && ($semUser = $tikilib->get_semaphore_user($_REQUEST['sheetId'], 'sheet')) != $user) {
		$editconflict = 'y';
		$smarty->assign('editconflict', 'y');
		$smarty->assign('semUser', $semUser);
	} else {
		$editconflict = 'n';
	}
	if (isset($_REQUEST['mode']) && $_REQUEST['mode'] == 'edit') {
		$_SESSION['edit_lock_sheet' . $_REQUEST['sheetId']] = $tikilib->semaphore_set($_REQUEST['sheetId'], 'sheet');
	} elseif (isset($_SESSION['edit_lock_sheet' . $_REQUEST['sheetId']])) {
		$tikilib->semaphore_unset($_REQUEST['sheetId'], $_SESSION['edit_lock_sheet' . $_REQUEST['sheetId']]);
		unset($_SESSION['edit_lock_sheet' . $_REQUEST['sheetId']]);
	}
}
$headerlib->add_cssfile('lib/sheet/style.css', 10);
$cat_type = 'sheet';
$cat_objid = $_REQUEST["sheetId"];
include_once ("categorize_list.php");
include_once ('tiki-section_options.php');
ask_ticket('sheet');
// Display the template
$smarty->assign('mid', 'tiki-view-sheets.tpl');
$smarty->display("tiki.tpl");