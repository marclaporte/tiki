<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-show_user_avatar.php,v 1.5 2003-12-04 10:40:53 mose Exp $

// Copyright (c) 2002-2003, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

# $Header: /cvsroot/tikiwiki/tiki/tiki-show_user_avatar.php,v 1.5 2003-12-04 10:40:53 mose Exp $
include_once("lib/init/initlib.php");
include_once ("tiki-setup_base.php");

include_once ('lib/userprefs/userprefslib.php');

// application to display an image from the database with 
// option to resize the image dynamically creating a thumbnail on the fly.
// you have to check if the user has permission to see this gallery
if (!isset($_REQUEST["user"])) {
	die;
}

$info = $userprefslib->get_user_avatar_img($_REQUEST["user"]);
$type = $info["avatarFileType"];
$content = $info["avatarData"];

header ("Content-type: $type");
echo "$content";

?>
