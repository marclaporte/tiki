<?php
/* $Id$ */

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER['SCRIPT_NAME'],basename(__FILE__)) !== false) {
  header('location: index.php');
  exit;
}

require_once('lib/init/initlib.php');

// Define lang and load translation functions
if (!empty($_REQUEST['lang'])) {
	$language = $prefs['site_language'] = $prefs['language'] = $_REQUEST['lang'];
} else {
	$language = $prefs['site_language'] = $prefs['language'] = 'en';
}
include_once('lib/init/tra.php');

// Please use the local.php file instead containing these variables
// If you set sessions to store in the database, you will need a local.php file
// Otherwise you will be ok.
//$api_tiki		= 'pear';
//$api_tiki			= 'pdo';
$api_tiki			= 'pdo';
$db_tiki			= 'mysql';
$dbversion_tiki = '2.0';
$host_tiki		= 'localhost';
$user_tiki		= 'root';
$pass_tiki		= '';
$dbs_tiki			= 'tiki';
$tikidomain		= '';

/*
SVN Developers: Do not change any of the above.
Instead, create a file, called db/local.php, containing any of
the variables listed above that are different for your 
development environment.  This will protect you from 
accidentally committing your username/password to SVN!

example of db/local.php
<?php
$host_tiki   = 'myhost';
$user_tiki   = 'myuser';
$pass_tiki   = 'mypass';
$dbs_tiki    = 'mytiki';
$api_tiki    = 'adodb';

** Multi-tiki
**************************************
see http://tikiwiki.org/MultiTiki19

Setup of virtual tikis is done using setup.sh script
-----------------------------------------------------------
-> Multi-tiki trick for virtualhosting

$tikidomain variable is set to :
or TIKI_VIRTUAL
    That is set in apache virtual conf : SetEnv TIKI_VIRTUAL myvirtual
or SERVER_NAME
    From apache directive ServerName set for that virtualhost block
or HTTP_HOST
    From the real domain name called in the browser 
    (can be ServerAlias from apache conf)

*/

if (!isset($local_php) or !is_file($local_php)) {
	$local_php = 'db/local.php';
} else {
	$local_php = preg_replace(array('/\.\./','/^db\//'),array('',''),$local_php);
}
if (is_file('db/virtuals.inc')) {
	if (!isset($multi)) {
		if (isset($_SERVER['TIKI_VIRTUAL']) and is_file('db/'.$_SERVER['TIKI_VIRTUAL'].'/local.php')) {
			$multi = $_SERVER['TIKI_VIRTUAL'];
		} elseif (isset($_SERVER['SERVER_NAME']) and is_file('db/'.$_SERVER['SERVER_NAME'].'/local.php')) {
			$multi = $_SERVER['SERVER_NAME'];
		} elseif (isset($_SERVER['HTTP_HOST']) and is_file('db/'.$_SERVER['HTTP_HOST'].'/local.php')) {
			$multi = $_SERVER['HTTP_HOST'];
		}
	}
	if (isset($multi)) {
		$local_php = "db/$multi/local.php";
		$tikidomain = $multi;
	}
}
$re = false;
if ( file_exists($local_php) ) $re = include($local_php);
if ( $re === false ) {
	header('location: tiki-install.php');
	exit;
}

if ( $dbversion_tiki == '1.10' ) $dbversion_tiki = '2.0';

require_once 'lib/core/lib/TikiDb/ErrorHandler.php';
class TikiDb_LegacyErrorHandler implements TikiDb_ErrorHandler
{
	function handle( TikiDb $db, $query, $values, $result ) // {{{
	{
		global $smarty, $prefs, $ajaxlib;

		$msg = $db->getErrorMessage();
		$q=$query;
		foreach($values as $v) {
			if (is_null($v)) $v='NULL';
			else $v="'".addslashes($v)."'";
			$pos=strpos($q, '?');
			if ($pos !== FALSE)
				$q=substr($q, 0, $pos)."$v".substr($q, $pos+1);
		}

		if (function_exists('xdebug_get_function_stack')) {
			function mydumpstack($stack) {
				$o='';
				foreach($stack as $line) {
					$o.='* '.$line['file']." : ".$line['line']." -> ".$line['function']."(".var_export($line['params'], true).")<br />";
				}
				return $o;
			}
			$stacktrace = mydumpstack(xdebug_get_function_stack());
		} else {
			$stacktrace = false;
		}


		if ( ! isset($_SESSION['fatal_error']) ) {
			// Do not show the error if an error has already occured during the same script execution (error.tpl already called), because tiki should have died before another error.
			// This happens when error.tpl is called by tiki.sql... and tiki.sql is also called again in error.tpl, entering in an infinite loop.

			require_once 'installer/installlib.php';
			$installer = new Installer;

			require_once('tiki-setup.php');
			if ( ! $smarty ) {
				require_once 'setup_smarty.php';
			}

			$smarty->assign( 'msg', $msg );
			$smarty->assign( 'base_query', $query );
			$smarty->assign( 'values', $values );
			$smarty->assign( 'built_query', $q );
			$smarty->assign( 'stacktrace', $stacktrace );
			$smarty->assign( 'requires_update', $installer->requiresUpdate() );

			if ($prefs['feature_ajax'] == 'y') {
				global $ajaxlib;
				include_once('lib/ajax/xajax/xajax_core/xajaxAIO.inc.php');
				if ($ajaxlib && $ajaxlib->canProcessRequest()) {
					// this was a xajax request -> return a xajax answer
					$page = $smarty->fetch( 'database-connection-error.tpl' );
					$objResponse = new xajaxResponse();
					$page=addslashes(str_replace(array("\n", "\r"), array(' ', ' '), $page));
					$objResponse->script("bugwin=window.open('', 'tikierror', 'width=760,height=500,scrollbars=1,resizable=1');".
							"bugwin.document.write('$page');");
					echo $objResponse->getOutput();
					die();
				}
			}

			$smarty->display('database-connection-error.tpl');
			unset($_SESSION['fatal_error']);
			die;
		}
	} // }}}
}

$dbInitializer = 'db/tiki-db-adodb.php';
if (extension_loaded("pdo") and $api_tiki == 'pdo' ) {
	$dbInitializer = 'db/tiki-db-pdo.php';
}

require $dbInitializer;
init_connection( TikiDb::get() );

if( isset( $shadow_host, $shadow_user, $shadow_pass, $shadow_dbs ) ) {
	global $dbMaster, $dbSlave;
	// Set-up the replication
	$dbMaster = TikiDb::get();

	$host_tiki = $shadow_host;
	$user_tiki = $shadow_user;
	$pass_tiki = $shadow_pass;
	$dbs_tiki = $shadow_dbs;
	require $dbInitializer;
	$dbSlave = TikiDb::get();
	init_connection( $dbSlave );

	require_once 'lib/core/lib/TikiDb/MasterSlaveDispatch.php';
	$db = new TikiDb_MasterSlaveDispatch( $dbMaster, $dbSlave );
	TikiDb::set( $db );
}

unset( $host_map, $db_tiki, $host_tiki, $user_tiki, $pass_tiki, $dbs_tiki, $shadow_user, $shadow_pass, $shadow_host, $shadow_dbs );

function init_connection( $db ) {
	global $db_table_prefix, $common_users_table_prefix, $db_tiki;

	$db->setServerType( $db_tiki );
	$db->setErrorHandler( new TikiDb_LegacyErrorHandler );

	if( isset( $db_table_prefix ) )
		$db->setTablePrefix( $db_table_prefix );

	if( isset( $common_users_table_prefix ) )
		$db->setUsersTablePrefix( $common_users_table_prefix );
}
