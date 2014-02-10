<?php
/**
 * @package tikiwiki
 */
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

require 'tiki-setup.php';

// User preferences screen
if ($prefs['feature_wizard_user'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled") . ": feature_wizard_user");
	$smarty->display("error.tpl");
	die;
}
$access->check_user($user);

require_once('lib/headerlib.php');
$headerlib->add_cssfile('css/wizards.css');

// Hide the display of the preference dependencies in the wizard
$headerlib->add_css('.pref_dependency{display:none !important;}');
$headerlib->add_css('.pagetitle {display: none;}');
					
$accesslib = TikiLib::lib('access');
$accesslib->check_user($user);

// Create the template instances
$pages = array();

/////////////////////////////////////
// BEGIN User Wizard page section
/////////////////////////////////////

require_once('lib/wizard/pages/user_wizard.php'); 
$pages[] = new UserWizard();

require_once('lib/wizard/pages/user_preferences_info.php'); 
$pages[] = new UserWizardPreferencesInfo();

require_once('lib/wizard/pages/user_preferences_params.php'); 
$pages[] = new UserWizardPreferencesParams();

require_once('lib/wizard/pages/user_preferences_reports.php'); 
$pages[] = new UserWizardPreferencesReports();

require_once('lib/wizard/pages/user_preferences_notifications.php'); 
$pages[] = new UserWizardPreferencesNotifications();

require_once('lib/wizard/pages/user_wizard_completed.php'); 
$pages[] = new UserWizardCompleted();

/////////////////////////////////////
// END User Wizard page section
/////////////////////////////////////


// Step the wizard pages
$wizardlib = TikiLib::lib('wizard');
$wizardlib->showPages($pages, true);

// Build the TOC
$toc = '';
$stepNr = 0;
$reqStepNr = $wizardlib->wizard_stepNr;
$homepageUrl = $_REQUEST['url'];
foreach ($pages as $page) {
	global $base_url;
	$cssClasses = '';

	// Start the user wizard
	$url = $base_url.'tiki-wizard_user.php?&amp;stepNr=' . $stepNr . '&amp;url=' . rawurlencode($homepageUrl);

	$cnt = 	$stepNr+1;
	if ($cnt <= 9) {
		$cnt = '&nbsp;&nbsp;'.$cnt;
	}
	$toc .= '<li><a ';
	$cssClasses .= 'adminWizardTOCItem ';
	if ($stepNr == $reqStepNr) {
		$cssClasses .= 'highlight ';
	}
	if (!$page->isVisible()) {
		$cssClasses .= 'disabledTOCSelection ';
	}
	$css = '';
	if (strlen($cssClasses) > 0) {
		$css = 'class="'.$cssClasses.'" ';
	}
	$toc .= $css;
	$toc .= 'href="'.$url.'">'.$page->pageTitle().'</a></li>';
	$stepNr++;
}

	// Hide the left and right sidebars when the admin wizard is run
	$headerlib = TikiLib::lib('header');
	$headerlib->add_js(
<<<JS
	hideCol('col2','left', 'col1');
	hideCol('col3','right', 'col1');
JS
);

if ($reqStepNr > 0) {
	$smarty->assign('wizard_toc', $toc);
}

// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');

$smarty->assign('mid', 'tiki-wizard_user.tpl');
$smarty->display("tiki.tpl");
