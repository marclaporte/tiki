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
 * Class Table_Code_Other
 *
 *Creates code for standard jQuery functions needed outside of the main Tablesorter functions
 *
 * @package Tiki
 * @subpackage Table
 * @uses Table_Code_Manager
 */
class Table_Code_Other extends Table_Code_Manager
{

	public function setCode()
	{
		$jq = array();
		$sr = '';
		//reset sort button
		$x = array('reset' => '', 'savereset' => '');
		$s = parent::$s['sorts'];
		$s = isset($s['type']) && $s['type'] !== true && array_key_exists($s['type'], $x) ? $s : false;
		if ($s) {
			if ($s['type'] === 'savereset') {
				$sr = '.trigger(\'saveSortReset\')';
			}
			$jq[] = '$(\'button#' . $s['reset']['id'] . '\').click(function(){$(\'' . parent::$tid
				.'\').trigger(\'sortReset\')' . $sr . ';});';
			$htmlbefore[] = '<button id="' . $s['reset']['id'] . '" type="button" class="btn btn-default btn-xs">'
				. $s['reset']['text'] . '</button>';
		}

		//filters
		if (parent::$filters) {
			$f = parent::$s['filters'];
			//reset button
			if ($f['type'] === 'reset') {
				$htmlbefore[] = '<button id="' . $f['reset']['id'] . '" type="button" class="btn btn-default btn-xs">'
					. $f['reset']['text'] . '</button>';
			}

			//external dropdowns
			if (is_array($f['external'])) {
				foreach($f['external'] as $key => $info) {
					$xopt[] = ' value="">';
					foreach($info['options'] as $label => $val) {
						$xopt[] = ' value="' . $val . '">' . $label;
					}
					//create dropdown
					$divr[] = $this->iterate(
						$xopt,
						'<select id="' . $f['external'][$key]['id'] . '">',
						'</select>',
						'<option',
						'</option>',
						''
					);
					//trigger table update and filter when dropdown value is changed
					$jq[] = '$(\'#' . $f['external'][$key]['id'] . '\').bind(\'change\', function(e){'
						. $this->nt2 . '$(\'' . parent::$tid .'\').trigger(\'search\', [ [this.value] ]);'
						. $this->nt . '});';
					//filter-reset also clears any external dropdown filter (column filters cleared by tablesorter)
					if ($f['type'] === 'reset') {
						$reset[] = 'if ($(\'#' . $f['external'][$key]['id'] . '\').prop(\'selectedIndex\') != 0) {'
							. $this->nt3 . '$(\'#' . $f['external'][$key]['id'] . ' option\')[0].selected = true;'
							. $this->nt3 . '$(\'#' . $f['external'][$key]['id'] . '\').change();'
							. $this->nt2 . '}';
					}
				}
				if ($f['type'] === 'reset' && count($reset) > 0) {
					$jq[] = $this->iterate(
						$reset,
						'$(\'#' . $f['reset']['id'] . '\').click(function(){',
						$this->nt . '});',
						$this->nt2,
						'',
						''
					);
				}
				$htmlbefore[] = $this->iterate($divr, '<div style="float:right">', '</div>', '', '', '');
			}
		}


		$p = parent::$s['pager'];
		//pager controls
		if (parent::$pager) {
			$pagerdiv = array(
				'<div class="btn-group">',
				'	<span class="selectlabels">Page</span>',
				'	<select class="gotoPage"></select>',
				'</div>',
				'<div class="btn-group">',
				'	<button type="button" class="btn btn-default btn-sm first">',
				'		<i class="glyphicon glyphicon-step-backward"></i>',
				'	</button>',
				'	<button type="button" class="btn btn-default btn-sm prev">',
				'		<i class="glyphicon glyphicon-backward"></i>',
				'	</button>',
				'	<button class="btn btn-default btn-sm disabled pagedisplay">',
				'	</button>',
				'	<button type="button" class="btn btn-default btn-sm next">',
				'		<i class="glyphicon glyphicon-forward"></i>',
				'	</button>',
				'	<button type="button" class="btn btn-default btn-sm last">',
				'		<i class="glyphicon glyphicon-step-forward"></i>',
				'	</button>',
				'</div>',
			);
			foreach ($p['expand'] as $option) {
				$sel = $p['max'] === $option ? ' selected="selected"' : '';
				$opt[] = $sel . ' value="' . $option . '">' . $option;
			}
			if (isset($opt)) {
				$pagerdiv[] = $this->iterate(
					$opt,
					'<div class="btn-group"><span class="selectlabels">Rows</span><select class="pagesize">',
					'</select></div>',
					'<option',
					'</option>',
					''
				);
			}
			//put all pager controls in a div
			$pagerstring = $this->iterate(
				$pagerdiv,
				'<div class="' . $p['controls']['id'] . ' ts-pager ts-pager-top btn-toolbar">',
				'</div>',
				'',
				'',
				''
			);
			$htmlbefore[] = $pagerstring;
			$pagerstring = $this->iterate(
				$pagerdiv,
				'<div class="' . $p['controls']['id'] . ' ts-pager ts-pager-bottom btn-toolbar">',
				'</div>',
				'',
				'',
				''
			);
			$htmlafter[] = $pagerstring;
		}

		//add any reset/disable buttons just above the table
		if (isset($htmlbefore)) {
			$allhtmlbefore = $this->iterate($htmlbefore, '', '', '', '', '');
			$allhtmlafter = $this->iterate($htmlafter, '', '', '', '', '');
			array_unshift($jq, '$(\'' . parent::$tid . '\').before(\'' . $allhtmlbefore . '\'' . $this->nt
				. ').after(\'' . $allhtmlafter . '\'' . $this->nt . ');');
		}
		if (count($jq) > 0) {
			$code = $this->iterate($jq, '', '', $this->nt, '', '');
			parent::$code[self::$level1] = $code;
		}
	}
}
