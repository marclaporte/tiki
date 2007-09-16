<?php
// Initialization
require_once('tiki-setup.php');
include_once('lib/directory/dirlib.php');

$tmp1 = isset($_SERVER["SERVER_NAME"]) ? $_SERVER["SERVER_NAME"] : "";
$tmp2 = isset($_SERVER["PHP_SELF"]) ? $_SERVER["PHP_SELF"] : "";

// concat all, remove the // between server and path and then
// remove the name of the script itself:
$url = $tmp1.dirname($tmp2);

$info = Array();
$info["name"] = $tikilib->get_preference( "siteTitle", "" );
$info["description"] = '';
$info["url"] = $url;
$info["country"] = 'None';
$info["isValid"] = 'n';
$smarty->assign_by_ref('info',$info);

$countries = $tikilib->get_flags();
$smarty->assign_by_ref('countries',$countries);

// Display the template
$smarty->assign('mid','tiki-register_site.tpl');
$smarty->display("tiki.tpl");
?>
