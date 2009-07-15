<?php
/**
 * wslib.php - TikiWiki CMS/GroupWare
 *
 * This library enables the basic management of workspaces (WS)
 * 
 * @package	lib
 * @author	Benjamin Palacios Gonzalo (mangapower) <mangapowerx@gmail.com>
 * @author	Aldo Borrero Gonzalez (axold) <axold07@gmail.com>
 * @license	http://www.opensource.org/licenses/lgpl-2.1.php
 */

//Controlling Access
require_once 'tiki-setup.php';
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

//Rest of Imports
include_once 'lib/categories/categlib.php';

/**
 * wslib - The Workspaces Library for TikiWiki
 * TODO: Refine documentation!!!
 *
 * @category	TikiWiki
 * @package	lib/workspaces
 * @version	$Id
 */
class wslib extends CategLib 
{
    /** Stores the $prefs['ws_container'] for avoid to check it in every function */
    private $ws_container;

    /** Stores this objectype, this is WS */
    private $objectType;

    /** Constructor, give the dbtiki to its parent, this is Categlib */
    public function __construct()
    {
	global $dbTiki, $prefs;
	parent::CategLib($dbTiki);

	$this->ws_container = (int) $prefs['ws_container'];
	$this->objectType = 'ws';
    }

    /** Initialize the Workspaces in TikiWiki setting a container in the category table and return its ID
     *
     * @return The ws_container ID if it wasn't set before the ws_container, if not, null
     */
    public function init_ws()
    {
	if (!$this->ws_container)
	{
	    global $prefs, $tikilib;
	    $id = parent::add_category(0, '', 'Workspaces Container');
	    $tikilib->set_preference('ws_container', $id);
	    $this->ws_container = (int) $prefs['ws_container'];
	    return $id;
	}
    }

    /** Get the ws_container stored in $prefs. This function is used to avoid certain calls to the $prefs array.
     *
     * @return The ws container id stored in the var $prefs
     */
    public function get_ws_container()
    {
	return $this->ws_container;
    }
    
    /** Create a new WS with one group inside it with the associated perm 'tiki_p_ws_view'.
     *
     * @param $name Name of the Workspace
     * @param $parentWS Name of the ParentWS, if ParentWS is null, its default value will be ws_container
     * @param $groupName The name of the group
     * @param $additionalPerms Associative array for giving more perms than the default perm 'tiki_p_ws_view'
     * @return The ID of the WS
     */
    public function create_ws ($name, $groupName, $parentWS = null, $noCreateNewGroup = false, $additionalPerms = null, $description = '')
    {
    	if (!$parentWS)	$parentWS = 0;
    	
	$query = "insert into `tiki_categories`(`name`,`description`,`parentId`,`hits`,`rootCategId`) values(?,?,?,?,?)";
	$this->query($query, array($name, $description, (int) $parentWS, 0, $this->ws_container));
	
	$query = "select `categId` from `tiki_categories` where `name`=? and `parentId`=? and `rootCategId`=?";
	$ws_id = $this->getOne($query, array($name, (int) $parentWS, $this->ws_container));
	
	if ($noCreateNewGroup)
	{
	    $this->set_permissions_for_group_in_ws ($ws_id, $groupName, array('tiki_p_ws_view'));
	    if ($additionalPerms != null)
		$this->set_permissions_for_group_in_ws($ws_id, $groupName, $additionalPerms);
	}
	else
	    $this->add_ws_group ($id_ws, $name, $groupName, $additionalPerms);

	return $ws_id;
    }

