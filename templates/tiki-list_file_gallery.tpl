<a class="pagetitle" href="tiki-list_file_gallery.php?galleryId={$galleryId}">{tr}Listing Gallery{/tr}: {$name}</a><br/><br/>
[{if $tiki_p_admin_file_galleries eq 'y' or ($user and $user eq $owner)}
  <a  href="tiki-file_galleries.php?edit_mode=1&amp;galleryId={$galleryId}" class="gallink">{tr}edit gallery{/tr}</a> 
{/if}
{if $tiki_p_upload_files eq 'y'}
{if $tiki_p_admin_file_galleries eq 'y' or ($user and $user eq $owner) or $public eq 'y'}
    |<a href="tiki-upload_file.php?galleryId={$galleryId}" class="gallink">{tr}upload file{/tr}</a>
{/if}
{/if}
{if $rss_file_gallery eq 'y'}
|<a href="tiki-file_gallery_rss.php?galleryId={$galleryId}" class="gallink">RSS</a>
{/if}]<br/><br/>
{if $tiki_p_create_file_galleries eq 'y'}
{if $edit_mode eq 'y'}
<h3>{tr}Edit a file using this form{/tr}</h3>
<div  align="center">
<form action="tiki-list_file_gallery.php" method="post">
<input type="hidden" name="galleryId" value="{$galleryId}" />
<input type="hidden" name="fileId" value="{$fileId}" />
<table class="editfgalform">
<tr><td class="editfgalform">{tr}Name{/tr}:</td><td class="editfgalform"><input type="text" name="fname" value="{$fname}"/></td></tr>
<tr><td class="editfgalform">{tr}Description{/tr}:</td><td class="editfgalform"><textarea rows="5" cols="40" name="fdescription">{$fdescription}</textarea></td></tr>
<tr><td class="editfgalform">&nbsp;</td><td class="editfgalform"><input type="submit" value="{tr}edit{/tr}" name="edit" /></td></tr>
</table>
</form>
</div>
<br/>
{/if}
{/if}

  
{if strlen($description) > 0}
    {$description}
    <br/>
{/if}

  <h3>{tr}Gallery Files{/tr}</h3>
<div align="center">
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
   <td class="findtable">
   <form method="get" action="tiki-list_file_gallery.php">
     <input type="hidden" name="galleryId" value="{$galleryId}" />
     <input type="text" name="find" value="{$find}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode}" />
   </form>
   </td>
</tr>
</table>
<form method="get" action="tiki-list_file_gallery.php">
	<input type="hidden" name="galleryId" value="{$galleryId}" />
    <input type="hidden" name="find" value="{$find}" />
    <input type="hidden" name="sort_mode" value="{$sort_mode}" />
<table class="listfiles">
{if $tiki_p_admin_file_galleries eq 'y'}
<tr>
	<td class="heading" colspan="16">
	{tr}Actions{/tr}
	</td>
</tr>
<tr>	
	<td class="even" colspan="16">
	
	<input type="image" name="movesel" src="img/icons/topic_move.gif" border='0' alt='{tr}move{/tr}' title='{tr}move selected files{/tr}' />
	<input type="image" name="delsel" src="img/icons/topic_delete.gif" border='0' alt='{tr}delete{/tr}' title='{tr}delete selected files{/tr}' />
	
	</td>
</tr>
{if $smarty.request.movesel_x} 
<tr>
	<td class="even" colspan="18">
	{tr}Move to{/tr}:
	<select name="moveto">
		{section name=ix loop=$all_galleries}
			{if $all_galleries[ix].galleryId ne $galleryId}
				<option value="{$all_galleries[ix].galleryId}">{$all_galleries[ix].name}</option>
			{/if}
		{/section}
	</select>
	<input type='submit' name='movesel' value='{tr}move{/tr}' />
	</td>
</tr>
{/if}
{/if}

<tr>
{if $tiki_p_admin_file_galleries eq 'y'}
<td width="2%" class="listfilesheading">&nbsp;</td>
{/if}
{if $gal_info.show_id eq 'y'}
	<td width="4%" class="listfilesheading"><a class="llistfileslink" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'fileId_desc'}fileId_asc{else}fileId_desc{/if}">{tr}ID{/tr}</a></td>
{/if}
<td class="listfilesheading"><a class="llistfileslink" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'filename_desc'}filename_asc{else}filename_desc{/if}">{tr}Name{/tr}</a></td>
{if $gal_info.show_size eq 'y'}
	<td width="12%" style="text-align:right;" class="listfilesheading"><a class="llistfileslink" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'filesize_desc'}filesize_asc{else}filesize_desc{/if}">{tr}Filesize{/tr}</a></td>
{/if}
{if $gal_info.show_description eq 'y'}
	<td width="25%" class="listfilesheading"><a class="llistfileslink" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'description_desc'}description_asc{else}description_desc{/if}">{tr}Description{/tr}</a></td>
{/if}
{if $gal_info.show_created eq 'y'}
	<td width="16%" class="listfilesheading"><a class="llistfileslink" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'created_desc'}created_asc{else}created_desc{/if}">{tr}Created{/tr}</a></td>
{/if}
{if $gal_info.show_dl eq 'y'}
	<td style="text-align:right;" width="5%" class="listfilesheading"><a class="llistfileslink" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'downloads_desc'}downloads_asc{else}downloads_desc{/if}">{tr}Dls{/tr}</a></td>
{/if}
<td width="8%" class="listfilesheading">Actions</td>
</tr>




