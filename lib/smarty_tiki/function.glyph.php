<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function smarty_function_glyph($params)
{
	if (empty($params['name']))
		return;
	$has_title = (! empty($params['alt']) || ! empty($params['title']));
	$title = "";
	if ($has_title) {
		if (! empty($params['alt']))
			$title = $params['alt'];
		else
			$title = $params['title'];
	}
	$cssclass = "glyphicon glyphicon-{$params['name']}";
	if (! empty($params['class']))
		$cssclass .= " " . $params['class'];
	if ($has_title)
		$cssclass .= " tooltips";

	$html = "<span class=\"$cssclass\"";
	if (! empty($params['_id']))
		$html .= " id=\"" . $params['_id'] . "\"";
	if ($has_title)
		$html .= " title=\"" . $title . "\"";
	if ($has_title)
		$html .= " alt=\"" . $title . "\"";
	$html .= "></span>";
	return $html;
}

