<?php

// $Id$

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// To (re-)enable this script the file has to be named tiki-installer.php and the following four lines
// must start with two '/' and 'stopinstall:'. (Make sure there are no spaces inbetween // and stopinstall: !)

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

require_once( 'tiki-filter-base.php' );

// Define and load Smarty components
define('SMARTY_DIR', "lib/smarty/libs/");
require_once ( 'lib/smarty/libs/Smarty.class.php');
require_once ('installer/installlib.php');

$commands = array();
@ini_set('magic_quotes_runtime',0);

// Initialize $prefs and force some values for the installer
$prefs = array(
	// tra() should not use $tikilib because this lib is not available in every steps of the installer
	//  and because we want to be sure that translations of the installer are the original ones, even for an upgrade
	'lang_use_db' => 'n' 
);

// Which step of the installer
if (empty($_REQUEST['install_step'])) {
	$install_step = '0'; } else {
	$install_step = ($_REQUEST['install_step']);
} 

if (!empty($_REQUEST['lang'])) {
	$language = $prefs['site_language'] = $prefs['language'] = $_REQUEST['lang'];
} else {
	$language = $prefs['site_language'] = $prefs['language'] = 'en';
}
include_once('lib/init/tra.php');

function list_tables( $dbTiki )
{
	static $list = array();
	if( $list )
		return $list;

	$result = $dbTiki->Execute( "show tables" );

	if (!$result) {
		return $list;
	}

	while( $row = $result->fetchRow() )
		$list[] = reset( $row );

	return $list;
}

function has_tiki_db( $dbTiki )
{
	return in_array( 'users_users', list_tables( $dbTiki ) );
}

function has_tiki_db_20( $dbTiki )
{
	return in_array( 'tiki_pages_translation_bits', list_tables( $dbTiki ) );
}

function process_sql_file($file,$db_tiki) {
	global $dbTiki;
	if ( ! is_object($dbTiki) ) return false;

	global $succcommands;
	global $failedcommands;
	global $smarty;
	if(!isset($succcommands)) {
	  $succcommands=array();
	  $failedcommands=array();
	}

	$command = '';
	if ( !is_file("db/$file") || !$fp = fopen("db/$file", "r") ) {
		print('Fatal: Cannot open db/'.$file);
		exit(1);
	}

	while(!feof($fp)) {
		$command.= fread($fp,4096);
	}

	switch ( $db_tiki ) {
	  case 'sybase': $statements = split("(\r|\n)go(\r|\n)", $command); break;
          case 'mssql': $statements = split("(\r|\n)go(\r|\n)", $command); break;
	  case 'oci8': $statements = preg_split("#(;\s*\n)|(\n/\n)#", $command); break;
	  default: $statements = preg_split("#(;\s*\n)|(;\s*\r\n)#", $command); break;
	}
	$prestmt="";
	$do_exec=true;
	foreach ($statements as $statement) {
		//echo "executing $statement </br>";
			if (trim($statement)) {
				switch ($db_tiki) {
				case "oci8":
					// we have to preserve the ";" in sqlplus programs (triggers)
					if (preg_match("/BEGIN/",$statement)) {
						$prestmt=$statement.";";
						$do_exec=false;
					}
					if (preg_match("/END/",$statement)) {
						$statement=$prestmt."\n".$statement.";";
						$do_exec=true;
					}
					if($do_exec) $result = $dbTiki->Execute($statement);
					break;
				default:
					$result = $dbTiki->Execute($statement);
					break;
			}

			if (!$result) {
				$failedcommands[]= "Command: ".$statement."\nMessage: ".$dbTiki->ErrorMsg()."\n\n";
				//trigger_error("DB error:  " . $dbTiki->ErrorMsg(). " in query:<br /><pre>" . $command . "<pre/><br />", E_USER_WARNING);
				// Do not die at the moment. We need some better error checking here
				//die;
			} else {
				$succcommands[]=$statement;
			}
		}
	}
	$dbTiki->Execute("update `tiki_preferences` set `value`=`value`+1 where `name`='lastUpdatePrefs'");
	unset($_SESSION['s_prefs']);

	$smarty->assign_by_ref('succcommands', $succcommands);
	$smarty->assign_by_ref('failedcommands', $failedcommands);
}

