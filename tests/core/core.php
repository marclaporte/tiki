<?php
/**
 * \file
 * $Header: /cvsroot/tikiwiki/tiki/tests/core/core.php,v 1.1 2003-08-22 19:04:40 zaufi Exp $
 *
 * \brief Main file
 *
 */

// Include core subsystems
require_once('database.php');
require_once('extensions.php');

// Some defines
define('TIKI_HARDCODED_CONFIG_FILE', 'tiki-hardcoded-config.php');

/**
 * \brief The main class of Tiki core
 *
 * This class do not contain valued code... all work delegated to
 * corresponding subsystems. It is just facade class.
 *
 */
class TikiCore
{
    // Tiki core subsystems
    var $sys_db;                                        //!< Database subsystem
    var $sys_objmgr;                                    //!< Objects management subsystem
    var $sys_usermgr;                                   //!< User/group management subsystem
    var $sys_extmgr;                                    //!< Extensions management subsystem
    /// Core constructor
    function TikiCore()
    {
        $this->initialize();                            // Run init scripts
        // Init core subsystems
        $sys_db     = new TikiCoreDatabase($dbTiki);
        $sys_extmgr = new TikiCoreExtensions();
    }
    /// Run init.scripts
    function initialize()
    {
        // Get hardcoded globals before exec init scripts
        $tiki_conf = dirname(__FILE__) . '/' . TIKI_HARDCODED_CONFIG_FILE;
        if (file_exists($tiki_conf))
            require_once($tiki_conf);
        else
            return TIKI_CORE_INIT_FAIL;
        //
        $scripts = array();
        // Read directory files into array
        $initdir = dirname(__FILE__) . '/init.scripts';
        $d = dir($initdir);
        while (($entry = $d->read()) !== false)
            // Add to scripts list only if file have mask 'DD-name.php'
            if (preg_match('/[0-9]{2}-.*\.php/', $entry))
                $scripts[] = $entry;
        $d->close();
        //
        sort($scripts);
        //
        foreach ($scripts as $script) require_once($initdir.'/'.$script);
    }

    /*
     * Database Subsystem API calls
     */
    function query($query, $values = null, $numrows = -1, $offset = -1, $reporterrors = true)
    {
        return $sys_db->query($query, $values, $numrows, $offset, $reporterrors);
    }
    function getOne($query, $values = null, $reporterrors = true)
    {
        return $sys_db->getOne($query, $values, $reporterrors);
    }
    /*
     * Extensions Management Subsystem API calls
     */
    function installed_extensions()
    {
        return $sys_extmgr->installed_extensions();
    }
    function enabled_extensions($user)
    {
        return $sys_extmgr->enabled_extensions($user);
    }
    function search_extensions()
    {
        return $sys_extmgr->search_extensions();
    }
    function install_extension($extension)
    {
        return $sys_extmgr->install_extension($extension);
    }
    function uninstall_extension($extension)
    {
        return $sys_extmgr->uninstall_extension($extension);
    }
    function is_installed($extension)
    {
        return $sys_extmgr->is_installed($extension);
    }
    function is_enabled($extension, $user)
    {
        return $sys_extmgr->is_enabled($extension, $user);
    }
}

?>