    /** Add new group to a WS
     *
     * @param $id_ws The WS id you want to add the group
     * @param $wsName The name of the WS, it can be null
     * @param $nameGroup The name of the group you want to create
     * @param $additionalPerms Associative array for giving more perms than the default perm 'tiki_p_ws_view'
     * @return If the WS was sucesfully created true, if not false.
     */
    public function add_ws_group ($ws_id, $wsName = null, $nameGroup, $additionalPerms = null) 
    {
	global $userlib; require_once 'lib/userslib.php';

	if (!$wsName) $wsName = $this->get_ws_name($ws_id);

	$groupName = $this->generate_ws_group_name ($id_ws, $wsName, $nameGroup); //With this you can create two groups with same name in different ws

	if ($userlib->add_group($groupName)) 
	{
    	    // It's given the tiki_p_ws_view permission to the selected group in the new ws
	    $this->set_permissions_for_group_in_ws($ws_id,$groupName,array('tiki_p_ws_view'));
	
    	    // It's given additional admin permissions to the group in the new ws
	    if ($additionalPerms != null)
		$this->set_permissions_for_group_in_ws($ws_id,$groupName,$additionalPerms);

	    return true;
	}
	else
	    return false;
    }

    /** Generate a group name specially created for WS. With this we can avoid the problems related to have two groups with the same name
     * NOTE: For now is OK, if the future implementation of groups change, this would change!
     *
     * @param $id_ws The WS id
     * @param $wsname The WS name
     * @param $nameGroup The group name
     * @return A string with this format: $id_ws::$wsName::$nameGroup
     */
    public function generate_ws_group_name ($ws_id, $wsName, $nameGroup)
    {
	return $name = ((string) $ws_id)."::".$wsName."::".$nameGroup;
    }

    /** Parse a group name with the form $ws_id<:>$wsName<:>$nameGroup
     * Allowed characters in $ws_id are 0-9 with a variable length of 1 to 11 digits
     * Allowed characters in $wsName are 0-9, A-Z, a-z, whitespace, -, < and >
     * Allowed characters in $nameGroup are the same as above
     * TODO: Work in progress, needs to be checked if works properly (I'm newbie to regex world :P)
     * Yeah, I know, this exp is far from being perfect, but for testing purposes is OK
     *
     * @param $groupName The name of the group you want to parse
     * @param $groupValues The values given in a reference array when you apply the function
     * @return An array with the values in each position. If the parse was not succesful return false
     */
    public function parse_ws_group_name ($groupName, &$groupValues)
    {
	return preg_match("%\b([\d]{1,11})\b::\b([\w\-<>\s]+)\b::\b([\w\-<>\s]+[^:]{2})\b%", $groupName, $groupValues);
    }
	
    /** Remove a WS and it childs
     * 
     * @param $ws_id The WS id you want to delete
     * @return true
     */
    public function remove_ws ($ws_id)
    {	
    	// Remove perms assigned to the WS
    	$hashWS = md5($this->objectType . strtolower($ws_id));
	$query = "delete from `users_objectpermissions` where `objectType` = ? and `objectId` = ?";
	$this->query($query, array($this->objectType, $hashWS), -1, -1, false);
	
	// Remove the WS groups
	
	// Remove the WS objects
	$listWSObjects = $this->list_ws_objects($ws_id);
	foreach ($listWSObjects as $object)
		$this->remove_ws_object ($ws_id,$object["objectId"],$object["itemId"],$object["type"]);
		
	// Remove WS recursively
	$wsChilds = $this->get_ws_childs ($ws_id);
	foreach ($wsChilds as $child)
		$this->remove_ws($child);

	return parent::remove_category($ws_id);
    }


    /** Remove all WS including the Workspaces container. It's a destructive function, so use with caution
     * 
     * @return True
     */
    public function remove_all_ws ()
    {
    	// First, delete all WS parents
    	$query = "select `categId` from `tiki_categories` where `parentId`=0 and `rootCategId`=?";
    	$bindvars = array($this->ws_container);
    	$result = $this->query($query,$bindvars); 
    	while ($ret = $result->fetchRow())
		$this->remove_ws($ret["categId"]);
    	
	// In the end, delete the WS Container
	$this->remove_ws($this->ws_container);
	
	return true;
    }
    
