<?php
// Initialization
require_once('tiki-setup.php');

if($forgotPass != 'y') {
    $smarty->assign('msg',tra("This feature is disabled"));
    $smarty->display('error.tpl');
    die;
}


$smarty->assign('showmsg','n');
if(isset($_REQUEST["remind"])) {
  if($tikilib->user_exists($_REQUEST["username"])) {
    $pass = $tikilib->get_user_password($_REQUEST["username"]);
    $email = $tikilib->get_user_email($_REQUEST["username"]);
    $msg = tra('Someone from ').$_SERVER["SERVER_NAME"].tra(' requested to send the password for ').$_REQUEST["username"].tra(' by email to our registered email address')."\n".tra(' and the requested password is ').$pass;
    @mail($email,tra('your account information for ').$_SERVER["SERVER_NAME"],$msg);
    $smarty->assign('showmsg','y');
    $smarty->assign('msg',tra('You will receive an email with your password soon'));
  }
}

// Display the template
$smarty->assign('mid','tiki-remind_password.tpl');
$smarty->display('tiki.tpl');
?>