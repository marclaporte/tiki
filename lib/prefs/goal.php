<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_goal_list()
{
	return array(
		'goal_enabled' => array(
			'name' => tr('Goal, Recognition and Rewards'),
			'description' => tr('A tool to set motivational goals to increase engagement on the site.'),
			'type' => 'flag',
			'default' => 'n',
		),
	);
}

