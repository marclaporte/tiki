<?php

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

$cacheToInvalidate = array( 'plugindesc' );

$pluginsAlias = $tikilib->plugin_get_list( false, true );
$pluginsReal = $tikilib->plugin_get_list( true, false );

if( $_SERVER['REQUEST_METHOD'] == 'POST' ) {
	if( isset( $_POST['enable'] ) ) {
		if( ! is_array( $_POST['enabled'] ) )
			$_POST['enabled'] = array();

		foreach( $pluginsAlias as $name ) {
			$tikilib->set_preference( "wikiplugin_$name", in_array( $name, $_POST['enabled'] ) ? 'y' : 'n' );
		}
	}

	if( isset( $_POST['save'] ) && ! in_array($_POST['plugin'], $pluginsReal) ) {
		$info = array(
			'implementation' => $_POST['implementation'],
			'description' => array(
				'name' => $_POST['name'],
				'description' => $_POST['description'],
				'prefs' => array(),
				'validate' => $_POST['validate'],
				'filter' => $_POST['filter'],
				'inline' => isset( $_POST['inline'] ),
				'params' => array(),
			),
			'body' => array(
				'input' => isset($_POST['ignorebody']) ? 'ignore' : 'use',
				'default' => $_POST['defaultbody'],
				'params' => array(),
			),
			'params' => array(
			),
		);

		if( empty($_POST['prefs']) )
			$temp = array( "wikiplugin_{$_POST['plugin']}" );
		else
			$temp =explode( ',', $_POST['prefs'] );

		$info['description']['prefs'] = $temp;

		if( isset($_POST['input']) ) {
			foreach( $_POST['input'] as $param ) {
				if( !empty( $param['token'] ) && !empty($param['name']) ) {
					$info['description']['params'][ $param['token'] ] = array(
						'required' => isset($param['required']),
						'safe' => isset($param['safe']),
						'name' => $param['name'],
						'description' => $param['description'],
						'filter' => $param['filter'],
					);
				}
			}
		}

		if( isset($_POST['bodyparam']) ) {
			foreach( $_POST['bodyparam'] as $param ) {
				if( !empty( $param['token'] ) ) {
					$info['body']['params'][ $param['token'] ] = array(
						'input' => $param['input'],
						'encoding' => $param['encoding'],
						'default' => $param['default'],
					);
				}
			}
		}

		if( isset($_POST['sparams']) ) {
			foreach( $_POST['sparams'] as $detail ) {
				if( ! empty($detail['token']) ) {
					$info['params'][$detail['token']] = $detail['default'];
				}
			}
		}

		if( isset($_POST['cparams']) ) {
			foreach( $_POST['cparams'] as $detail ) {
				if( ! empty($detail['token']) ) {
					$info['params'][$detail['token']] = array(
						'pattern' => $detail['pattern'],
						'params' => array(),
					);

					foreach( $detail['params'] as $param ) {
						if( !empty( $param['token'] ) ) {
							$info['params'][$detail['token']]['params'][ $param['token'] ] = array(
								'input' => $param['input'],
								'encoding' => $param['encoding'],
								'default' => $param['default'],
							);
						}
					}
				}
			}
		}

		$tikilib->plugin_alias_store( $_POST['plugin'], $info );
		if( ! in_array( $_POST['plugin'], $pluginsAlias ) )
			$pluginAlias[] = $_POST['plugins'];

		foreach( glob( 'temp/cache/wikiplugin_*' ) as $file )
			unlink( $file );
	}
}

if( isset($_REQUEST['plugin']) && $pluginInfo = $tikilib->plugin_alias_info($_REQUEST['plugin']) ) {
	// Add an extra empty parameter to create new ones
	$pluginInfo['description']['params']['__NEW__'] = array(
		'name' => '',
		'description' => '',
		'required' => '',
		'safe' => '',
	);
	$pluginInfo['body']['params']['__NEW__'] = array(
		'encoding' => '',
		'input' => '',
		'default' => '',
	);
	$pluginInfo['params']['__NEW__'] = array(
		'pattern' => '',
		'params' => array(),
	);

	foreach( $pluginInfo['params'] as &$p )
		if( is_array( $p ) )
			$p['params']['__NEW__'] = array(
				'encoding' => '',
				'input' => '',
				'default' => '',
			);

	$smarty->assign( 'plugin', $pluginInfo );
}

$smarty->assign( 'plugins_alias', $pluginsAlias );
$smarty->assign( 'plugins_real', $pluginsReal );

?>