    /** Remove a group from a WS
     * 
     * @param $ws_id The id of the WS where the group will be removed from
     * @param $groupName The name of the group you want to remove
     * @return true
     */
    public function remove_ws_group ($ws_id,$groupName)
    {
	// Check if the group is included in other WS
    	$query = "select count(*) from `users_objectpermissions`
			   where `groupName` = ? and `permName` = 'tiki_p_ws_view'";
	$result = $this->getOne($query, array($groupName));
    	
    	// If the group only had access to the current WS
    	if (($result == 1) && !($group == 'Anonymous' || $group == 'Registered' || $group == 'Admin'))
    	{
		// Delete the group
		global $userlib; require_once 'lib/userslib.php';
		$userlib->remove_group($groupName);		
    	}    	
    	// If the group has access to other WS
    	else
    	{
    	    	$hashWS = md5($this->objectType . strtolower($ws_id));
    	  
    		// Delete all perms added for the WS related to this group
    		$query = "delete from `users_objectpermissions`
				   where `groupName` = ? and `objectId` = ?";
		$this->query($query, array($groupName, $hashWS), -1, -1, false);
		
		// Get the objects that only belongs to the WS
		$query = "select * from `tiki_objects` t0, `tiki_category_objects` t1 
				   where t0.`objectId` = t1.`catObjectId` and t1.`categId`=? 
				   and not exists (select * from `tiki_category_objects` t2 
				   where t1.`catObjectId`=t2.`catObjectId` and not t2.`categId`=?)";
		$result = $this->query($query, array($ws_id, $ws_id));
		while ($ret = $result->fetchRow())
	    		$listWSUniqueObjects[] = $ret;
	    	// For every unique object delete the object pems related to the group
    		foreach ($listWSUniqueObjects as $ws_object)
    		{
    			$hashObject = $hashObject = md5($ws_object["type"] . strtolower($ws_object["itemId"] ));
    			$query = "delete from `users_objectpermissions` where `groupName` = ? and `objectType` = ? and `objectId` = ?";
    			$this->query($query,array($groupName,$ws_object["type"],$hashObject));
    		}
    	}
    	
    	return true;
    }
	
    /** Add a object to a WS (it can be a wiki page, file gal, etc)
     *
     * @param $ws_id The id of the WS you want to add a object
     * @param $itemId The id of the item (in wikis it's equal to its name)
     * @param $type The type of the object
     * @return -
     */
    public function add_ws_object ($ws_id,$itemId,$type)
    {
	return parent::categorize_any($type, $itemId, $ws_id);
    } 
	
    /** Remove an object inside in a WS
     *
     * @param $ws_id The id of the WS
     * @param $ws_ObjectId The id of the object you want to delete
     * @param $itemId The id of the item you want to delete
     * @param $type The type of the object you want to delete
     * @return true
     */
    public function remove_ws_object ($ws_id,$ws_ObjectId,$itemId,$type)
    {
       	parent::remove_object_from_category($ws_ObjectId, $ws_id);
    	$hashObject = md5($type . strtolower($itemId));
    	
    	if (!parent::is_categorized($type,$itemId))
    	{
		// Delete all the object perms related to the object
		$query = "delete from `users_objectpermissions` where `objectType` = ? and `objectId` = ?";
		$this->query($query, array($type, $hashObject), -1, -1, false);
    		
    		// Delete the object from Tiki (TBD)
    		// parent::delete_object($type, $itemId);
    	}
    	else
    	{
    		// Get the groups that only have access to the WS in which the object is stored.
    		$hashWS = md5($this->objectType . strtolower($ws_id));
    		$query = "select `groupName` from `users_objectpermissions` t1 
    				where `permName`='tiki_p_ws_view' and `objectId`=? and 
    				not exists (select * from `users_objectpermissions` t2 
    				where t1.`groupName`=t2.`groupName` 
    				and `permName`='tiki_p_ws_view' 
    				and not `objectId`=?)";
    		$result = $this->query($query,array($hashWS,$hashWS));
    		
    		while ($ret = $result->fetchRow())
	    		$listWSUniqueGroups[] = $ret;
	    		
	    	// For every unique group delete the object perms related to the object
    		foreach ($listWSUniqueGroups as $group)
    		{
    			$query = "delete from `users_objectpermissions` where `groupName` = ? and `objectType` = ? and `objectId` = ?";
    			$this->query($query,array($group["groupName"],$type,$hashObject));
    		}
    	}
    	
	return true;
    }

