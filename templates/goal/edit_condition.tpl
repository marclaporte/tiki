{extends "layout_view.tpl"}

{block name="title"}
	{title}{$title}{/title}
{/block}

{block name="content"}
	<form class="form-horizontal condition-form" method="post" action="{service controller=goal action=edit_condition}">
		<div class="form-group">
			<label class="control-label col-md-3">{tr}Label{/tr}</label>
			<div class="col-md-9">
				<input type="text" class="form-control" name="label" value="{$condition.label|escape}">
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-3">{tr}Operator{/tr}</label>
			<div class="col-md-9">
				<label class="radio-inline">
					<input type="radio" name="operator" value="atLeast" {if $condition.operator neq 'atMost'} checked {/if}>
					{tr}At Least{/tr}
				</label>
				<label class="radio-inline">
					<input type="radio" name="operator" value="atMost" {if $condition.operator eq 'atMost'} checked {/if}>
					{tr}At Most{/tr}
				</label>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-3">{tr}Count{/tr}</label>
			<div class="col-md-9">
				<input type="number" class="form-control" name="count" value="{$condition.count|escape}">
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-3">{tr}Metric{/tr}</label>
			<div class="col-md-9">
				<select name="metric" class="form-control">
					{foreach $metrics as $key => $metric}
						<option value="{$key|escape}" {if $condition.metric eq $key} selected {/if} data-arguments="{$metric.arguments|json_encode|escape}">{$metric.label|escape}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div class="form-group argument eventType">
			<label class="control-label col-md-3">{tr}Event Type{/tr}</label>
			<div class="col-md-9">
				<input type="text" class="form-control" name="eventType" value="{$condition.eventType|escape}">
			</div>
		</div>
		<div class="submit col-md-offset-3">
			<input type="submit" class="btn btn-primary" value="{tr}Save{/tr}">
		</div>
	</form>
	{jq}
		$('.condition-form select[name=metric]').change(function () {
			$('.condition-form .form-group.argument').hide();

			$.each(this.selectedOptions, function (key, item) {
				$.each($(item).data('arguments'), function (key, arg) {
					$('.condition-form .form-group.argument.' + arg).show();
				});
			})
		}).change();
	{/jq}
{/block}
