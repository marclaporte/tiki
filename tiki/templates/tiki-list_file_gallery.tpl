{* $Header: /cvsroot/tikiwiki/tiki/templates/tiki-list_file_gallery.tpl,v 1.33 2006-11-19 20:14:56 mose Exp $ *}

<h1><a class="pagetitle" href="tiki-list_file_gallery.php?galleryId={$galleryId}">{tr}Listing Gallery{/tr}: {$name}</a></h1>

<table><tr>
<td style="vertical-align:top;">

<a href="tiki-file_galleries.php" class="linkbut" title="{tr}list galleries{/tr}">{tr}list galleries{/tr}</a>

{if $tiki_p_admin_file_galleries eq 'y' or $user eq $gal_info.user}
  <a href="tiki-file_galleries.php?edit_mode=1&amp;galleryId={$galleryId}" class="linkbut" title="{tr}edit gallery{/tr}">{tr}edit gallery{/tr}</a>
{/if}

{if $tiki_p_admin_file_galleries eq 'y' or $user eq $gal_info.user or $gal_info.public eq 'y'}
  {if $tiki_p_upload_files eq 'y'}
    <a href="tiki-upload_file.php?galleryId={$galleryId}" class="linkbut">{tr}upload file{/tr}</a>
  {/if}
  {if $feature_file_galleries_batch eq "y" and $tiki_p_batch_upload_file_dir eq 'y'}
    <span class="button2"><a href="tiki-batch_upload_files.php?galleryId={$galleryId}" class="linkbut">{tr}Directory batch{/tr}</a></span>
  {/if}
{/if}

{if $rss_file_gallery eq 'y'}
	{if $gal_info.type eq "podcast" or $gal_info.type eq "vidcast"}
	<a href="tiki-file_gallery_rss.php?galleryId={$galleryId}&amp;ver=PODCAST">
	<img src='img/rss_podcast_80_15.png' border='0' alt='{tr}RSS feed{/tr}' title='{tr}RSS feed{/tr}' /></a>
	{else}
	<a href="tiki-file_gallery_rss.php?galleryId={$galleryId}">
	<img src='pics/icons/feed.png' border='0' alt='{tr}RSS feed{/tr}' title='{tr}RSS feed{/tr}' /></a>
	{/if}
{/if}

</td>
<td style="text-align:right;width:142px;wrap:nowrap">

       {if $user and $feature_user_watches eq 'y'}
		{if $user_watching_file_gallery eq 'n'}
			<a href="tiki-list_file_gallery.php?galleryId={$galleryId|escape:"url"}&amp;galleryName={$name|escape:"url"}&amp;watch_event=file_gallery_changed&amp;watch_object={$galleryId|escape:"url"}&amp;watch_action=add">{html_image file='pics/icons/eye.png' border='0' alt='{tr}monitor this gallery{/tr}' title='{tr}monitor this gallery{/tr}'}</a>
		{else}
			<a href="tiki-list_file_gallery.php?galleryId={$galleryId|escape:"url"}&amp;galleryName={$name|escape:"url"}&amp;watch_event=file_gallery_changed&amp;watch_object={$galleryId|escape:"url"}&amp;watch_action=remove">{html_image file='pics/icons/no_eye.png' border='0' alt='{tr}stop monitoring this gallery{/tr}' title='{tr}stop monitoring this gallery{/tr}'}</a>
		{/if}
	{/if}  

</td></tr></table>

<table>
<tr><td width="48">
{if $gal_info.type eq "podcast"}
<img src='pics/large/gnome-sound-recorder48x48.png' border='0' alt='{tr}podcast (audio){/tr}' />
{elseif $gal_info.type eq "vidcast"}
<img src='pics/large/mplayer48x48.png' border='0' alt='{tr}podcast (video){/tr}' />
{else}
<img src='pics/large/file-manager48x48.png' border='0' alt='{tr}file gallery{/tr}' />
{/if}
</td>
<td style="vertical-align:top; text-align:left;" width="100%">
{$description|escape}
</td></tr></table>

<h2>{tr}Gallery Files{/tr}</h2>
<div align="center">
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
   <td class="findtable">
   <form method="get" action="tiki-list_file_gallery.php">
     <input type="hidden" name="galleryId" value="{$galleryId|escape}" />
     <input type="text" name="find" value="{$find|escape}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
   </form>
   </td>
</tr>
</table>
<form method="get" action="tiki-list_file_gallery.php">
	<input type="hidden" name="galleryId" value="{$galleryId|escape}" />
    <input type="hidden" name="find" value="{$find|escape}" />
    <input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
<table class="normal">
{if $tiki_p_admin_file_galleries eq 'y'}
<tr>
	<td class="heading" colspan="16">
	{tr}Actions{/tr}
	</td>
