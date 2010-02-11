<?php

// $Id$

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');

$access->check_feature('feature_custom_home');

// Display the template
$smarty->assign('mid', 'tiki-custom_home.tpl');
$smarty->display("tiki.tpl");
