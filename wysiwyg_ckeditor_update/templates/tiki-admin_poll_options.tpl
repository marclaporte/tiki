{title url="tiki-admin_poll_options.php?pollId=$pollId"}{tr}Admin Polls:{/tr} {$menu_info.title|escape}{/title}

<div class="navbar">
	{button href="tiki-admin_polls.php" _text="{tr}List polls{/tr}"}
	{button href="tiki-admin_polls.php?pollId=$pollId" _text="{tr}Edit this poll{/tr}"}
</div>

<h2>{tr}Preview poll{/tr}</h2>
<div align="center">
	<div style="text-align:left;width:130px;" class="cbox">
		<div class="cbox-title">{$menu_info.name}</div>
		<div class="cbox-data">
			{include file='tiki-poll.tpl'}
		</div>
	</div>
</div>

<br />

<h2>{if $optionId eq ''}{tr}Add poll option{/tr}{else}{tr}Edit poll option{/tr}{/if}</h2>
<form action="tiki-admin_poll_options.php" method="post">
<input type="hidden" name="optionId" value="{$optionId|escape}" />
<input type="hidden" name="pollId" value="{$pollId|escape}" />
<table>
<tr>
<td class="form">{tr}Option:{/tr}</td><td><input type="text" name="title" value="{$title|escape}" size=40/></td>
<td class="form">{tr}Position:{/tr}</td><td><input type="text" name="position" value="{$position|escape}" size="4" /></td>
<td colspan="2"><input type="submit" name="save" value="{tr}Save{/tr}" /></td></tr>
</table>
</form>
<br />
<h2>{tr}Poll options{/tr}</h2>
<div  align="center">
<table class="normal">
<tr>
<th>{tr}Position{/tr}</th>
<th>{tr}Title{/tr}</th>
<th>{tr}Votes{/tr}</th>
<th>{tr}Action{/tr}</th>
</tr>
{cycle values="even,odd" print=false}
{section name=user loop=$channels}
<tr>
<td class="{cycle advance=false}">{$channels[user].position}</td>
<td class="{cycle advance=false}">{$channels[user].title|escape}</td>
<td class="{cycle advance=false}">{$channels[user].votes}</td>
<td class="{cycle}">
   <a class="link" href="tiki-admin_poll_options.php?pollId={$pollId}&amp;remove={$channels[user].optionId}" title="{tr}Delete{/tr}">{icon _id=cross alt="{tr}Delete{/tr}"}</a>
   <a class="link" href="tiki-admin_poll_options.php?pollId={$pollId}&amp;optionId={$channels[user].optionId}" title="{tr}Edit{/tr}">{icon _id=page_edit}</a>
</td>
</tr>
{sectionelse}
<tr><td class="odd" colspan="4">{tr}No records found.{/tr}</td></tr>
{/section}
</table>
</div>

