<?php
// (c) Copyright 2002-2012 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

if (strpos($_SERVER["SCRIPT_NAME"], basename(__FILE__)) !== false) {
	header("location: index.php");
	exit;
}

function upgrade_20110830_default_enable_in_use_tiki($installer)
{
	// Autogenerated.
	$map = array (
			'x' => 'trackerfield_action',
			'A' => 'trackerfield_file',
			'q' => 'trackerfield_autoincement',
			'e' => 'trackerfield_category',
			'c' => 'trackerfield_checkbox',
			'C' => 'trackerfield_computed',
			'y' => 'trackerfield_countryselector',
			'b' => 'trackerfield_currency',
			'f' => 'trackerfield_datetime',
			'j' => 'trackerfield_jscalendar',
			'd' => 'trackerfield_dropdown',
			'D' => 'trackerfield_dropdownother',
			'w' => 'trackerfield_dynamiclist',
			'm' => 'trackerfield_email',
			'FG' => 'trackerfield_files',
			'F' => 'trackerfield_freetags',
			'g' => 'trackerfield_groupselector',
			'h' => 'trackerfield_header',
			'i' => 'trackerfield_image',
			'N' => 'trackerfield_ingroup',
			'I' => 'trackerfield_ipaddress',
			'r' => 'trackerfield_itemlink',
			'l' => 'trackerfield_itemslist',
			'LANG' => 'trackerfield_language',
			'P' => 'trackerfield_ldap',
			'G' => 'trackerfield_location',
			'M' => 'trackerfield_multiselect',
			'n' => 'trackerfield_numeric',
			'k' => 'trackerfield_pageselector',
			'R' => 'trackerfield_radio',
			'STARS' => 'trackerfield_rating',
			'REL' => 'trackerfield_relation',
			'*' => 'trackerfield_stars',
			's' => 'trackerfield_starsystem',
			'S' => 'trackerfield_statictext',
			'a' => 'trackerfield_textarea',
			't' => 'trackerfield_text',
			'L' => 'trackerfield_url',
			'usergroups' => 'trackerfield_usergroups',
			'p' => 'trackerfield_userpreference',
			'u' => 'trackerfield_userselector',
			'U' => 'trackerfield_subscription',
			'W' => 'trackerfield_webservice',
		);

	$table = $installer->table('tiki_tracker_fields');
	$types = $table->fetchColumn('type', array());
	$types = array_unique($types);

	$preferences = $installer->table('tiki_preferences');
	foreach ($types as $code) {
		$preferences->insert(
						array(
							'name' => $map[$code],
							'value' => 'y',
						)
		);
	}
}

