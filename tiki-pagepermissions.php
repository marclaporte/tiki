<?php
include_once("tiki-setup.php");

if($feature_wiki != 'y') {
  $smarty->assign('msg',tra("This feature is disabled"));
  $smarty->display('error.tpl');
  die;  
}


include_once("tiki-pagesetup.php");
// Now check permissions to access this page

  if($tiki_p_admin_wiki != 'y') {
    $smarty->assign('msg',tra("Permission denied you cannot assign permissions for this page"));
    $smarty->display('error.tpl');
    die;  
  }



// Get the page from the request var or default it to HomePage
if(!isset($_REQUEST["page"])) {
  $smarty->assign('msg',tra("No page indicated"));
  $smarty->display('error.tpl');
  die;
} else {
  $page = $_REQUEST["page"];
  $smarty->assign_by_ref('page',$_REQUEST["page"]); 
}

if(isset($_REQUEST["addemail"])) {
  $tikilib->add_mail_event('wiki_page_changes','wikipage'.$_REQUEST["page"],$_REQUEST["email"]);
}
if(isset($_REQUEST["removeemail"])) {
  $tikilib->remove_mail_event('wiki_page_changes','wikipage'.$_REQUEST["page"],$_REQUEST["removeemail"]);
}
$emails=$tikilib->get_mail_events('wiki_page_changes','wikipage'.$_REQUEST["page"]);
$smarty->assign('emails',$emails);

if(!$tikilib->page_exists($page)) {
  $smarty->assign('msg',tra("Page cannot be found"));
  $smarty->display('error.tpl');
  die;
}

// Process the form to assign a new permission to this page
if(isset($_REQUEST["assign"])) {
  $userlib->assign_object_permission($_REQUEST["group"],$page,'wiki page',$_REQUEST["perm"]);
}

// Process the form to remove a permission from the page
if(isset($_REQUEST["action"])) {
  if($_REQUEST["action"] == 'remove') {
    $userlib->remove_object_permission($_REQUEST["group"],$page,'wiki page',$_REQUEST["perm"]);  
  }  
}

// Now we have to get the individual page permissions if any
$page_perms = $userlib->get_object_permissions($page,'wiki page');
$smarty->assign_by_ref('page_perms',$page_perms);





// Get a list of groups
$groups = $userlib->get_groups(0,-1,'groupName_desc');
$smarty->assign_by_ref('groups',$groups["data"]);


// Get a list of permissions
$perms = $userlib->get_permissions(0,-1,'permName_desc','','wiki');
$smarty->assign_by_ref('perms',$perms["data"]);


$smarty->assign('mid','tiki-pagepermissions.tpl');
$smarty->assign('show_page_bar','y');
$smarty->display('tiki.tpl');

?>