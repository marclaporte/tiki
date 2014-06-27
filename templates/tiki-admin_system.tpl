{* $Id$ *}

{title help="System+Admin"}{tr}Tiki Cache/System Admin{/tr}{/title}

{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}If your Tiki is acting weird, first thing to try is to clear your cache below. Also very important is to clear your cache after an upgrade (by FTP/SSH when needed).{/tr} {tr}Also see "Rebuild Index" in the <a class="alert-link" href="tiki-admin.php?page=search">Search Admin Panel</a>{/tr}
{/remarksbox}

<h2>{fa name="trash-o"} {tr}Clear cached content{/tr}</h2>
<div class="well well-sm text-center">
	<a href="tiki-admin_system.php?do=all" class="btn btn-primary" title="{tr}Empty{/tr}">{fa name="trash-o"} {tr}Clear all cache{/tr}</a>
</div>
<table class="table normal table-hover">
	<tr>
		<th>{tr}Clear selected directory{/tr}</th>
		<th>{tr}Files{/tr}/{tr}Size{/tr}</th>
		<th>{tr}Action{/tr}</th>
	</tr>
	<tr>
		<td><b>./templates_c/</b></td>
		<td>({$templates_c.cant} {tr}Files{/tr} / {$templates_c.total|kbsize|default:'0 Kb'})</td>
		<td><a href="tiki-admin_system.php?do=templates_c" class="btn btn-primary btn-sm" title="{tr}Empty{/tr}">{fa name="trash-o"}</a></td>
	</tr>
	<tr>
		<td><b>./modules/cache/</b></td>
		<td>({$modules.cant} {tr}Files{/tr} / {$modules.total|kbsize|default:'0 Kb'})</td>
		<td><a href="tiki-admin_system.php?do=modules_cache" class="btn btn-primary btn-sm" title="{tr}Empty{/tr}">{fa name="trash-o"}</a></td>
	</tr>
	<tr>
		<td><b>./temp/cache/</b></td>
		<td>({$tempcache.cant} {tr}Files{/tr} / {$tempcache.total|kbsize|default:'0 Kb'})</td>
		<td><a href="tiki-admin_system.php?do=temp_cache" class="btn btn-primary btn-sm" title="{tr}Empty{/tr}">{fa name="trash-o"}</a></td>
	</tr>
	<tr>
		<td><b>./temp/public/</b></td>
		<td>({$temppublic.cant} {tr}Files{/tr} / {$temppublic.total|kbsize|default:'0 Kb'})</td>
		<td><a href="tiki-admin_system.php?do=temp_public" class="btn btn-primary btn-sm" title="{tr}Empty{/tr}">{fa name="trash-o"}</a></td>
	</tr>
	<tr>
		<td colspan="2"><b>{tr}All user prefs sessions{/tr}</b></td>
		<td><a href="tiki-admin_system.php?do=prefs" class="btn btn-primary btn-sm" title="{tr}Empty{/tr}">{fa name="trash-o"}</a></td>
	</tr>
</table>
<br>

{if count($dirs) && $tiki_p_admin eq 'y'}
	<h2>{fa name="file-archive-o"} {tr}Directories to save{/tr}</h2>
	<form  method="post" action="{$smarty.server.PHP_SELF|escape}">
		<p><label>{tr}Full Path to the Zip File:{/tr}<input type="text" name="zipPath" value="{$zipPath|escape}"></label>
		<input type="submit" class="btn btn-primary btn-sm" name="zip" value="{tr}Generate a zip of those directories{/tr}"></p>
		{if $zipPath}
			<div class="alert alert-warning">{tr _0=$zipPath}A zip has been written to %0{/tr}</div>
		{/if}
	</form>
	<ul>
		{foreach from=$dirs item=d key=k}
			<li>{$d|escape}{if !$dirsWritable[$k]} <i>({tr}Directory is not writeable{/tr})</i>{/if}</li>
		{/foreach}
	</ul>
{/if}

{if !empty($lostGroups)}
	<h2>{tr}Clean{/tr}</h2>
	{tr}Groups still used in the database but no more defined.{/tr} {self_link clean="y"}{tr}Click to remove.{/tr}{/self_link}
	<ul>
	{foreach item=g from=$lostGroups}
		<li>{$g|escape}</li>
	{/foreach}
	</ul>
{/if}