function write_local_php($dbb_tiki,$host_tiki,$user_tiki,$pass_tiki,$dbs_tiki,$dbversion_tiki="4.0") {
	global $local;
	global $db_tiki;
	if ($dbs_tiki and $user_tiki) {
		$db_tiki=addslashes($dbb_tiki);
		$host_tiki=addslashes($host_tiki);
		$user_tiki=addslashes($user_tiki);
		$pass_tiki=addslashes($pass_tiki);
		$dbs_tiki=addslashes($dbs_tiki);
		$fw = fopen($local, 'w');
		$filetowrite="<?php\n\$db_tiki='".$db_tiki."';\n";
		$filetowrite.="\$dbversion_tiki='".$dbversion_tiki."';\n";
		$filetowrite.="\$host_tiki='".$host_tiki."';\n";
		$filetowrite.="\$user_tiki='".$user_tiki."';\n";
		$filetowrite.="\$pass_tiki='".$pass_tiki."';\n";
		$filetowrite.="\$dbs_tiki='".$dbs_tiki."';\n";
		$filetowrite.="?>";
		fwrite($fw, $filetowrite);
		fclose ($fw);
	}
}

function create_dirs($domain=''){
	global $docroot;
	$dirs=array(
		'db',
		'dump',
		'img/wiki',
		'img/wiki_up',
		'img/trackers',
		'modules/cache',
		'temp',
		'temp/cache',
		'templates_c',
		'templates',
		'styles',
		'whelp');

  if (file_exists('lib/Galaxia'))
    array_push($dirs, 'lib/Galaxia/processes');

	$ret = "";
  foreach ($dirs as $dir) {
		$dir = $dir.'/'.$domain;
		// Create directories as needed
		if (!is_dir($dir)) {
			@mkdir($dir,02775);
		}
		@chmod($dir,02775);
		// Check again and report problems
		if (!is_dir($dir)) {
			$ret .= "The directory '$docroot/$dir' does not exist.\n";
		} else if (!is_writeable($dir)) {
			@chmod($dir,02777);
			if (!is_writeable($dir)) {
				$ret .= "The directory '$docroot/$dir' is not writeable.\n";
			}
		}
	}
	return $ret;
}

function isWindows() {
	static $windows;

	if (!isset($windows)) {
		$windows = substr(PHP_OS, 0, 3) == 'WIN';
	}

	return $windows;
}

class Smarty_Tikiwiki_Installer extends Smarty {

	function Smarty_Tikiwiki_Installer() {
		parent::Smarty();
		$this->template_dir = "templates/";
		$this->compile_dir = "templates_c/";
		$this->config_dir = "configs/";
		$this->cache_dir = "cache/";
		$this->caching = false;
		$this->assign('app_name', 'Tikiwiki');
		$this->plugins_dir = array(
			dirname(dirname(SMARTY_DIR))."/smarty_tiki",
			SMARTY_DIR."plugins"
		);
                // we cannot use subdirs in safe mode
                if(ini_get('safe_mode')) {
                        $this->use_sub_dirs = false;
                }
	//$this->debugging = true;
	//$this->debug_tpl = 'debug.tpl';
	}

	function fetch($_smarty_tpl_file, $_smarty_cache_id = null, $_smarty_compile_id = null, $_smarty_display = false) {
		global $language;
		$_smarty_cache_id = $language . $_smarty_cache_id;
		$_smarty_compile_id = $language . $_smarty_compile_id;
		return parent::fetch($_smarty_tpl_file, $_smarty_cache_id, $_smarty_compile_id, $_smarty_display);
	}
}