</tr>
<tr>	
	<td class="even" colspan="16">
	
	<input type="image" name="movesel" src="img/icons/topic_move.gif" alt='{tr}move{/tr}' title='{tr}move selected files{/tr}' />
	<input type="image" name="delsel" src="img/icons/topic_delete.gif" alt='{tr}delete{/tr}' title='{tr}delete selected files{/tr}' />
	
	</td>
</tr>
{if $smarty.request.movesel_x} 
<tr>
	<td class="even" colspan="18">
	{tr}Move to{/tr}:
	<select name="moveto">
		{section name=ix loop=$all_galleries}
			{if $all_galleries[ix].galleryId ne $galleryId}
				<option value="{$all_galleries[ix].galleryId|escape}">{$all_galleries[ix].name}</option>
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
<td  class="heading">&nbsp;</td>
{/if}
{if $gal_info.show_id eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'fileId_desc'}fileId_asc{else}fileId_desc{/if}">{tr}ID{/tr}</a></td>
{/if}
{if $gal_info.show_icon eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'filetype_desc'}filetype_asc{else}filetype_desc{/if}">{tr}Type{/tr}</a></td>
{/if}
{if $gal_info.show_name eq 'a' || $gal_info.show_name eq 'n'}
<td class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">{tr}Name{/tr}</a></td>
{/if}
{if $gal_info.show_name eq 'a' || $gal_info.show_name eq 'f'}
<td class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'filename_desc'}filename_asc{else}filename_desc{/if}">{tr}Filename{/tr}</a></td>
{/if}
{if $gal_info.show_size eq 'y'}
	<td  style="text-align:right;" class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'filesize_desc'}filesize_asc{else}filesize_desc{/if}">{tr}Filesize{/tr}</a></td>
{/if}
{if $gal_info.show_description eq 'y'}
	<td  class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'description_desc'}description_asc{else}description_desc{/if}">{tr}Description{/tr}</a></td>
{/if}
{if $gal_info.show_created eq 'y'}
	<td  class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'created_desc'}created_asc{else}created_desc{/if}">{tr}Created{/tr}</a></td>
	<td  class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'user_desc'}user_asc{else}user_desc{/if}">{tr}Creator{/tr}</a></td>
{/if}
{if $gal_info.show_dl eq 'y'}
	<td style="text-align:right;"  class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'downloads_desc'}downloads_asc{else}downloads_desc{/if}">{tr}Dls{/tr}</a></td>
{/if}
{if $gal_info.show_lockedby eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'lockedby_desc'}lockedby_asc{else}lockedby_desc{/if}">{tr}Locked by{/tr}</a></td>
{/if}
<td  class="heading">{tr}Actions{/tr}</td>
</tr>




{cycle values="odd,even" print=false}
{section name=changes loop=$images}
<tr>

{if $tiki_p_admin_file_galleries eq 'y'}
<td  style="text-align:center;" class="{cycle advance=false}">
	<input type="checkbox" name="file[]" value="{$images[changes].fileId|escape}"  {if $smarty.request.file and in_array($images[changes].fileId,$smarty.request.file)}checked="checked"{/if} />
</td>
{/if}

{if $gal_info.show_id eq 'y'}
	<td class="{cycle advance=false}">{$images[changes].fileId}</td>
{/if}

{if $gal_info.show_icon eq 'y'}
	<td style="text-align:center;" class="{cycle advance=false}">
		{$images[changes].filename|iconify}
	</td>
{/if}
	

{if $gal_info.show_name eq 'a' || $gal_info.show_name eq 'n'}
	<td class="{cycle advance=false}">
		{if $tiki_p_download_files eq 'y'}
			{if $gal_info.type eq "podcast" or $gal_info.type eq "vidcast"}
				<a class="fgalname" href="{$download_path}{$images[changes].path}">
			{else}
				<a class="fgalname" href="tiki-download_file.php?fileId={$images[changes].fileId}">
			{/if}
		{/if}
		{$images[changes].name|escape}
		{if $tiki_p_download_files eq 'y'}</a>{/if}
	</td>
{/if}
{if $gal_info.show_name eq 'a' || $gal_info.show_name eq 'f'}
	<td class="{cycle advance=false}">
		{if $tiki_p_download_files eq 'y'}
			{if $gal_info.type eq "podcast" or $gal_info.type eq "vidcast"}
				<a class="fgalname" href="{$download_path}{$images[changes].path}">
			{else}
				<a class="fgalname" href="tiki-download_file.php?fileId={$images[changes].fileId}">
			{/if}
		{/if}
		{$images[changes].filename|escape}
		{if $tiki_p_download_files eq 'y'}</a>{/if}
	</td>
{/if}

{if $gal_info.show_size eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}">{$images[changes].filesize|kbsize}</td>
{/if}

