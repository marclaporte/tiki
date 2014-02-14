<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Services_Goal_Controller
{
	function setUp()
	{
		Services_Exception_Disabled::check('goal_enabled');
		Services_Exception_Denied::checkAuth();
	}

	function action_show($input)
	{
		global $user;
		$goallib = TikiLib::lib('goal');
		$info = $goallib->fetchGoal($input->goalId->int());

		if (! $info) {
			throw new Services_Exception_NotFound;
		}

		$context = [
			'user' => $user,
			'group' => $input->group->groupname(),
			'groups' => Perms::get()->getGroups(),
		];

		if (! $goallib->isEligible($info, $context)) {
			throw new Services_Exception_Denied(tr('Not eligible for this goal'));
		}

		$info = $goallib->evaluateConditions($info, $context);

		return array(
			'title' => $info['name'],
			'goal' => $info,
		);
	}

	function action_admin($input)
	{
		$perms = Perms::get();
		if (! $perms->admin) {
			throw new Services_Exception_Denied(tr('Reserved to administrators'));
		}

		$goallib = TikiLib::lib('goal');

		$goals = $goallib->listGoals();

		return [
			'title' => tr('Manage Goals'),
			'list' => $goals,
		];
	}

	function action_create($input)
	{
		$perms = Perms::get();
		if (! $perms->admin) {
			throw new Services_Exception_Denied(tr('Reserved to administrators'));
		}

		$name = $input->name->text();
		$description = $input->description->text();

		if ($_SERVER['REQUEST_METHOD'] == 'POST' && $name) {
			$goallib = TikiLib::lib('goal');
			$id = $goallib->replaceGoal(0, array(
				'name' => $name,
				'description' => $description,
				'type' => 'user',
			));

			return [
				'FORWARD' => [
					'controller' => 'goal',
					'action' => 'edit',
					'goalId' => $id,
				],
			];
		}

		return [
			'title' => tr('Create Goal'),
			'name' => $name,
			'description' => $description,
			'type' => $type,
		];
	}

	function action_edit($input)
	{
		$perms = Perms::get();
		if (! $perms->admin) {
			throw new Services_Exception_Denied(tr('Reserved to administrators'));
		}

		$goallib = TikiLib::lib('goal');
		$goal = $goallib->fetchGoal($input->goalId->int());

		if (! $goal) {
			throw new Services_Exception_NotFound;
		}

		if ($_SERVER['REQUEST_METHOD'] == 'POST') {
			$type = $input->type->alpha();

			$goal['name'] = $input->name->text();
			$goal['description'] = $input->description->text();
			$goal['enabled'] = $input->enabled->int();
			$goal['eligible'] = $input->eligible->groupname();

			if (in_array($type, ['user', 'group'])) {
				$goal['type'] = $type;
			}

			$goallib->replaceGoal($input->goalId->int(), $goal);
		}

		return [
			'title' => tr('Edit Goal'),
			'goal' => $goal,
			'groups' => TikiLib::lib('user')->list_all_groups(),
		];
	}

	function action_delete($input)
	{
		$perms = Perms::get();
		if (! $perms->admin) {
			throw new Services_Exception_Denied(tr('Reserved to administrators'));
		}

		$goallib = TikiLib::lib('goal');
		$goal = $goallib->fetchGoal($input->goalId->int());

		if (! $goal) {
			throw new Services_Exception_NotFound;
		}

		$removed = false;
		if ($_SERVER['REQUEST_METHOD'] == 'POST') {
			$goallib->removeGoal($input->goalId->int());
			$removed = true;
		}

		return [
			'title' => tr('Remove Goal'),
			'removed' => $removed,
			'goal' => $goal,
			'groups' => TikiLib::lib('user')->list_all_groups(),
		];
	}
}

