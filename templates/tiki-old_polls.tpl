<a class="pagetitle" href="tiki-old_polls.php">{tr}Polls{/tr}</a><br/><br/>
<div align="center">
<table class="findtable">
<tr><td class="findtable">Find</td>
   <td class="findtable">
   <form method="get" action="tiki-old_polls.php">
     <input type="text" name="find" value="{$find}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode}" />
   </form>
   </td>
</tr>
</table>
<table class="normal">
<tr>
<td class="heading"><a class="tableheading" href="tiki-old_polls.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'title_desc'}title_asc{else}title_desc{/if}">{tr}Title{/tr}</a></td>
<td class="heading"><a class="tableheading" href="tiki-old_polls.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'publishDate_desc'}publishDate_asc{else}publishDate_desc{/if}">{tr}Published{/tr}</a></td>
<td class="heading"><a class="tableheading" href="tiki-old_polls.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'votes_desc'}votes_asc{else}votes_desc{/if}">{tr}Votes{/tr}</a></td>
<td class="heading">{tr}Action{/tr}</td>
</tr>
{section name=changes loop=$listpages}
<tr>
{if $smarty.section.changes.index % 2}
<td class="odd">&nbsp;{$listpages[changes].title}&nbsp;</td>
<td class="odd">&nbsp;{$listpages[changes].publishDate|date_format:"%a %d of %b, %Y [%H:%M:%S]"}&nbsp;</td>
<td class="odd">&nbsp;{$listpages[changes].votes}&nbsp;</td>
<td class="odd">
<a class="link" href="tiki-poll_results.php?pollId={$listpages[changes].pollId}">{tr}Results{/tr}</a>
<a class="link" href="tiki-poll_form.php?pollId={$listpages[changes].pollId}">{tr}Vote{/tr}</a>
</td>
{else}
<td class="even">&nbsp;{$listpages[changes].title}&nbsp;</td>
<td class="even">&nbsp;{$listpages[changes].publishDate|date_format:"%a %d of %b, %Y [%H:%M:%S]"}&nbsp;</td>
<td class="even">&nbsp;{$listpages[changes].votes}&nbsp;</td>
<td class="even">
<a class="link" href="tiki-poll_results.php?pollId={$listpages[changes].pollId}">{tr}Results{/tr}</a>
<a class="link" href="tiki-poll_form.php?pollId={$listpages[changes].pollId}">{tr}Vote{/tr}</a>
</td>
{/if}
</tr>
{sectionelse}
<tr><td colspan="6">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
</table>
<br/>
<div class="mini">
{if $prev_offset >= 0}
[<a class="prevnext" href="tiki-old_polls.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}prev{/tr}</a>]&nbsp;
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
&nbsp;[<a class="prevnext" href="tiki-old_polls.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}next{/tr}</a>]
{/if}
</div>
</div>