function kill_script() {
	/*Header ('Location: tiki-install_disable.php');
	die;*/

	$remove = 'no';
	if (isset($_REQUEST['remove'])) $remove = 'yes';
	$removed = false;
	$fh = fopen('installer/tiki-installer.php', 'rb');
	$data = fread($fh, filesize('installer/tiki-installer.php'));
	fclose($fh);

	if (is_writable("installer/tiki-installer.php")) {
		/* first try to delete the file if requested */
		if ($remove=='yes' && @unlink("installer/tiki-installer.php")) {
			$removed = true;
		}
		/* if it fails, then try to rename it */
		else if (@rename("installer/tiki-installer.php","installer/tiki-installer.done")) {
			$removed = true;
		}
		/* otherwise here's an attempt to change the content of the file to prevent execution */
		else {
			$data = preg_replace('/\/\/stopinstall:/', '', $data);
			$fh = fopen('installer/tiki-installer.php', 'wb');
			if (fwrite($fh, $data) > 0) {
				$removed = true;
			}
			fclose($fh);
		}
	}

	if ($removed == true) {
		header ('location: tiki-index.php');
	} else { // TODO: display this via translantable error msg template ?
		print "<html><head><title>Ooops !</title></head><body>
<h1 style='color: red'>Ooops !</h1>
<p>Tikiwiki installer failed to rename the <b>installer/tiki-installer.php</b> file.</p>
<p style='border: solid 1px red; margin: 0 10% 0 10%; text-align: center; width: 80%'>Leaving this file on a publicly accessible site is a <strong>security risk</strong>.</p>
<p>Please remove or rename the <b>installer/tiki-installer.php</b> from your Tiki installation folder 'manually' (e.g. using SSH or FTP).
<strong>Somebody else could be potentially able to wipe out your Tikiwiki database if you do not remove or rename this file !</strong></p>
<p><a href='index.php'>Proceed to your site</a> after you have removed or renamed <b>installer/tiki-installer.php</b>.</p>
<p style='text-align: right'>Thank you</p>
</body></html>";
	}
	die;
}

function check_session_save_path() {
	global $errors;
	if (ini_get('session.save_handler') == 'files') {
        	$save_path = ini_get('session.save_path');
		// check if we can check it. The session.save_path can be outside
		// the open_basedir paths.
		$open_basedir=ini_get('open_basedir');
		if (empty($open_basedir)) {
        		if (!is_dir($save_path)) {
                		$errors .= "The directory '$save_path' does not exist or PHP is not allowed to access it (check open_basedir entry in php.ini).\n";
        		} else if (!is_writeable($save_path)) {
                		$errors .= "The directory '$save_path' is not writeable.\n";
        		}
		}

        	if ($errors) {
                	$save_path = TikiInit::tempdir();

                	if (is_dir($save_path) && is_writeable($save_path)) {
                        	ini_set('session.save_path', $save_path);

                        	$errors = '';
                	}
        	}
	}
}

function get_webserver_uid() {
	global $wwwuser;
	global $wwwgroup;
	$wwwuser = '';
	$wwwgroup = '';

	if (isWindows()) {
        	$wwwuser = 'SYSTEM';

        	$wwwgroup = 'SYSTEM';
	}

	if (function_exists('posix_getuid')) {
        	$user = @posix_getpwuid(@posix_getuid());

        	$group = @posix_getpwuid(@posix_getgid());
        	$wwwuser = $user ? $user['name'] : false;
        	$wwwgroup = $group ? $group['name'] : false;
	}

	if (!$wwwuser) {
        	$wwwuser = 'nobody (or the user account the web server is running under)';
	}

	if (!$wwwgroup) {
        	$wwwgroup = 'nobody (or the group account the web server is running under)';
	}
}

function error_and_exit() {
	global $errors, $docroot, $wwwgroup, $wwwuser;

        $PHP_CONFIG_FILE_PATH = PHP_CONFIG_FILE_PATH;

        $httpd_conf = 'httpd.conf';
/*
        ob_start();
        phpinfo (INFO_MODULES);

        if (preg_match('/Server Root<\/b><\/td><td\s+align="left">([^<]*)</', ob_get_contents(), $m)) {
                $httpd_conf = $m[1] . '/' . $httpd_conf;
        }

        ob_end_clean();
*/

        print "<html><body>\n<h2><IMG SRC=\"img/tiki/tikilogo.png\" ALT=\"\" BORDER=0><br /\>
	<font color='red'>Tiki Installer cannot proceed</font></h2>\n<pre>\n$errors";

        if (!isWindows()) {
                print "<br /><br />Your options:


1- With FTP access:
	a) Change the permissions (chmod) of the directories to 777.
	b) Create any missing directories
	c) <a href='tiki-install.php'>Execute the Tiki installer again</a> (Once you have executed these commands, this message will disappear!)

or

2- With shell (SSH) access, you can run the command below.

	a) To run setup.sh, follow the instructions:
		\$ cd $docroot
		\$ sh setup.sh

		The script will offer you options depending on your server configuration.

	b) <a href='tiki-install.php'>Execute the Tiki installer again</a> (Once you have executed these commands, this message will disappear!)