    /** Get the WS id
     *
     * @param $name The name of WS you want to retrieve
     * @param $parentWS The id of the WS parent you want to search. If null, value ws_container will use instead
     * @return WS id if there are any
     */
    public function get_ws_id($name, $parentWS)
    {
	$query = "select `categId` from `tiki_categories` where `name`=? and `parentId`=? and `rootCategId`=?";
	$bindvars = array($name, $parentWS, $this->ws_container);

	return $this->getOne($query, $bindvars);
    }

    /** Get a WS name by its id
     *
     * @param $ws_id The id of the WS you want to retrieve the name
     * @param $parentWS The id of the WS parent you want to search. If null, value ws_container will use instead
     * @return An array with all the names of WS you want to search
     */
    public function get_ws_name($ws_id)
    {
	$query = "select `categId` from `tiki_categories` where `categId`=?";
	$bindvars = array($ws_id);

	return $this->query($query, $bindvars);
    }
	
    /** Give a set of permissions to a group for a specific WS (view, addresources, addgroups,...)
     *
     * @param $ws_id The id of the WS
     * @param $groupName The name of the group you want to set perms
     * @param $permList An associative array for enable or disable perms
     */
    public function set_permissions_for_group_in_ws ($ws_id,$groupName,$permList)
    {
	$hashWS = md5($this->objectType . strtolower($ws_id));

	foreach ($permList as $permName)
	{
	    // If already exists, overwrite 
	    $query = "delete from `users_objectpermissions`
		where `groupName` = ? and
		`permName` = ? and
		`objectId` = ?";
	    $this->query($query, array($groupName, $permName,$hashWS), -1, -1, false);
	
	    $query = "insert into `users_objectpermissions`(`groupName`,
		`objectId`, `objectType`, `permName`)
		values(?, ?, ?, ?)";		
	    $this->query($query, array($groupName, $hashWS, $this->objectType, $permName));
	}	

