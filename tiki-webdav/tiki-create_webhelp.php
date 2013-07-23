<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

require_once ('tiki-setup.php');

include_once ('lib/structures/structlib.php');

function copys($source,$dest)
{
    if (!is_dir($source))
    return 0;
    if (!is_dir($dest))
    {
        mkdir($dest);
    }
    $h=@dir($source);
    while (@($entry=$h->read()) !== false)
    {
        if (($entry!=".")&&($entry!=".."))
        {
            if (is_dir("$source/$entry")&&$dest!=="$source/$entry")
            {
                copys("$source/$entry","$dest/$entry");
            }
            else
            {
                @copy("$source/$entry","$dest/$entry");
            }
        }
    }
    $h->close();
    return 1;
}

function deldirfiles($dir){
  $current_dir = opendir($dir);
  while($entryname = readdir($current_dir)){
     if(is_dir("$dir/$entryname") and ($entryname != "." and $entryname!="..")){
        deldirfiles("${dir}/${entryname}");
     }elseif($entryname != "." and $entryname!=".."){
        unlink("${dir}/${entryname}");
     }
  }
  closedir($current_dir);
}

$access->check_feature('feature_create_webhelp');
$access->check_permission('tiki_p_edit_structures');

$struct_info = $structlib->s_get_structure_info($_REQUEST['struct']);
$smarty->assign_by_ref('struct_info',$struct_info);

if (!$tikilib->user_has_perm_on_object($user,$struct_info["pageName"],'wiki page','tiki_p_view')) {
	$smarty->assign('errortype', 401);
	$smarty->assign('msg',tra('Permission denied. You cannot view this page.'));
	$smarty->display("error.tpl");
	die;
}

if(isset($_REQUEST['create'])) {
  $smarty->assign('generated','y');
  $name=$_REQUEST['name'];
  $dir=$_REQUEST['dir'];
  $smarty->assign('dir',$_REQUEST['dir']);
  $struct=$_REQUEST['struct'];
  $top=$_REQUEST['top'];
//  $top='foo1';
  $output='';
  $output.=tra("TikiHelp WebHelp generation engine. Generating WebHelp using:");
  $output.=tra("<ul><li>Index: <strong>$name</strong></li>");
  $output.=tra("<li>Directory: <strong>$dir</strong></li></ul>");
  $base = "whelp/$dir";
  
  // added 2003-12-19 Checking the permission to write. epolidor
  if (!is_writeable("whelp")) {
    $smarty->assign('msg', tra("You need to change chmod 'whelp' manually to 777"));
    $smarty->display("error.tpl");
    die;
  }
  
  if(!is_dir("whelp/$dir")) { 
    $output.= tra("<p>Creating directory structure in <strong>$base</strong>.</p>");
    mkdir("whelp/$dir");
    mkdir("$base/js");
    mkdir("$base/css");
    mkdir("$base/icons");
    mkdir("$base/menu");
    mkdir("$base/pages");
    mkdir("$base/pages/img");
    mkdir("$base/pages/img/wiki_up");
  }
  $output.=tra("<p>Eliminating previous files.</p>");
  deldirfiles("$base/js");
  deldirfiles("$base/css");
  deldirfiles("$base/icons");
  deldirfiles("$base/menu");
  deldirfiles("$base/pages");
  deldirfiles("$base/pages/img/wiki_up");
  // Copy base files to the webhelp directory
  copys("lib/tikihelp","$base/");
  
  $structlib->structure_to_webhelp($struct,$dir,$top);
  $smarty->assign('generated','y');
}  

$smarty->assign('output', $output);


// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');

// Display the template
$smarty->assign('mid', 'tiki-create_webhelp.tpl');
$smarty->display("tiki.tpl");