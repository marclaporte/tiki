<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Search_ContentSource_GroupSource implements Search_ContentSource_Interface
{
	private $db;

	function __construct()
	{
		$this->db = TikiDb::get();
	}

	function getDocuments()
	{
		return $this->db->table('users_groups')->fetchColumn('groupName', array());
	}

	function getDocument($objectId, Search_Type_Factory_Interface $typeFactory)
	{
		$row = $this->db->table('users_groups')->fetchRow(['groupDesc'], array('groupName' => $objectId));

		if (! $row) {
			return false;
		}

		$data = array(
			'title' => $typeFactory->sortable($objectId),
			'description' => $typeFactory->plaintext($row['groupDesc']),

			'searchable' => $typeFactory->identifier('n'),

			'view_permission' => $typeFactory->identifier('tiki_p_group_view'),
		);

		return $data;
	}

	function getProvidedFields()
	{
		return array(
			'title',
			'description',

			'searchable',

			'view_permission',
		);
	}

	function getGlobalFields()
	{
		return array(
			'title' => true,
			'description' => true,
		);
	}
}