<hr>
If you have problems accessing a directory, check the open_basedir entry in
$PHP_CONFIG_FILE_PATH/php.ini or $httpd_conf.

<hr>

<a href='http://doc.tikiwiki.org/Installation' target='_blank'>Consult the tikiwiki.org installation guide</a> if you need more help or <a href='http://tikiwiki.org/tiki-forums.php' target='_blank'>visit the forums</a>

";
        }
	print "</pre></body></html>";
        exit;
}



function has_admin() {
        // Try to see if we have an admin account
	global $dbTiki;
	global $admin_acc;
        $query = "select hash from users_users where login='admin'";

        @$result = $dbTiki->Execute($query);

        if (!$result) {
                $admin_acc = 'n';
        } else {
                if ($result->numRows()) {
                        $res = $result->fetchRow();

                        if (isset($res['hash'])) {
                                $admin_acc = 'y';
                        } else {
                                $admin_acc = 'n';
                        }
                } else {
                        $admin_acc = 'n';
                }
        }
}

function get_admin_email( $dbTiki ) {
	$query = "SELECT `email` FROM `users_users` WHERE `userId`=1";
	@$result = $dbTiki->Execute($query);

	if ( $result && $res = $result->fetchRow() ) {
		return $res['email'];
	}

	return false;
}

function update_preferences( $dbTiki, &$prefs ) {
	$query = "SELECT `name`, `value` FROM `tiki_preferences`";
	@$result = $dbTiki->Execute($query);

	if ( $result ) {
		while ( $res = $result->fetchRow() ) {
			if ( ! isset($prefs[$res['name']]) ) {
				$prefs[$res['name']] = $res['value'];
			}
		}
		return true;
	}

	return false;
}

function load_sql_scripts() {
	global $smarty;
	global $dbversion_tiki;
	$files = array();
	$h = opendir('db/');
	//echo $dbversion_tiki . "---";

	while ($file = readdir($h)) {
        	if (preg_match('#\d\..*to.*\.sql$#',$file) || preg_match('#secdb#',$file)) {
                	$files[] = $file;
        	}
	}

	closedir ($h);
	rsort($files);
	reset($files);
	$smarty->assign('files', $files);
}

// from PHP manual (ini-get function example)
function return_bytes( $val ) {
	$val = trim($val);
	$last = strtolower($val{strlen($val)-1});
	switch ( $last ) {
		// The 'G' modifier is available since PHP 5.1.0
		case 'g': $val *= 1024;
		case 'm': $val *= 1024;
		case 'k': $val *= 1024;
	}
	return $val;
}

// -----------------------------------------------------------------------------
// end of functions .. now starts the processing

// After install. This should remove this script.
if (isset($_REQUEST['kill'])) {
	kill_script();
	die;
}

if (is_file('db/virtuals.inc')) {
	$virtuals = array_map('trim',file('db/virtuals.inc'));
	foreach ($virtuals as $v) {
		if ($v) {
			if (is_file("db/$v/local.php") and is_readable("db/$v/local.php")) {
				$virt[$v] = 'y';
			} else {
				$virt[$v] = 'n';
			}
		}
	}
} else {
	$virt = false;
	$virtuals = false;
}

$multi = '';
if ($virtuals) {
	if (isset($_REQUEST['multi']) and in_array($_REQUEST['multi'],$virtuals)) {
		$multi = $_REQUEST['multi'];
	} else {
		if (isset($_SERVER['TIKI_VIRTUAL']) and is_file('db/'.$_SERVER['TIKI_VIRTUAL'].'/local.php')) {
			$multi = $_SERVER['TIKI_VIRTUAL'];
		} elseif (isset($_SERVER['SERVER_NAME']) and is_file('db/'.$_SERVER['SERVER_NAME'].'/local.php')) {
			$multi = $_SERVER['SERVER_NAME'];
		} elseif (isset($_SERVER['HTTP_HOST']) and is_file('db/'.$_SERVER['HTTP_HOST'].'/local.php')) {
			$multi = $_SERVER['HTTP_HOST'];
		}
	}
}
if (!empty($multi)) {
	$local = "db/$multi/local.php";
} else {
	$local = 'db/local.php';
}
$tikidomain = $multi;
include 'lib/cache/cachelib.php';
$cachelib->empty_full_cache();

$_SESSION["install-logged-$multi"] = 'y';

