<link rel="stylesheet" href="lib/sheet/style.css" type="text/css" />
<h1><a href="tiki-sheets.php" class="pagetitle">{tr}{$title}{/tr}</a></h1>

<div>
{$description}
</div>

{if $page_mode eq 'submit'}
{$grid_content}

{else}
	<form method="post" action="tiki-export_sheet.php?mode=export&sheetId={$sheetId}" enctype="multipart/form-data">
		<select name="handler">
{section name=key loop=$handlers}
			<option value="{$handlers[key].class}">{$handlers[key].name} V. {$handlers[key].version}</option>
{/section}
		</select>
		{tr}Charset encoding{/tr};
		<select name="encoding">
			<!--<option value="">{tr}Autodetect{/tr}</option>-->
		{section name=key loop=$charsets}
			<option value="{$charsets[key]}">{$charsets[key]}</option>
		{/section}
		</select>
		<input type="submit" value="{tr}Export{/tr}" />
	</form>
{/if}
