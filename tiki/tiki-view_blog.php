<?php
// Initialization
require_once('tiki-setup.php');
include_once('lib/blogs/bloglib.php');

if($feature_blogs != 'y') {
  $smarty->assign('msg',tra("This feature is disabled"));
  $smarty->display("styles/$style_base/error.tpl");
  die;  
}

if(!isset($_REQUEST["blogId"])) {
  $smarty->assign('msg',tra("No blog indicated"));
  $smarty->display("styles/$style_base/error.tpl");
  die;  
}

$smarty->assign('individual','n');
if($userlib->object_has_one_permission($_REQUEST["blogId"],'blog')) {
  $smarty->assign('individual','y');
  if($tiki_p_admin != 'y') {
    // Now get all the permissions that are set for this type of permissions 'image gallery'
    $perms = $userlib->get_permissions(0,-1,'permName_desc','','blogs');
    foreach($perms["data"] as $perm) {
      $permName=$perm["permName"];
      if($userlib->object_has_permission($user,$_REQUEST["blogId"],'blog',$permName)) {
        $$permName = 'y';
        $smarty->assign("$permName",'y');
      } else {
        $$permName = 'n';
        $smarty->assign("$permName",'n');
      }
    }
  }
}
if($tiki_p_blog_admin == 'y') {
  $tiki_p_create_blogs = 'y';
  $smarty->assign('tiki_p_create_blogs','y');
  $tiki_p_blog_post = 'y';
  $smarty->assign('tiki_p_blog_post','y');
  $tiki_p_read_blog = 'y';
  $smarty->assign('tiki_p_read_blog','y');
}

if($tiki_p_read_blog != 'y') {
  $smarty->assign('msg',tra("Permission denied you can not view this section"));
  $smarty->display("styles/$style_base/error.tpl");
  die;  
}



$blog_data = $tikilib->get_blog($_REQUEST["blogId"]);
$ownsblog = 'n';
if($user && $user == $blog_data["user"]) {
    $ownsblog = 'y';
}
$smarty->assign('ownsblog',$ownsblog);
if(!$blog_data) {
  $smarty->assign('msg',tra("Blog not found"));
  $smarty->display("styles/$style_base/error.tpl");
  die;  
}
$bloglib->add_blog_hit($_REQUEST["blogId"]);
$smarty->assign('blogId',$_REQUEST["blogId"]);
$smarty->assign('title',$blog_data["title"]);
$smarty->assign('heading',$blog_data["heading"]);
$smarty->assign('use_title',$blog_data["use_title"]);
$smarty->assign('use_find',$blog_data["use_find"]);
$smarty->assign('allow_comments',$blog_data["allow_comments"]);
$smarty->assign('description',$blog_data["description"]);
$smarty->assign('created',$blog_data["created"]);
$smarty->assign('lastModif',$blog_data["lastModif"]);
$smarty->assign('posts',$blog_data["posts"]);
$smarty->assign('public',$blog_data["public"]);
$smarty->assign('hits',$blog_data["hits"]);
$smarty->assign('creator',$blog_data["user"]);
$smarty->assign('activity',$blog_data["activity"]);

if(isset($_REQUEST["remove"])) {
  $data = $bloglib->get_post($_REQUEST["remove"]);
  if(!$ownsblog) {
    if(!$user || $data["user"]!=$user) {
      if($tiki_p_blog_admin != 'y') {
        $smarty->assign('msg',tra("Permission denied you cannot remove the post"));
        $smarty->display("styles/$style_base/error.tpl");
        die;  
      }
    } 
  }
  $bloglib->remove_post($_REQUEST["remove"]);  
}


// This script can receive the thresold
// for the information as the number of
// days to get in the log 1,3,4,etc
// it will default to 1 recovering information for today
if(!isset($_REQUEST["sort_mode"])) {
  $sort_mode = 'created_desc'; 
} else {
  $sort_mode = $_REQUEST["sort_mode"];
} 


