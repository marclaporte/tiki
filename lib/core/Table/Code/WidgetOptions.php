<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER['SCRIPT_NAME'], basename(__FILE__)) !== false) {
	header('location: index.php');
	exit;
}

/**
 * Class Table_Code_WidgetOptions
 *
 * Creates the code for the widget options portion of the Tablesorter jQuery code
 *
 * @package Tiki
 * @subpackage Table
 * @uses Table_Code_Manager
 */
class Table_Code_WidgetOptions extends Table_Code_Manager
{

	public function setCode()
	{
		$wo[] = 'stickyHeaders : \'ts-stickyHeader\'';

		//sort
		if (parent::$sorts) {
			//row grouping
			if (parent::$group) {
				$wo[] = 'group_collapsible : true';
				$wo[] = 'group_count : \' ({num})\'';
			}
			//saveSort
			if (isset(parent::$s['sorts']['type']) && strpos(parent::$s['sorts']['type'], 'save') !== false) {
				$wo[] = 'saveSort : true';
			}
		}

		//filter
		$wof = Table_Factory::build('WidgetOptionsFilter', parent::$s, 'code')->getOptionArray();
		$wo = $wof === false ? $wo : $wo + $wof;

		if (count($wo) > 0) {
			if (!parent::$ajax) {
				$code = $this->iterate($wo, $this->nt2 . 'widgetOptions : {', $this->nt2 . '}', $this->nt3, '');
				parent::$code[self::$level1][self::$level2] = $code;
			} else {
				parent::$tempcode['wo'] = $wo;
			}
		}
	}

}