{if $gal_info.show_description eq 'y'}
	<td class="{cycle advance=false}">{$images[changes].description|truncate:$gal_info.max_desc:"..."|escape}</td>
{/if}
	
{if $gal_info.show_created eq 'y'}
	<td class="{cycle advance=false}">{$images[changes].created|tiki_short_date}</td>
	<td class="{cycle advance=false}">{$images[changes].user|escape}</td>
{/if}

{if $gal_info.show_dl eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}">{$images[changes].downloads}</td>
{/if}

{if $gal_info.show_lockedby eq 'y'}
	<td class="{cycle advance=false}">{$images[changes].lockedby|escape}</td>
{/if}

<td class="{cycle}">
	{if $tiki_p_download_files eq 'y'}
		{if $gal_info.type eq "podcast" or $gal_info.type eq "vidcast"}
			<a class="fgalname" href="{$download_path}{$images[changes].path}" title="{tr}Download{/tr}">
		{else}
			<a class="fgalname" href="tiki-download_file.php?fileId={$images[changes].fileId}" title="{tr}Download{/tr}">
		{/if}
		<img src="pics/icons/disk.png" border="0" width="16" height="16" alt="{tr}Download{/tr}" /></a> 
		{* can locked if the gall can be locked or I am the locker or the file is not locked - this only for regular file *}
		{if $gal_info.lockable == 'y'
			and ($images[changes].lockedby eq '' or $images[changes].lockedby eq $user)
			and $gal_info.type ne "podcast" and $gal_info.type ne "vidcast"}
			<a class="fgalname" href="tiki-download_file.php?fileId={$images[changes].fileId}&amp;user={$user|escape}" title="{tr}Download and lock{/tr}">
			<img src="pics/icons/disk_lock.png" border="0" width="16" height="16" alt="{tr}Download and lock{/tr}" /></a> 
		{/if}	
	{/if}
	{* can edit if I am admin or the owner of the file or the locker of the file or if I have the perm to edit file on this gall *}
	{if $tiki_p_admin_file_galleries eq 'y'
		or ($images[changes].lockedby and $images[changes].lockedby eq $user)
		or (!$images[changes].lockedby and (($user and $user eq $images[changes].user) or $tiki_p_edit_file_gallery eq 'y')) }
		<a class="link" href="tiki-upload_file.php?galleryId={$galleryId}&amp;fileId={$images[changes].fileId}"><img src='pics/icons/page_edit.png' border='0' alt='{tr}edit{/tr}' title='{tr}edit{/tr}' /></a>
		<a class="link" href="tiki-list_file_gallery.php?galleryId={$galleryId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$images[changes].fileId}"><img src='pics/icons/cross.png' border='0' alt='{tr}delete{/tr}' title='{tr}delete{/tr}' /></a>
	{/if}
</td>
</tr>
{sectionelse}
<tr><td colspan="16">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
</table>
</form>

<br />
  <div class="mini">
      {if $prev_offset >= 0}
        [<a class="fgalprevnext" href="tiki-list_file_gallery.php?find={$find}&amp;galleryId={$galleryId}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}prev{/tr}</a>]&nbsp;
      {/if}
      {tr}Page{/tr}: {$actual_page}/{$cant_pages}
      {if $next_offset >= 0}
      &nbsp;[<a class="fgalprevnext" href="tiki-list_file_gallery.php?find={$find}&amp;galleryId={$galleryId}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}next{/tr}</a>]
      {/if}
      {if $direct_pagination eq 'y'}
<br />
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="tiki-list_file_gallery.php?find={$find}&amp;galleryId={$galleryId}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
{$smarty.section.foo.index_next}</a>&nbsp;
{/section}
{/if}

  </div>
</div>
{if $feature_file_galleries_comments == 'y'
  && (($tiki_p_read_comments  == 'y'
  && $comments_cant != 0)
  ||  $tiki_p_post_comments  == 'y'
  ||  $tiki_p_edit_comments  == 'y')}
<div id="page-bar">
<table>
<tr><td>
<div class="button2">
<a href="#" onclick="javascript:flip('comzone');flip('comzone_close','inline');return false;" class="linkbut">
{if $comments_cant == 0 or ($tiki_p_read_comments  == 'n' and $tiki_p_post_comments  == 'y')}
{tr}add comment{/tr}
{elseif $comments_cant == 1}
<span class="highlight">{tr}1 comment{/tr}</span>
{else}
<span class="highlight">{$comments_cant} {tr}comments{/tr}</span>
{/if}
<span id="comzone_close" style="display:{if isset($smarty.session.tiki_cookie_jar.show_comzone) and $smarty.session.tiki_cookie_jar.show_comzone eq 'y'}inline{else}non
e{/if};">({tr}close{/tr})</span>
</a>
</div>
</td></tr></table>
</div>
{include file=comments.tpl}
{/if}