$smarty->assign_by_ref('sort_mode',$sort_mode);

// If offset is set use it if not then use offset =0
// use the maxRecords php variable to set the limit
// if sortMode is not set then use lastModif_desc
if(!isset($_REQUEST["offset"])) {
  $offset = 0;
} else {
  $offset = $_REQUEST["offset"]; 
}
$smarty->assign_by_ref('offset',$offset);

$now = date("U");
if(isset($_SESSION["thedate"])) {
  if($_SESSION["thedate"]<$now) {
    $pdate = $_SESSION["thedate"]; 
  } else {
    if($tiki_p_blog_admin == 'y') {
      $pdate = $_SESSION["thedate"]; 
    } else {
      $pdate = $now;
    }
  }
} else {
  $pdate = $now;
}


if(isset($_REQUEST["find"])) {
  $find = $_REQUEST["find"];  
} else {
  $find = ''; 
}
$smarty->assign('find',$find);

// Get a list of last changes to the Wiki database
$listpages = $bloglib->list_blog_posts($_REQUEST["blogId"], $offset, $blog_data["maxPosts"], $sort_mode, $find, $pdate);
for($i=0;$i<count($listpages["data"]);$i++) {
  $listpages["data"][$i]["parsed_data"] = $tikilib->parse_data($bloglib->get_page($listpages["data"][$i]["data"],1));
  //print(htmlspecialchars($listpages["data"][$i]["parsed_data"]));
}
$maxRecords=$blog_data["maxPosts"];
$cant_pages = ceil($listpages["cant"] / $maxRecords);
$smarty->assign_by_ref('cant_pages',$cant_pages);
$smarty->assign('actual_page',1+($offset/$maxRecords));

if($listpages["cant"] > ($offset + $maxRecords)) {
  $smarty->assign('next_offset',$offset + $maxRecords);
} else {
  $smarty->assign('next_offset',-1); 
}
// If offset is > 0 then prev_offset
if($offset>0) {
  $smarty->assign('prev_offset',$offset - $maxRecords);  
} else {
  $smarty->assign('prev_offset',-1); 
}


// If there're more records then assign next_offset
$smarty->assign_by_ref('listpages',$listpages["data"]);
//print_r($listpages["data"]);

if($feature_blog_comments == 'y') {
  $comments_per_page = $blog_comments_per_page;
  $comments_default_ordering = $blog_comments_default_ordering;
  $comments_vars=Array('blogId');
  $comments_prefix_var='blog';
  $comments_object_var='blogId';
  include_once("comments.php");
}

$section='blogs';
include_once('tiki-section_options.php');

if($feature_theme_control == 'y') {
	$cat_type='blog';
	$cat_objid = $_REQUEST['blogId'];
	include('tiki-tc.php');
}

if($user 
	&& $tiki_p_notepad == 'y' 
	&& $feature_notepad == 'y' 
	&& isset($_REQUEST['savenotepad'])) {
  $post_info = $bloglib->get_post($_REQUEST['savenotepad']);	
  $tikilib->replace_note($user,0,$post_info['title']?$post_info['title']:date("d/m/Y [h:i]",$post_info['created']),$post_info['data']);
}

if($feature_user_watches == 'y') {
	if($user && isset($_REQUEST['watch_event'])) {
	  if($_REQUEST['watch_action']=='add') {
	    $tikilib->add_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object'],tra('blog'),$info['title'],"tiki-view_blog.php?blogId=".$_REQUEST['blogId']);
	  } else {
	    $tikilib->remove_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object']);
	  }
	}
	$smarty->assign('user_watching_blog','n');
	if($user && $watch = $tikilib->get_user_event_watches($user,'blog_post',$_REQUEST['blogId'])) {
		$smarty->assign('user_watching_blog','y');
	}
}



// Display the template
$smarty->assign('mid','tiki-view_blog.tpl');
$smarty->display("styles/$style_base/tiki.tpl");
?>