// Init smarty
$smarty = new Smarty_Tikiwiki_Installer();
$smarty->load_filter('pre', 'tr');
$smarty->load_filter('output', 'trimwhitespace');
$smarty->assign('mid', 'tiki-install.tpl');
$smarty->assign('style', 'thenews.css');
$smarty->assign('virt', isset($virt) ? $virt : null );
$smarty->assign('multi', isset($multi) ? $multi : null );
if ($language != 'en')
	$smarty->assign('lang', $language);

// Try to set a longer execution time for the installer
@ini_set('max_execution_time','0');
$max_execution_time = ini_get('max_execution_time');
if ($max_execution_time != 0) {
	$smarty->assign('max_exec_set_failed', 'y');	
}

// Tiki Database schema version
include_once ('lib/setup/twversion.class.php');
$TWV = new TWVersion();
$smarty->assign('tiki_version_name', preg_replace('/^(\d+\.\d+)([^\d])/', '\1 \2', $TWV->version));

// Available DB Servers
$dbservers = array();
if ( function_exists('mysqli_connect') ) $dbservers['mysqli'] = tra('MySQL Improved (mysqli). Requires MySQL 4.1+');
if ( function_exists('mysql_connect') ) $dbservers['mysql'] = tra('MySQL classic (mysql)');
if ( function_exists('pg_connect') ) $dbservers['pgsql'] = tra('PostgreSQL 8.3+');
if ( function_exists('oci_connect') ) $dbservers['oci8'] = tra('Oracle');
if ( function_exists('sybase_connect') ) $dbservers['sybase'] = tra('Sybase');
if ( function_exists('sqlite_open') ) $dbservers['sqlite'] = tra('SQLLite');
if ( function_exists('mssql_connect') ) $dbservers['mssql'] = tra('MSSQL');
$smarty->assign_by_ref('dbservers', $dbservers);

$errors = '';

// changed to path_translated 28/4/04 by damian
// for IIS compatibilty
if (empty($_SERVER['PATH_TRANSLATED'])) {
	// in PHP5, $_SERVER['PATH_TRANSLATED'] is no longer set
	// the following is hopefully a good workaround
	// nope, it wasn't - PHP5 doesn't allow pass-by-reference
	$myFooVarForIncludeFiles = get_included_files();
	$_SERVER['PATH_TRANSLATED'] = array_shift($myFooVarForIncludeFiles);
}
$docroot = dirname($_SERVER['PATH_TRANSLATED']);

check_session_save_path();

get_webserver_uid();

$errors .= create_dirs($multi);

if ($errors) {
	error_and_exit();
}

// Second check try to connect to the database
// if no local.php => no con
// if local then build dsn and try to connect
//   then get con or nocon

//adodb settings

define('ADODB_FORCE_NULLS', 1);
define('ADODB_ASSOC_CASE', 2);
define('ADODB_CASE_ASSOC', 2); // typo in adodb's driver for sybase?
include_once ('lib/adodb/adodb.inc.php');

include('lib/tikilib.php');

// Get list of available languages
$languages = array();
$languages = TikiLib::list_languages(false,null,true);
$smarty->assign_by_ref("languages", $languages);

// next block checks if there is a local.php and if we can connect through this.
// sets $dbcon to false if there is no valid local.php
if (!file_exists($local)) {
	$dbcon = false;
	$smarty->assign('dbcon', 'n');
	if ($install_step == '3') {
		$install_step = '3';
	}
} else {
	// include the file to get the variables
	include ($local);
	if ( $dbversion_tiki == '1.10' ) $dbversion_tiki = '2.0';

	if (!isset($db_tiki)) {
		//upgrade from 2.0 : if no db is specified, use the first db that this php installation can handle
		$db_tiki = reset($dbservers);
		write_local_php($db_tiki,$host_tiki,$user_tiki,$pass_tiki,$dbs_tiki);
		$_SESSION[$cookie_name] = 'admin';
	}

	if ($db_tiki == 'sybase') {
	        // avoid database change messages
		ini_set('sybct.min_server_severity', '11');
	}

	$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;

	// avoid errors in ADONewConnection() (wrong darabase driver etc...)
	if( ! isset($dbservers[$db_tiki]) ) {
		$dbcon = false;
		$smarty->assign('dbcon', 'n');
	} else {
		$dbTiki = ADONewConnection($db_tiki);
		$db = new TikiDb_Adodb( $dbTiki );
		$db->setErrorHandler( new InstallerDatabaseErrorHandler );
		TikiDb::set( $db );

		if (!$dbTiki->Connect($host_tiki, $user_tiki, $pass_tiki, $dbs_tiki)) {
			$dbcon = false;
			$smarty->assign('dbcon', 'n');
			$tikifeedback[] = array('num'=>1,'mes'=>$dbTiki->ErrorMsg());
		} else {
			$dbcon = true;
			if (!isset($_REQUEST['reset'])) {
				$smarty->assign('dbcon', 'y');
				$smarty->assign('resetdb', 'n');
			} else {
				$smarty->assign('dbcon', 'y');
				$smarty->assign('resetdb', 'y');
			}
		}
	}
}

