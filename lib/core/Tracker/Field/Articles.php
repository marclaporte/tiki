<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: Files.php 50223 2014-03-05 19:11:54Z lphuberdeau $

class Tracker_Field_Articles extends Tracker_Field_Abstract
{
	public static function getTypes()
	{
		$options = array(
			'articles' => array(
				'name' => tr('Articles'),
				'description' => tr('Attach articles to the tracker item.'),
				'prefs' => array('trackerfield_articles', 'feature_articles'),
				'tags' => array('advanced'),
				'help' => 'Articles Tracker Field',
				'default' => 'n',
				'params' => array(
				),
			),
		);
		return $options;
	}

	function getFieldData(array $requestData = array())
	{
		global $prefs;
		$ins_id = $this->getInsertId();
		if (isset($requestData[$ins_id])) {
			$articleIds = array_filter(explode(',', $requestData[$ins_id]));
			$value = implode(',', $articleIds);
		} else {
			$value = $this->getValue();

			// Obtain the information from the database for display
			$articleIds = array_filter(explode(',', $value));
		}

		return array(
			'value' => $value,
			'articleIds' => $articleIds,
		);
	}

	function renderInput($context = array())
	{
		return $this->renderTemplate('trackerinput/articles.tpl', $context, array(
		));
	}

	function renderOutput($context = array())
	{
		return $this->renderTemplate('trackeroutput/articles.tpl', $context, array(
		));
	}

	function handleSave($value, $oldValue)
	{
		$new = array_diff(explode(',', $value), explode(',', $oldValue));
		$remove = array_diff(explode(',', $oldValue), explode(',', $value));

		$itemId = $this->getItemId();

		$relationlib = TikiLib::lib('relation');
		$relations = $relationlib->get_relations_from('trackeritem', $itemId, 'tiki.article.attach');
		foreach ($relations as $existing) {
			if ($existing['type'] != 'article') {
				continue;
			}

			if (in_array($existing['itemId'], $remove)) {
				$relationlib->remove_relation($existing['relationId']);
			}
		}

		foreach ($new as $articleId) {
			$relationlib->add_relation('tiki.article.attach', 'trackeritem', $itemId, 'article', $articleId);
		}

		return array(
			'value' => $value,
		);
	}
}

