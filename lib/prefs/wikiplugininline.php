<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_wikiplugininline_list() {
	global $tikilib;

	$prefs = array();

	foreach( $tikilib->plugin_get_list() as $plugin ) {
		$info = $tikilib->plugin_info( $plugin );

		$prefs['wikiplugininline_' . $plugin] = array(
			'name' => tra('Inline plugin %0 (hide plugin edit icon)', $info['name'] ),
			'description' => tra('When inlined, the plugin edit icon will not appear.'),
			'type' => 'flag',
		);
	}

	return $prefs;
}