if ($dbcon) {
	has_admin();
}

if ($admin_acc=='n') {
        $smarty->assign('noadmin', 'y');
} else {
        $smarty->assign('noadmin', 'n');
}


// We won't update database info unless we can't connect to the
// database.
// we won't reset the db connection if there is a admin account set
// and the admin is not logged
//debugging:
/*
if ($dbcon) echo "dbcon true <br>";
if ($_REQUEST['resetdb']=='y') echo '$_REQUEST[resetdb]==y<br>';
if (isset($_REQUEST['dbinfo'])) echo '$_REQUEST[dbinfo] is set<br>';
if (isset($_SESSION['install-logged'])) {echo '$_SESSION[install-logged] is set<br>';
 if ($_SESSION['install-logged']=='y') echo '$_SESSION[install-logged]==y<br>';
}
echo "admin_acc=$admin_acc<br>";
*/
if ((!$dbcon or (isset($_REQUEST['resetdb']) and $_REQUEST['resetdb']=='y' &&
		($admin_acc=='n' || (isset($_SESSION["install-logged-$multi"]) && $_SESSION["install-logged-$multi"]=='y'))
	)) && isset($_REQUEST['dbinfo'])) {

	$dbTiki = &ADONewConnection($_REQUEST['db']);
	$db = new TikiDb_Adodb( $dbTiki );
	$db->setErrorHandler( new InstallerDatabaseErrorHandler );
	TikiDb::set( $db );

	if (isset($_REQUEST['name']) and $_REQUEST['name']) {
		if (!@$dbTiki->Connect($_REQUEST['host'], $_REQUEST['user'], $_REQUEST['pass'], $_REQUEST['name'])) {
			$dbcon = false;
			$smarty->assign('dbcon', 'n');
			$tikifeedback[] = array('num'=>1,'mes'=>$dbTiki->ErrorMsg());
		} else {
			$dbcon = true;
			$smarty->assign('dbcon', 'y');
			write_local_php($_REQUEST['db'], $_REQUEST['host'], $_REQUEST['user'], $_REQUEST['pass'], $_REQUEST['name']);
			$_SESSION[$cookie_name] = 'admin';
		}
	}
}

if ( $dbcon ) {
	$has_tiki_db = has_tiki_db( $dbTiki );
	$smarty->assign( 'tikidb_created', $has_tiki_db );
	if ( $install_step == '6' && $has_tiki_db ) {
		update_preferences( $dbTiki, $prefs );
		$smarty->assign( 'admin_email', get_admin_email( $dbTiki ) );
	}
	$smarty->assign( 'tikidb_is20',  has_tiki_db_20( $dbTiki ) );
}

if ( isset($_REQUEST['restart']) ) $_SESSION["install-logged-$multi"] = '';


//Load SQL scripts
load_sql_scripts();

$smarty->assign('admin_acc', $admin_acc);

// If no admin account then we are logged
if ( $admin_acc == 'n' ) $_SESSION["install-logged-$multi"] = 'y';

$smarty->assign('dbdone', 'n');
$smarty->assign('logged', $logged);

if ( $install_step == '4' || $install_step == '5' ) {
	require_once 'lib/profilelib/profilelib.php';
	$remote_profile_test = Tiki_Profile::fromNames( 'http://profiles.tikiwiki.org', 'Small_Organization_Web_Presence' );
	$has_internet_connection = empty($remote_profile_test) ? 'n' : 'y';
	$smarty->assign('has_internet_connection', $has_internet_connection);
}

