<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*
 * JavaScript Tree
 * 
 * That smarty function is mostly intended to be used in .tpl files
 * syntax: {tree}
 * 
 */
function smarty_function_tree($params, &$smarty) {
	global $prefs;

	if ( $prefs['javascript_enabled'] == 'n' ) {
		// If JavaScript is disabled, force the php version of the tree
		$params['type'] = 'phptree';
	} else if ($prefs['feature_phplayers'] != 'y') {
		// no phplayers - use category-style ones (for now)
		require_once ('lib/tree/categ_browse_tree.php');
		$link = $params['data']['link'];
		$name = $params['data']['name'];
		$link_id = 'id';
		$link_var = 'galleryId';
		require_once $smarty->_get_plugin_filepath('function', 'icon');
		$icon = '&nbsp;' . smarty_function_icon(array('_id' => 'folder'), $smarty) . '&nbsp;';
		
		$tree_nodes = array(
			array(
				'id' => 1,
				'parent' => 0,
				'data' => '<a class="fgalname" href="' . $link . '">' . $icon . htmlspecialchars($name) .'</a>', 
			)
		);
		foreach($params['data']['data'] as $d) {
			$tree_nodes[] = array(
				'id' => $d['id'],
				'parent' => $d['parentId'],
				'data' => '<a class="fgalname" href="' . $link . '?' . $link_var . '=' . $d[$link_id] . '">' . $icon . htmlspecialchars($d['name']) .'</a>', 
			);
		}
		$tm = new CatBrowseTreeMaker('categ');
		$res = $tm->make_tree( 1, $tree_nodes);
		return $res;
	}

	global $tikiphplayers;
	include_once('lib/phplayers_tiki/tiki-phplayers.php');
	require_once $smarty->_get_plugin_filepath('function', 'query');

	if ( ! function_exists('data2struct') ) {
		function data2struct(&$data, $level, &$expanded) {
			global $prefs, $tikilib;
			static $cur = 0;
			$ret = '';
			if ( is_array($data) && $level > 0 ) {
				$cur++;
				$link = '';
				if ( isset($data['link']) && $data['link'] != '') {
					$link = $data['link'];
				} elseif ( isset($data['link_id']) && isset($data['link_var']) && $data['link_id'] >= 0 ) {
					$link = smarty_function_query(array(
						'_type' => 'absolute_path',
						$data['link_var'] => $data['link_id'],
						'offset' => 'NULL' // Always go back to the first page of the destination
					), $smarty);
				}
				if ( isset($data['current']) ) $data['name'] = '<b>'.$data['name'].'</b>';
				$name = $data['name'] . ( isset($data['addon']) ? ' '.$data['addon'] : '' );
				$tmp_img = $tikilib->get_style_path($prefs['style'], $prefs['style_option'],'pics/icons/folder.png');
				if (empty($tmp_img)) $tmp_img = 'pics/icons/folder.png';
				$ret .= str_repeat('.', $level).'|'.$name.'|'.$link.'||'.$tmp_img;
				if ( in_array($cur, $expanded) ) $ret .= '||1';
				$ret .= "\n";
				if ( is_array($data['data']) ) {
					foreach ( $data['data'] as $d ) {
						$ret .= data2struct($d, $level + 1, $expanded);
					}
				}
			}
			return $ret;
		}
	}

	$structure = '';

	if ( ! isset($params['type']) ) $params['type'] = 'tree';
	if ( ! isset($params['expanded']) ) $params['expanded'] = array(1);
	if ( isset($params['data']) && is_array($params['data']) ) {
		$expanded = ( $params['type'] == 'phptree' ) ? array(1) : $params['expanded'];
		$structure = data2struct($params['data'], 1, $expanded);
	}

	$default_expand = $params['expanded'];
	$phplm_expand = '';

	// Update cookie that stores tree elements that should be expanded
	//   by keeping those already expanded by the user and those that should now be expanded ($params['expanded'])
	//
	if ( isset($_COOKIE) && isset($_COOKIE['phplm_expand']) && preg_match('/^[0-9\|]+$/', $_COOKIE['phplm_expand']) ) {
		// Get user choices stored in Cookies from this script and from phplayers itself in javascript version
		$phplm_expand = $_COOKIE['phplm_expand'];
		$default_expand = array_unique(array_merge($params['expanded'], explode('|', $_COOKIE['phplm_expand'])));
	}
	if ( isset($_GET['p']) && preg_match('/^[0-9\|]+$/', $_GET['p']) ) {
		// Get user choices from URLs generated by phplayers in php version
		$phplm_expand = $_GET['p'];
		$default_expand = array_unique(array_merge($params['expanded'], explode('|', $_GET['p'])));
	}

	if ( ! headers_sent() ) {
		// Not using php's setcookie function because pipes '|' are converted to %7C
		//   and are no more understood by PHP Layers javacript
		header('Set-Cookie: phplm_expand='.$phplm_expand.'; path=/');
	}

	// Reset cookie that stores tree elements collapsed by the user, in order
	//   to be sure every elements of $params['expanded'] are really expanded
	//
	setcookie('phplm_collapse', '', false, '/');

	return $tikiphplayers->mkMenu($structure, '', $params['type'], '', 0, implode('|', $default_expand));
}