{cycle values="odd,even" print=false}
{section name=changes loop=$images}
<tr>

{if $tiki_p_admin_file_galleries eq 'y'}
<td width="2%" style="text-align:center;" class="listfilesid{cycle advance=false}">
	<input type="checkbox" name="file[]" value="{$images[changes].fileId}"  {if $smarty.request.file and in_array($images[changes].fileId,$smarty.request.file)}checked="checked"{/if} />
</td>
{/if}

{if $gal_info.show_id eq 'y'}
	<td class="listfilesid{cycle advance=false}">{$images[changes].fileId}</td>
{/if}

<td class="listfilesfilename{cycle advance=false}">
	{if $gal_info.show_icon eq 'y'}
		{$images[changes].filename|iconify}
	{/if}
	
	{if $tiki_p_download_files eq 'y'}
		<a class="fgalname" href="tiki-download_file.php?fileId={$images[changes].fileId}">
	{/if}
	{if ($images[changes].name != "") and $gal_info.show_name ne 'f'}
		{$images[changes].name}
	{else}
		{$images[changes].filename}
	{/if}
	{if $tiki_p_download_files eq 'y'}
		</a>
	{/if}
	{if $gal_info.show_name eq 'a'}
			({$images[changes].filename})
	{/if}
</td>

{if $gal_info.show_size eq 'y'}
	<td style="text-align:right;" class="listfilesfilesize{cycle advance=false}">{$images[changes].filesize|kbsize}&nbsp;</td>
{/if}

{if $gal_info.show_description eq 'y'}
	<td class="listfilesdescription{cycle advance=false}">{$images[changes].description|truncate:$gal_info.max_desc:"..."}&nbsp;</td>
{/if}
	
{if $gal_info.show_created eq 'y'}
	<td class="listfilescreated{cycle advance=false}">{$images[changes].created|tiki_short_date}{if $images[changes].user} {tr}by{/tr} {$images[changes].user}{/if}&nbsp;</td>
{/if}

{if $gal_info.show_dl eq 'y'}
	<td style="text-align:right;" class="listfilesdls{cycle advance=false}">{$images[changes].downloads}&nbsp;</td>
{/if}

<td class="listfilesactions{cycle}">
	{if $tiki_p_admin_file_galleries eq 'y' or ($user and $user eq $owner)}
		<a class="link" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;edit_mode=1&amp;fileId={$images[changes].fileId}"><img src='img/icons/edit.gif' border='0' alt='{tr}edit{/tr}' title='{tr}edit{/tr}' /></a>
		<a class="link" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$images[changes].fileId}"><img src='img/icons2/delete.gif' border='0' alt='{tr}delete{/tr}' title='{tr}delete{/tr}' /></a>
	{/if}
	&nbsp;
</td>
<!--<td class="listfilesuser{cycle advance=false}">{$images[changes].user}&nbsp;</td>-->
</td>
</tr>
{sectionelse}
<tr><td colspan="16">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
</table>
</form>

<br/>
  <div class="mini">
      {if $prev_offset >= 0}
        [<a class="fgalprevnext" href="tiki-list_file_gallery.php?find={$find}&amp;galleryId={$galleryId}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}prev{/tr}</a>]&nbsp;
      {/if}
      {tr}Page{/tr}: {$actual_page}/{$cant_pages}
      {if $next_offset >= 0}
      &nbsp;[<a class="fgalprevnext" href="tiki-list_file_gallery.php?find={$find}&amp;galleryId={$galleryId}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}next{/tr}</a>]
      {/if}
      {if $direct_pagination eq 'y'}
<br/>
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="tiki-list_file_gallery.php?find={$find}&amp;galleryId={$galleryId}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
{$smarty.section.foo.index_next}</a>&nbsp;
{/section}
{/if}

  </div>
</div>
{if $feature_file_galleries_comments eq 'y'}
{include file=comments.tpl}
{/if}