if ( isset($dbTiki) && is_object($dbTiki) && isset($_SESSION["install-logged-$multi"]) && $_SESSION["install-logged-$multi"] == 'y' ) {
	$smarty->assign('logged', 'y');

	if ( isset($_REQUEST['scratch']) ) {
		$installer = new Installer;
		$installer->cleanInstall();
		$smarty->assign('installer', $installer);
		$smarty->assign('dbdone', 'y');
		$install_type = 'scratch';
		require_once 'lib/tikilib.php';
		$tikilib = new TikiLib;
		require_once 'lib/userslib.php';
		$userlib = new UsersLib;
		require_once 'lib/profilelib/profilelib.php';
		require_once 'lib/profilelib/installlib.php';
		require_once 'lib/setup/compat.php';
		require_once 'lib/tikidate.php';
		$tikidate = new TikiDate();
		
		$installer = new Tiki_Profile_Installer;
		//$installer->setUserData( $data ); // TODO

		if ( $has_internet_connection == 'y' && isset($_REQUEST['profile']) and !empty($_REQUEST['profile']) ) {
			if ( $_REQUEST['profile'] == 'Small_Organization_Web_Presence' ) {
				$profile = $remote_profile_test;
			} else {
				$profile = Tiki_Profile::fromNames( 'http://profiles.tikiwiki.org', $_REQUEST['profile'] );
			}
			$installer->install( $profile );
		}
		
		$_SESSION[$cookie_name] = 'admin';
	}

	if ( isset($_REQUEST['update']) ) {
		$installer = new Installer;
		$installer->update();
		$smarty->assign('installer', $installer);
		$smarty->assign('dbdone', 'y');
		$install_type = 'update';
	}

	// Try to activate Apache htaccess file by renaming _htaccess into .htaccess
	// Do nothing (but warn the user to do it manually) if:
	//   - there is no  _htaccess file,
	//   - there is already an existing .htaccess (that is not necessarily the one that comes from TikiWiki),
	//   - the rename does not work (e.g. due to filesystem permissions)
	//
	if ( file_exists('_htaccess') && ( file_exists('.htaccess') || ! @rename('_htaccess', '.htaccess') ) ) {
		$smarty->assign('htaccess_error', 'y');
	}
}

if( isset( $_GET['lockenter'] ) )
{
	touch( 'db/lock' );
	require('tiki-logout.php');	// logs out then redirects to home page
	exit;
}

if( isset( $_GET['nolockenter'] ) )
{
	require('tiki-logout.php');	// logs out then redirects to home page
	exit;
}

if( isset( $_GET['lockchange'] ) )
{
	touch( 'db/lock' );
	header( 'Location: tiki-change_password.php?user=admin' );
	exit;
}

$smarty->assign_by_ref('tikifeedback', $tikifeedback);

$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');

$email_test_tw = 'mailtest@tikiwiki.org';
$smarty->assign('email_test_tw', $email_test_tw);

