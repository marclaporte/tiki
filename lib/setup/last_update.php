<?php

// $Id$
// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for
// details.

//this script may only be included - so its better to die if called directly.
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

/* trick for use with doc/devtools/cvsup.sh */
if ( is_file('.lastup') and is_readable('.lastup') ) {
	$lastup = file('.lastup');
	$smarty->assign('lastup', trim($lastup[0]));
}
