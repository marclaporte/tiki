{* $Id$ *}

{title help="Surveys"}{tr}Admin surveys{/tr}{/title}

<div class="navbar">
	{button href="tiki-list_surveys.php" _text="{tr}List Surveys{/tr}"}
	{button href="tiki-survey_stats.php" _text="{tr}Survey Stats{/tr}"}
</div>

{if $info.surveyId > 0}
	<h2>{tr}Edit this Survey:{/tr} {$info.name}</h2>
{else}
	<h2>{tr}Create New Survey{/tr}</h2>
{/if}

{if $individual eq 'y'}
	<a class="link" href="tiki-objectpermissions.php?objectName={$info.name|escape:"url"}&amp;objectType=survey&amp;permType=surveys&amp;objectId={$info.surveyId}">{tr}There are individual permissions set for this survey{/tr}</a><br /><br />
{/if}

<form action="tiki-admin_surveys.php" method="post">
	<input type="hidden" name="surveyId" value="{$info.surveyId|escape}" />
	<table class="normal">
		<tr class="formcolor">
			<td>{tr}Name{/tr}:</td>
			<td><input type="text" name="name" size="80" value="{$info.name|escape}" /></td>
		</tr>
		<tr class="formcolor">
			<td>{tr}Description{/tr}:</td>
			<td>{textarea name="description" rows="6" cols="80" _quicktags='y' _zoom='n'}{$info.description}{/textarea}</td>
		</tr>
		{include file=categorize.tpl}
		<tr class="formcolor">
			<td>{tr}Status{/tr}</td>
			<td>
				<select name="status">
					<option value="o" {if $info.status eq 'o'}selected='selected'{/if}>{tr}Open{/tr}</option>
					<option value="c" {if $info.status eq 'c'}selected='selected'{/if}>{tr}closed{/tr}</option>
				</select>
			</td>
		</tr>
		<tr class="formcolor">
			<td>&nbsp;</td>
			<td>
				<input type="submit" name="save" value="{tr}Save{/tr}" />
			</td>
		</tr>
	</table>
</form>

<br />

<h2>{tr}Surveys{/tr}</h2>
{if $channels or ($find ne '')}
	{include file='find.tpl'}
{/if}

<table class="normal">
	<tr>
		<th>
			<a href="tiki-admin_surveys.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'surveyId_desc'}surveyId_asc{else}surveyId_desc{/if}">{tr}ID{/tr}</a>
		</th>
		<th>
			<a href="tiki-admin_surveys.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">{tr}Survey{/tr}</a>
		</th>
		<th>
			<a href="tiki-admin_surveys.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'status_desc'}status_asc{else}status_desc{/if}">{tr}Status{/tr}</a>
		</th>
		<th>{tr}Questions{/tr}</th>
		<th>{tr}Action{/tr}</th>
	</tr>
	
	{cycle values="odd,even" print=false}
	{section name=user loop=$channels}
		<tr>
			<td class="{cycle advance=false}">{$channels[user].surveyId}</td>
			<td class="{cycle advance=false}">
				<b>{$channels[user].name}</b>
				<div class="subcomment">
					{wiki}{$channels[user].description|escape}{/wiki}
				</div>
			</td>
			<td style="text-align:center;" class="{cycle advance=false}">
				{if $channels[user].status eq 'o'}
					{icon _id=ofolder alt="Open"}
				{else}
					{icon _id=folder alt="closed"}
				{/if}
			</td>
			<td style="text-align:right;" class="{cycle advance=false}">{$channels[user].questions}</td>
			<td class="{cycle}">
				<a class="link" href="tiki-admin_surveys.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;surveyId={$channels[user].surveyId}">{icon _id='page_edit' alt='{tr}Edit{/tr}'}</a>
				<a class="link" href="tiki-admin_survey_questions.php?surveyId={$channels[user].surveyId}">{icon _id='help' alt='{tr}Questions{/tr}' title='{tr}Questions{/tr}'}</a>
				<a class="link" href="tiki-admin_surveys.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].surveyId}">{icon _id='cross' alt='{tr}Remove{/tr}'}</a>
				{if $channels[user].individual eq 'y'}
					<a class="link" href="tiki-objectpermissions.php?objectName={$channels[user].name|escape:"url"}&amp;objectType=survey&amp;permType=surveys&amp;objectId={$channels[user].surveyId}">{icon _id='key_active' alt='{tr}Active Perms{/tr}'}</a>
				{else}
					<a class="link" href="tiki-objectpermissions.php?objectName={$channels[user].name|escape:"url"}&amp;objectType=survey&amp;permType=surveys&amp;objectId={$channels[user].surveyId}">{icon _id='key' alt='{tr}Perms{/tr}'}</a>
				{/if}
			</td>
		</tr>
	{sectionelse}
		<tr>
			<td class="odd" colspan="6">{tr}No records found.{/tr}</td>
		</tr>
	{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}