//  Sytem requirements test. 
if ($install_step == '2') {

	if (($_REQUEST['perform_mail_test']) == 'y') {

		$email_test_to = $email_test_tw;
		$email_test_headers = '';
		$email_test_ready = true;

		if (!empty($_REQUEST['email_test_to'])) {
			$email_test_to =  $_REQUEST['email_test_to'];
			
			if ($_REQUEST['email_test_cc'] == '1') {
				$email_test_headers .= "Cc: $email_test_tw\n";
			}

			// check email address format
			include_once('lib/core/lib/Zend/Validate/EmailAddress.php');
			$validator = new Zend_Validate_EmailAddress();
			if (!$validator->isValid($email_test_to)) {
				$smarty->assign('email_test_err', tra('Email address not valid, test mail not sent'));
				$smarty->assign('perform_mail_test', 'n');
				$email_test_ready = false;
			}
		} else {	// no email supplied, check copy checkbox
			if ($_REQUEST['email_test_cc'] != '1') {
				$smarty->assign('email_test_err', tra('Email address empty and "copy" checkbox not set, test mail not sent'));
				$smarty->assign('perform_mail_test', 'n');
				$email_test_ready = false;
			}
		}
		$smarty->assign('email_test_to', $email_test_to);
		
		if ($email_test_ready) {	// so send the mail
			$email_test_headers .= 'From: noreply@tikiwiki.org' . "\n";	// needs a valid sender
			$email_test_headers .= 'Reply-to: '. $email_test_to . "\n";
			$email_test_headers .= "Content-type: text/plain; charset=utf-8\n";
			$email_test_headers .= 'X-Mailer: Tiki/'.$TWV->version.' - PHP/' . phpversion() . "\n";
			$email_test_subject = tra('Test mail from Tiki installer ').$TWV->version;
			$email_test_body = tra("Congratulations!\n\nYour server can send emails.\n\n");
			$email_test_body .= "\t".tra('Tiki version:').' '.$TWV->version . "\n";
			$email_test_body .= "\t".tra('PHP version:').' '.phpversion() . "\n";
			$email_test_body .= "\t".tra('Server:').' '.(empty($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_ADDR'] : $_SERVER['SERVER_NAME']) . "\n";
			$email_test_body .= "\t".tra('Sent:').' '.date(DATE_RFC822) . "\n";
			
			$sentmail = mail($email_test_to, $email_test_subject, $email_test_body, $email_test_headers);
			if($sentmail){
				$mail_test = 'y';
			} else {
				$mail_test = 'n';
			}
			$smarty->assign('mail_test', $mail_test);
			$smarty->assign('perform_mail_test', 'y');
			
		}
	}

	$php_memory_limit = return_bytes(ini_get('memory_limit'));
	$smarty->assign('php_memory_limit', intval($php_memory_limit));
	
	if ((extension_loaded('gd') && function_exists('gd_info'))) {
		$gd_test = 'y';
		$gd_info = gd_info();
		$smarty->assign('gd_info', $gd_info['GD Version']);
		} else {
		$gd_test = 'n'; }
	$smarty->assign('gd_test', $gd_test);
}

unset($TWV);

// write general settings
if ( $_REQUEST['general_settings'] == 'y' ) {
	global $dbTiki;
	$switch_ssl_mode = ( isset($_REQUEST['feature_switch_ssl_mode']) && $_REQUEST['feature_switch_ssl_mode'] == 'on' ) ? 'y' : 'n';
	$show_stay_in_ssl_mode = ( isset($_REQUEST['feature_show_stay_in_ssl_mode']) && $_REQUEST['feature_show_stay_in_ssl_mode'] == 'on' ) ? 'y' : 'n';

	$dbTiki->Execute("DELETE FROM `tiki_preferences` WHERE `name` IN ('browsertitle', 'sender_email', 'https_login', 'https_port', 'feature_switch_ssl_mode', 'feature_show_stay_in_ssl_mode', 'language')");

	$query = "INSERT INTO `tiki_preferences` (`name`, `value`) VALUES"
		. " ('browsertitle', '" . $_REQUEST['browsertitle'] . "'),"
		. " ('sender_email', '" . $_REQUEST['sender_email'] . "'),"
		. " ('https_login', '" . $_REQUEST['https_login'] . "'),"
		. " ('https_port', '" . $_REQUEST['https_port'] . "'),"
		. " ('feature_switch_ssl_mode', '$switch_ssl_mode'),"
		. " ('feature_show_stay_in_ssl_mode', '$show_stay_in_ssl_mode'),"
		. " ('language', '$language')";

	$dbTiki->Execute($query);
	$dbTiki->Execute("UPDATE `users_users` SET `email` = '".$_REQUEST['admin_email']."' WHERE `users_users`.`userId`=1");
}


include "lib/headerlib.php";
$headerlib->add_cssfile('styles/strasa.css');
$headerlib->add_cssfile('styles/strasa/options/cool.css');
$headerlib->add_css('
html {
	background-color: #fff;
}
#centercolumn {
	padding: 4em 10em;
}
#sitelogo h1, #tiki-clean {
	margin: 0;
	padding: 0;
	color: #000;
}
.box-data ol, .box-data ul {
	margin: 0;
	padding: 0 0 0 2em;
}
.box-data ol strong {
	color: #024;
}
');
$smarty->assign_by_ref('headerlib',$headerlib);

$smarty->assign('install_step', $install_step);
$smarty->assign('install_type', $install_type);
$smarty->assign_by_ref('prefs', $prefs);
$smarty->assign('detected_https',$_SERVER["HTTPS"]);

if (strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6') !== false) {
	$smarty->assign('ie6', true);
}

$mid_data = $smarty->fetch('tiki-install.tpl');
$smarty->assign('mid_data', $mid_data);

$smarty->display("tiki-print.tpl");