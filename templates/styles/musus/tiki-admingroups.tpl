{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/tiki-admingroups.tpl,v 1.4 2004-01-26 03:50:20 musus Exp $ *}
<a class="pagetitle" title="" href="tiki-admingroups.php">{tr}Admin groups{/tr}</a>
{if $feature_help eq 'y'}
<a class="tikihelp" title="{tr}Tikiwiki.org help{/tr}: {tr}admin groups{/tr}" href="http://tikiwiki.org/tiki-index.php?page=PermissionAdmin" target="tikihelp">
{$helpIcon $helpIconDesc}{/if}
{if $feature_help eq 'y'}</a>{/if}

{if $feature_view_tpl eq 'y'}
<a class="tikihelp" title="{tr}View tpl{/tr}: {tr}admin groups tpl{/tr}" href="tiki-edit_templates.php?template=templates/tiki-admingroups.tpl" target="tikihelp">
<img src="img/icons/info.gif" alt="{tr}edit template{/tr}" />{/if}
{if $feature_view_tpl eq 'y'}</a>{/if}
<br />
<br />
{if $groupname eq ''}
<h3>{tr}Add New Group{/tr}</h3>
{else}
<h3>{tr}Edit this group:{/tr} {$groupname}</h3>
<a title="" href="tiki-admingroups.php">{tr}Add new group{/tr}</a>
{/if}
<form action="tiki-admingroups.php" method="post">
<table>
<tr><td><label for="groups_group">{tr}Group{/tr}:</label></td><td><input type="text" name="name" id="groups_group" value="{$groupname|escape}" /></td></tr>
<tr><td><label for="groups_desc">{tr}Description{/tr}:</label></td><td><textarea rows="5" cols="20" name="desc" id="groups_desc">{$groupdesc}</textarea></td></tr>
<tr><td><label for="groups_inc">{tr}Include{/tr}:</label></td><td>
	<select name="include_groups[]" id="groups_inc" multiple="multiple" size="4">
	{section name=ix loop=$users}
		{assign var=inced value=$users[ix].groupName}
		<option value="{$inced|escape}" {if $inc.$inced eq 'y'} selected="selected"{/if}>{$inced}</option>
	{/section}
	</select></td></tr>
<tr><td><label for="groups_home">{tr}Home page{/tr}</label></td><td><input type="text" id="groups_home" value="{$grouphome|escape}" /></td>
{if $group ne ''}
	<tr><td><input type="hidden" value="{$group|escape}"></td><td><input type="submit" name="save" value="{tr}Save{/tr}" /></td></tr>
	{else}
	<tr><td>&nbsp;</td><td><input type="submit" name="newgroup" value="{tr}Add{/tr}" /></td></tr>
{/if}
</table>
</form>
<br /><br />
<h3>{tr}List of existing groups{/tr}</h3>
<div align="center">
<table class="findtable">
<tr><td><label for="groups_find">{tr}Find{/tr}</label></td>
   <td>
   <form method="get" action="tiki-admingroups.php">
     <input type="text" name="find" id="groups_find" value="{$find|escape}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
   </form>
   </td>
</tr>
</table>
<table>
<tr>
	<th><a href="tiki-admingroups.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'groupName_desc'}groupName_asc{else}groupName_desc{/if}">{tr}name{/tr}</a></th>
	<th><a href="tiki-admingroups.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'groupDesc_desc'}groupDesc_asc{else}groupDesc_desc{/if}">{tr}desc{/tr}</a></th>
	<th>{tr}Includes{/tr}</th>
	<th>{tr}Permissions{/tr}</th>
	<th>{tr}action{/tr}</th>
</tr>
{cycle values="even,odd" print=false}
{section name=user loop=$users}
<tr>
<td class="{cycle advance=false}">{$users[user].groupName}</td>
<td class="{cycle advance=false}">{$users[user].groupDesc}</td>
<td class="{cycle advance=false}">
{section name=ix loop=$users[user].included}
{$users[user].included[ix]}<br />
{/section}
</td>
<td class="{cycle advance=false}">
{section name=grs loop=$users[user].perms}
{$users[user].perms[grs]}(<a href="tiki-admingroups.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;permission={$users[user].perms[grs]}&amp;group={$users[user].groupName}&amp;action=remove">x</a>)<br />
{/section}
</td>
<td class="{cycle}">
{if $users[user].groupName !== 'Anonymous'}
<a href="tiki-admingroups.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;action=delete&amp;group={$users[user].groupName}" 
onclick="return confirmTheLink(this,'{tr}Are you sure you want to delete this group?{/tr}')" 
title="Click here to delete this group"><img alt="{tr}Remove{/tr}" src="img/icons2/delete.gif" /></a>
{/if}
<a href="tiki-assignpermission.php?group={$users[user].groupName}" title="Click here to assign permissions to this group"><img alt="{tr}Assign Permissions{/tr}" src="img/icons/key.gif" /></a>
<a href="tiki-admingroups.php?group={$users[user].groupName}" title="Click here to edit this group"><img alt="{tr}Edit{/tr}" src="img/icons/edit.gif" /></a>
</td>
</tr>
{/section}
</table>
<br />
<div class="mini">
{if $prev_offset >= 0}
[<a class="prevnext" href="tiki-admingroups.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}prev{/tr}</a>] 
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
 [<a class="prevnext" href="tiki-admingroups.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}next{/tr}</a>]
{/if}
{if $direct_pagination eq 'y'}
<br />
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="tiki-admingroups.php?find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
{$smarty.section.foo.index_next}</a> 
{/section}
{/if}
</div>
</div>
