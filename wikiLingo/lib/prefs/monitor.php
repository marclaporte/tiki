<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_monitor_list()
{
	return array(
		'monitor_enabled' => array(
			'name' => tr('Notifications'),
			'description' => tr('Allows users to control the notifications they receive based on content changes.'),
			'type' => 'flag',
			'default' => 'n',
		),
		'monitor_digest' => array(
			'name' => tr('Notification Digests'),
			'description' => tr('Enable the digest notifications, requires cron job'),
			'type' => 'flag',
			'default' => 'n',
		),
		'monitor_individual_clear' => array(
			'name' => tr('Clear individual notifications'),
			'description' => tr('Allow users to selectively clear notifications instead of simply having a clear-all button.'),
			'type' => 'flag',
			'default' => 'n',
		),
	);
}

