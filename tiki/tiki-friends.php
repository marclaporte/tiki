<?php
// Initialization
require_once('tiki-setup.php');
include_once("lib/imagegals/imagegallib.php");
include_once('lib/messu/messulib.php');

if(!$user) {
  $smarty->assign('msg', tra("You must be logged in to use this feature"));
  $smarty->display("error.tpl");
  die;
}

if($feature_friends != 'y') {
  $smarty->assign('msg',tra("This feature is disabled"));
  $smarty->display("error.tpl");
  die;
}

if (isset($_REQUEST['request_friendship'])) {
    $friend = $_REQUEST['request_friendship'];

    if ($userlib->user_exists($friend)) {
	if (!$tikilib->verify_friendship($friend,$user)) {
	    $userlib->request_friendship($user,$friend);
	    $smarty->assign('msg',sprintf(tra("Frienship request sent to %s"), $friend));
	    
	    $messulib->post_message($friend, $user, $friend, '',
				    tra("You're invited to join my network of friends!"),
				    tra('Go to your <a href="tiki-friends.php">friendship network</a> to accept or refuse this request'),
				    3);

	} else {
	    $smarty->assign('msg',sprintf(tra("You're already friend of %s"), $_REQUEST['request_friendship']));
	    $smarty->display("error.tpl");
	    die;
	}
    } else {
	$smarty->assign('msg',tra("Invalid username"));
	    $smarty->display("error.tpl");
	    die;
    }

} elseif (isset($_REQUEST['accept'])) {
    $friend = $_REQUEST['accept'];
    $userlib->accept_friendship($user,$friend);
    $smarty->assign('msg', sprintf(tra('Accepted friendship request from %s'),$friend));

    $messulib->post_message($friend, $user, $friend, '',
			    tra("I have accepted your friendship request!"),
			    '', // Do we need a message?
			    3);


} elseif (isset($_REQUEST['refuse'])) {
    $friend = $_REQUEST['refuse'];
    $userlib->refuse_friendship($user, $friend);
    $smarty->assign('msg', sprintf(tra('Refused friendship request from %s'),$friend));

    // Should we send a message, or that would intimidate refusing friendships?
    // TODO: make it optional
    $messulib->post_message($friend, $user, $friend, '',
			    tra("I have refused your friendship request!"),
			    '',
			    3);


} elseif (isset($_REQUEST['break'])) { 
    $friend = $_REQUEST['break'];
    $userlib->break_friendship($user, $friend);
    $smarty->assign('msg', sprintf(tra('Broke friendship with %s'),$friend));
    
    // Should we send a message, or that would intimidate user?
    // TODO: make it optional
    $messulib->post_message($friend, $user, $friend, '',
			    tra('I have broken our friendship!'),
			    '',
			    3);

}

if(!isset($_REQUEST["sort_mode"])) {
  $sort_mode = $user_list_order;
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

if(isset($_REQUEST["find"])) {
  $find = $_REQUEST["find"];  
} else {
  $find = ''; 
}
$smarty->assign('find',$find);

$smarty->assign('pending_requests',$userlib->list_pending_friendship_requests($user));
$smarty->assign('waiting_requests',$userlib->list_waiting_friendship_requests($user));

$listpages = $tikilib->list_user_friends($user,$offset,$maxRecords,$sort_mode,$find);

// If there're more records then assign next_offset
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

$smarty->assign_by_ref('listpages',$listpages["data"]);

$section='friends';
include_once('tiki-section_options.php');

// Display the template
$smarty->assign('mid','tiki-friends.tpl');
$smarty->display("tiki.tpl");
?>
