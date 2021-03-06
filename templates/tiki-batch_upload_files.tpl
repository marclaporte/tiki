{title}{tr}Directory batch upload{/tr}{/title}

<div class="t_navbar btn-group form-group">
	{if $galleryId ne ''}
		{button href="tiki-list_file_gallery.php?galleryId=$galleryId" class="btn btn-default" _text="{tr}Browse File Gallery{/tr}"}
	{else}
		{button href="tiki-list_file_gallery.php" class="btn btn-default" _text="{tr}Browse File Gallery{/tr}"}
	{/if}
	{button href="tiki-upload_file.php?galleryId=$galleryId" class="btn btn-default" _text="{tr}Upload From Disk{/tr}"}
</div>

{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}Please do not use this feature to upload data into the database.{/tr}{/remarksbox}

{if count($feedback)}<div class="alert alert-warning">{section name=i loop=$feedback}{$feedback[i]}<br>{/section}</div>{/if}

<h2>{$totfile} {tr}Available Files{/tr} {$totalsize|kbsize}</h2>
<form method="post" action="tiki-batch_upload_files.php" name="f">
	<table class="formcolor" id="filelist" width="100%">
		<tr>
			<th>
				{select_all checkbox_names='files[]'}
			</th>
			<th><a href="javascript:void(0);">{tr}Filename{/tr}</a></th>
			<th width="80"><a href="javascript:void(0);">{tr}Filesize{/tr}</a></th>
			<th width="80"><a href="javascript:void(0);">{tr}Filetype{/tr}</a></th>
		</tr>

		{foreach key=k item=it from=$filestring}
			<tr>
				<td class="checkbox-cell">
					<input type="checkbox" name="files[]" value="{$it[0]}" id="box_{$k}">
				</td>
				<td><label for="box_{$k}">{$it[0]}</label></td>
				<td>{$it[1]|kbsize}</td>
				<td>{$it[2]}</td>
			</tr>
		{/foreach}
	</table>
	<hr>
	<table class="formcolor">
		<tr><td><input type="checkbox" name="removeExt" value="true" id="removeExt" checked="checked"></td><td>{tr}Remove extension from filename{/tr}</td>
		<tr><td/><td>{tr}eg. from "digicam0001.jpg" then name digicam0001 will be used for the name field{/tr}</td></tr>
	</table>
<!--
{if $permAddGallery eq "y"}
&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" name="subdirToSubgal" value="true" id="subdirToSubgal"> {tr}Convert the last sub directory to a sub gallery{/tr}<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {tr}eg. from "misc/screenshots/digicam0001.jpg" a gallery named "screenshots" will be created{/tr}<br>
{/if}
-->
	<table class="formcolor">
		<tr><td><input type="checkbox" name="subToDesc" value="true" id="subToDesc"></td><td>{tr}Use the last sub directory name as description{/tr}</td></tr>
		<tr><td/><td>{tr}eg. from "misc/screenshots/digicam0001.jpg" a description "screenshots" will be created{/tr}</td></tr>
	</table>
	<table class="formcolor">
		<tr>
			<td>{tr}Select a File Gallery{/tr}</td>
			<td>
				<select name="galleryId">
					<option value="{$treeRootId}" {if $treeRootId eq $galleryId}selected="selected"{/if} style="font-style:italic; border-bottom:1px dashed #666;">{tr}Root{/tr}</option>
					{section name=idx loop=$galleries}
						{if ($galleries[idx].individual eq 'n') or ($galleries[idx].individual_tiki_p_batch_upload_file_dir eq 'y')}
							<option value="{$galleries[idx].id}" {if $galleries[idx].id eq $galleryId}selected="selected"{/if}>{$galleries[idx].name}</option>
						{/if}
					{/section}
				</select>
			</td>
			<td><input type="submit" class="btn btn-default btn-sm" name="batch_upload" value="{tr}Process files{/tr}"></td>
		</tr>
	</table>
</form>
