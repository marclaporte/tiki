<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_conditions_list()
{
	return array(
		'conditions_enabled' => array(
			'name' => tr('Terms and Conditions'),
			'description' => tr('Automatically present a terms page to be accepted by users accessing the site.'),
			'dependencies' => array('feature_wiki'),
			'help' => 'Terms+and+Conditions',
			'type' => 'flag',
			'default' => 'n',
		),
		'conditions_page_name' => array(
			'name' => tr('Terms and Conditions page name'),
			'description' => tr('Wiki page to use as the source content. The page may be translated using the multilingual feature.'),
			'type' => 'text',
			'filter' => 'pagename',
			'default' => 'Terms',
		),
	);
}
