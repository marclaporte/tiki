<?php
class Lslib {

  function Lslib($db) 
  {
    if(!$db) {
      die("Invalid db object passed to Lslib constructor");  
    }
    $this->db = $db;
  }

  // Queries the database reporting an error if detected
  function query($query,$reporterrors=true) {
    $result = $this->db->query($query);
    if(DB::isError($result) && $reporterrors) $this->sql_error($query,$result);
    return $result;
  }

  // Gets one column for the database.
  function getOne($query,$reporterrors=true) {
    $result = $this->db->getOne($query);
    if(DB::isError($result) && $reporterrors) $this->sql_error($query,$result);
    return $result;
  }
  
  // Reports SQL error from PEAR::db object.
  function sql_error($query, $result)
  {
    trigger_error("MYSQL error:  ".$result->getMessage()." in query:<br/>".$query."<br/>",E_USER_WARNING);
    die;
  }

  function new_user_request($user,$tiki_user,$email,$reason,$user_id)
  {
    $reqId = md5(uniqid('.'));
    $user = addslashes($user);
    $tiki_user = addslashes($tiki_user);
    $email = addslashes($email);
    $reason = addslashes($reason);
    $now = date("U");
  	$query = "insert into tiki_live_support_requests(reqId,user,tiki_user,email,reason,req_timestamp,status,timestamp,operator,chat_started,chat_ended,operator_id,user_id)
  	values('$reqId','$user','$tiki_user','$email','$reason',$now,'active',$now,'',0,0,'','$user_id')";
  	$this->query($query);
  	return $reqId;
  }
  
  function get_last_request()
  {
  	$x =  $this->getOne("select max(timestamp) from tiki_live_support_requests");
  	if($x) return $x; else return 0;
  }
  
  // Remove active requests 
  function purge_requests()
  {
  
  }
  
  // Get status for request
  function get_request_status($reqId)
  {
  	return $this->getOne("select status from tiki_live_support_requests where reqId='$reqId'");
  }
  
  // Accepts a request, change status to op_accepted
  function operator_accept($reqId,$user,$operator_id)
  {
  	$now = date("U");
  	$query = "update tiki_live_support_requests set operator_id='$operator_id',operator='$user',status='op_accepted',timestamp=$now,chat_started=$now where reqId='$reqId'";
  	$this->query($query);
  }
  
  
  function user_close_request($reqId)
  {
  	if(!$reqId) return;
  	$now = date("U");
  	$query = "update tiki_live_support_requests set status='user closed',timestamp=$now,chat_ended=$now where reqId='$reqId'";
  	$this->query($query);
  }
  
  function operator_close_request($reqId)
  {
  	if(!$reqId) return;
  	$now = date("U");
  	$query = "update tiki_live_support_requests set status='operator closed',timestamp=$now,chat_ended=$now where reqId='$reqId'";
  	$this->query($query);
  }

  
  function get_active_requests()
  {
  	$this->purge_requests();
  	$query = "select * from tiki_live_support_requests where status='active'";
  	$result = $this->query($query);
    $ret = Array();
    while($res = $result->fetchRow(DB_FETCHMODE_ASSOC)) {
    	$ret[] = $res;
    }
    return $ret;
  }
  
  //EVENT HANDLING
  function get_new_events($reqId,$senderId,$last)
  {
  	$query = "select * from tiki_live_support_events where senderId='$senderId' and reqId='$reqId' and eventId>$last";
  	$result = $this->query($query);
    $ret = '';
    $ret='<?xml version="1.0" ?>';
    $ret.='<events>';
    while($res = $result->fetchRow(DB_FETCHMODE_ASSOC)) {
    	$ret .= '<event>'.'<data>'.$res['data'].'</data></event>';
    }
    $ret.='</events>';
	return $ret;  
  }
  
  function get_last_event($reqId,$senderId)
  {
  	return $this->getOne("select max(seqId) from tiki_live_support_events where senderId<>'$senderId' and reqId='$reqId'");
  }
  
  function get_event($reqId,$event,$senderId)
  {
  	return $this->getOne("select data from tiki_live_support_events where senderId<>'$senderId' and reqId='$reqId' and seqId=$event");
  }
  
  function put_message($reqId,$msg,$senderId)
  {
  	$now = date("U");
  	$seq = $this->getOne("select max(seqId) from tiki_live_support_events where reqId='$reqId'");
  	if(!$seq) $seq = 0;
  	$seq++;
  	$query = "insert into tiki_live_support_events(seqId,reqId,type,senderId,data,timestamp)
  	values($seq,'$reqId','msg','$senderId','$msg',$now)";
  	$this->query($query);
  }
  
    

}

$lslib= new Lslib($dbTiki);
?>