	return true;
    }
	
    /** List the groups that have access to a WS
     *
     * @param $ws_id The id of the WS
     * @return A list of the groups that have access to the given WS
     */
    public function list_groups_that_can_access_in_ws ($ws_id)
    {    	
	$hashWS = md5($this->objectType . strtolower($ws_id));

	$query = "select `groupName` from `users_objectpermissions` where 
	    `objectId`=? and `permName`='tiki_p_ws_view'";
	$bindvars = array($hashWS);
	$result = $this->query($query,$bindvars);

	while ($ret = $result->fetchRow())
	    $listWSGroups[] = $ret;

	return $listWSGroups;
    }
    	
    /** List all WS that a group have access
     *
     * @param $groupName The name of the group
     * @return An associative array with the WS that the group have access
     */
    public function list_ws_that_can_be_accessed_by_group ($groupName)
    {	
	$query = "select `objectId` from `users_objectpermissions` where (`groupName`=? and `permName`='tiki_p_ws_view') ";
	$bindvars = array($groupName);
	$result = $this->query($query,$bindvars);

	while ($res = $result->fetchRow())
	    $groupWS[] = $res["objectId"];
		
	$idws = $this->ws_container;
	$query = "select * from `tiki_categories` where `rootCategId`= $idws";
	$bindvars = array();
	$listWS = $this->query($query,$bindvars);
		
	while ($res = $listWS->fetchRow()) 
	{
	    $ws_id = $res["categId"];
	    $hashWS = md5($this->objectType . strtolower($ws_id));

	    if (in_array($hashWS,$groupWS))
	    {
		$workspaceID = $res["categId"];
		$listGroupWS["$workspaceID"] = $res;
	    }
	}

	return $listGroupWS;
    }

    /** List all WS stored in TikiWiki
     *
     * TODO Find a better way to explain
     */
    public function list_all_ws ($offset, $maxRecords, $sort_mode = 'name_asc', $find, $type, $objid)
    {
		return parent::list_all_categories ($offset, $maxRecords, $sort_mode = 'name_asc', $find, $type, $objid);
    }
	
    /** List all WS that a user have access
     *
     * @param $user The name of the user
     * @return An associative array with the WS that the user has access
     */
	public function list_ws_that_user_have_access ($user)
	{
		require_once('lib/userslib.php');
		global $userlib;
		
		$ws = array();		
		
		$groups = $userlib->get_user_groups($user);		
		foreach ($groups as $groupName)
		{
			$groupWS =  $this->list_ws_that_can_be_accessed_by_group ($groupName);
			foreach ($groupWS as $wsres)
				if (!in_array($wsres,$ws))
					$ws[$wsres["categId"]] = $wsres;
		}

		return $ws;
	}
	
    /** List the objects stored in a workspace
     *
     * @param $ws_id The id of the WS
     * @return An associative array of objects related to a single WS
     */
    public function list_ws_objects ($ws_id)
    {
	$query = "select `catObjectId` from `tiki_category_objects` where `categId`= ?";
	$bindvars = array($ws_id);
	$result = $this->query($query,$bindvars);
	while ($res = $result->fetchRow())
	    $listObjects[] = $res["catObjectId"];
		
	foreach ($listObjects as $objectId)
	{
	    $query = "select * from `tiki_objects` where `objectId`= ?";
    	    $bindvars = array($objectId);
	    $result = $this->query($query,$bindvars);
	    while ($res = $result->fetchRow())
		$listWSObjects[] = $res;
	}

	return $listWSObjects;
    }

    /** Get the stored perms for a object for a specific group
     *
     * @param $objId The object you want to check
     * @param $objectType The type of the object
     * @param $groupName The name of the group
     * @return An array with the objects perms related to a object for a group
     */
    public function get_object_perms_for_group ($objId,$objectType,$groupName)
    {
	$objectId = md5($objectType . strtolower($objId));
	$query = "select `permName` from `users_objectpermissions` where `groupName`=? and `objectId`=? and `objectType`=?";
	$bindvars = array($groupName,$objectId,$objectType);
	$result = $this->query($query,$bindvars);
	while ($res = $result->fetchRow())
	    $objectPermsGroup[] = $res["permName"];

	return $objectPermsGroup;
    }
	
    /** List the objects stored in a workspace for a specific user
     *
     * @param $ws_id The id of the WS
     * @param $user The username
     * @return Associative array with the objects that a user have access from a WS
     */
    public function list_ws_objects_for_user ($ws_id,$user)
    {
	require_once('lib/userslib.php');
	global $userlib; global $objectlib;
		
	$listWSObjects = $this->list_ws_objects($ws_id);
		
	foreach ($listWSObjects as $object)
	{
	    $objectType = $object["type"];
	    $objId = $object["itemId"];
	    $viewPerm = parent::get_needed_perm($objectType, "view");
			
	    $groups = $userlib->get_user_groups($user);
			
	    $notFoundViewPerm = true;		
	    foreach ($groups as $groupName)
	    {
		if ($notFoundViewPerm)
		{
		    $objectPermsGroup = $this->get_object_perms_for_group ($objId,$objectType,$groupName);
		    if (in_array($viewPerm,$objectPermsGroup))
		    {
			$listWSObjectsUser[] = $object;
			$notFoundViewPerm = false;
		    }
		}
	    }
	} 

	return $listWSObjectsUser;
    }
	
    /** List the objects stored in a workspace for a specific user
     *
     * @param $ws_id The id of the WS
     * @return Associative array with the WS childs
     */	
     public function get_ws_childs ($ws_id)
     {
     	$query = "select `categId` from `tiki_categories` where `parentId`= ?";
     	$bindvars = array($ws_id);
     	$result = $this->query($query,$bindvars);
	while ($res = $result->fetchRow())
		$wsChilds[] = $res["categId"];

     	return $wsChilds;
     }	
}

$wslib = new wslib();
