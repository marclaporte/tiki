<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$
require_once ('tiki-setup.php');
$access->check_feature(array('feature_wiki_templates','feature_cms_templates'));

include_once ('lib/templates/templateslib.php');

$access->check_permission('$tiki_p_edit_content_templates');

if (!isset($_REQUEST["templateId"])) {
	$_REQUEST["templateId"] = 0;
}
$smarty->assign('templateId', $_REQUEST["templateId"]);
if ($_REQUEST["templateId"]) {
	$info = $templateslib->get_template($_REQUEST["templateId"]);
	if ($templateslib->template_is_in_section($_REQUEST["templateId"], 'html')) {
		$info["section_html"] = 'y';
	} else {
		$info["section_html"] = 'n';
	}
	if ($templateslib->template_is_in_section($_REQUEST["templateId"], 'wiki')) {
		$info["section_wiki"] = 'y';
	} else {
		$info["section_wiki"] = 'n';
	}
	if ($templateslib->template_is_in_section($_REQUEST["templateId"], 'newsletters')) {
		$info["section_newsletters"] = 'y';
	} else {
		$info["section_newsletters"] = 'n';
	}
	if ($templateslib->template_is_in_section($_REQUEST["templateId"], 'events')) {
		$info["section_events"] = 'y';
	} else {
		$info["section_events"] = 'n';
	}
	if ($templateslib->template_is_in_section($_REQUEST["templateId"], 'admins')) {
		$info["section_admins"] = 'y';
	} else {
		$info["section_admin"] = 'n';
	}
	if ($templateslib->template_is_in_section($_REQUEST["templateId"], 'cms')) {
		$info["section_cms"] = 'y';
	} else {
		$info["section_cms"] = 'n';
	}
} else {
	$info = array();
	$info["name"] = '';
	$info['template_type'] = 'static';
	$info["content"] = '';
	$info["section_cms"] = 'n';
	$info["section_html"] = 'n';
	$info["section_wiki"] = 'n';
	$info["section_newsletters"] = 'n';
	$info["section_event"] = 'n';
}

$smarty->assign('info', $info);
if (isset($_REQUEST["remove"])) {
	$area = 'delcontenttemplate';
	if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		$templateslib->remove_template($_REQUEST["remove"]);
	} else {
		key_get($area);
	}
}
if (isset($_REQUEST["removesection"])) {
	$area = 'delcontenttemplatefromsection';
	if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		$templateslib->remove_template_from_section($_REQUEST["rtemplateId"], $_REQUEST["removesection"]);
	} else {
		key_get($area);
	}
}
$smarty->assign('preview', 'n');
if (isset($_REQUEST["preview"])) {
	$smarty->assign('preview', 'y');
	if (isset($_REQUEST["section_html"]) && $_REQUEST["section_html"] == 'on') {
		$info["section_html"] = 'y';
		$parsed = nl2br($_REQUEST["content"]);
	} else {
		$info["section_html"] = 'n';
		$parsed = $tikilib->parse_data($_REQUEST["content"]);
	}
	$smarty->assign('parsed', $parsed);
	if (isset($_REQUEST["section_wiki"]) && $_REQUEST["section_wiki"] == 'on') {
		$info["section_wiki"] = 'y';
	} else {
		$info["section_wiki"] = 'n';
	}
	if (isset($_REQUEST["section_newsletters"]) && $_REQUEST["section_newsletters"] == 'on') {
		$info["section_newsletters"] = 'y';
	} else {
		$info["section_newsletters"] = 'n';
	}
	if (isset($_REQUEST["section_events"]) && $_REQUEST["section_events"] == 'on') {
		$info["section_events"] = 'y';
	} else {
		$info["section_events"] = 'n';
	}
	if (isset($_REQUEST["section_cms"]) && $_REQUEST["section_cms"] == 'on') {
		$info["section_cms"] = 'y';
	} else {
		$info["section_cms"] = 'n';
	}
	$info["content"] = $_REQUEST["content"];
	$info["name"] = $_REQUEST["name"];
	$info['page_name'] = $_REQUEST['page_name'];
	$info['template_type'] = $_REQUEST['template_type'];
	$smarty->assign('info', $info);
}
if (isset($_REQUEST["save"])) {
	check_ticket('admin-content-templates');
	$type = $_REQUEST['template_type'];

	if( $type == 'page' ) {
		$content = 'page:' . $_REQUEST['page_name'];
	} else {
		$content = $_REQUEST["content"];
	}

	$tid = $templateslib->replace_template($_REQUEST["templateId"], $_REQUEST["name"], $content, $type);
	$smarty->assign("templateId", '0');
	$info["name"] = '';
	$info["content"] = '';
	$info["section_cms"] = 'n';
	$info["section_wiki"] = 'n';
	$info["section_newsletters"] = 'n';
	$info["section_events"] = 'n';
	$info["section_html"] = 'n';
	$smarty->assign('info', $info);
	if (isset($_REQUEST["section_html"]) && $_REQUEST["section_html"] == 'on') {
		$templateslib->add_template_to_section($tid, 'html');
	} else {
		$templateslib->remove_template_from_section($tid, 'html');
	}
	if (isset($_REQUEST["section_wiki"]) && $_REQUEST["section_wiki"] == 'on') {
		$templateslib->add_template_to_section($tid, 'wiki');
	} else {
		$templateslib->remove_template_from_section($tid, 'wiki');
	}
	if (isset($_REQUEST["section_newsletters"]) && $_REQUEST["section_newsletters"] == 'on') {
		$templateslib->add_template_to_section($tid, 'newsletters');
	} else {
		$templateslib->remove_template_from_section($tid, 'newsletters');
	}
	if (isset($_REQUEST["section_events"]) && $_REQUEST["section_events"] == 'on') {
		$templateslib->add_template_to_section($tid, 'events');
	} else {
		$templateslib->remove_template_from_section($tid, 'events');
	}
	if (isset($_REQUEST["section_cms"]) && $_REQUEST["section_cms"] == 'on') {
		$templateslib->add_template_to_section($tid, 'cms');
	} else {
		$templateslib->remove_template_from_section($tid, 'cms');
	}
}
if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'created_desc';
} else {
	$sort_mode = $_REQUEST["sort_mode"];
}
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
$smarty->assign_by_ref('sort_mode', $sort_mode);
$channels = $templateslib->list_all_templates($offset, $maxRecords, $sort_mode, $find);
$smarty->assign_by_ref('cant_pages', $channels["cant"]);
// wysiwyg decision
include 'lib/setup/editmode.php';
$smarty->assign_by_ref('channels', $channels["data"]);
include_once ("textareasize.php");
ask_ticket('admin-content-templates');
global $wikilib;
include_once ('lib/wiki/wikilib.php');
$plugins = $wikilib->list_plugins(true, 'editwiki');
$smarty->assign_by_ref('plugins', $plugins);
// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');
// Display the template
$smarty->assign('mid', 'tiki-admin_content_templates.tpl');
$smarty->display("tiki.tpl");
