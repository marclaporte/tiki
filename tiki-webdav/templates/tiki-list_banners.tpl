{* $Id$ *}

{title help="Banners" admpage=ads}{tr}Banners{/tr}{/title}

{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}To use a banner in a <a class="rbox-link" href="tiki-admin_modules.php">module</a> or a template, use {literal}{banner zone=ABC}{/literal}, where ABC is the name of the zone.{/tr}{/remarksbox}

{if $tiki_p_admin_banners eq 'y'}
	<div class="navbar">
		 {button href="tiki-edit_banner.php" _text="{tr}Create banner{/tr}"}
	</div>
{/if}

{if $listpages or ($find ne '')}
  {include file='find.tpl'}
{/if}
<table class="normal">
<tr>
<th>{self_link _sort_arg='sort_mode' _sort_field='bannerId'}{tr}Id{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='client'}{tr}Client{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='url'}{tr}URL{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='zone'}{tr}Zone{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='created'}{tr}Created{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='which'}{tr}Method{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='useDate'}{tr}Use Dates?{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='maxImpressions'}{tr}Max Impressions{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='impressions'}{tr}Impressions{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='maxClicks'}{tr}Max Clicks{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='clicks'}{tr}Clicks{/tr}{/self_link}</th>
<th>{tr}Action{/tr}</th>
</tr>
{cycle values="odd,even" print=false}
{section name=changes loop=$listpages}
<tr>
<td class="{cycle advance=false}">{if $tiki_p_admin_banners eq 'y'}<a class="link" href="tiki-edit_banner.php?bannerId={$listpages[changes].bannerId}">{/if}{$listpages[changes].bannerId}{if $tiki_p_admin_banners eq 'y'}</a>{/if}</td>
<td class="{cycle advance=false}">{$listpages[changes].client}</td>
<td class="{cycle advance=false}">{$listpages[changes].url}</td>
<td class="{cycle advance=false}">{$listpages[changes].zone}</td>
<td class="{cycle advance=false}">{$listpages[changes].created|tiki_short_date}</td>
<td class="{cycle advance=false}">{$listpages[changes].which}</td>
<td class="{cycle advance=false}">{$listpages[changes].useDates}</td>
<td class="{cycle advance=false}">{$listpages[changes].maxImpressions}</td>
<td class="{cycle advance=false}">{$listpages[changes].impressions}</td>
<td class="{cycle advance=false}">{$listpages[changes].maxClicks}</td>
<td class="{cycle advance=false}">{$listpages[changes].clicks}</td>
<td class="{cycle}">
{if $tiki_p_admin_banners eq 'y'}
<a class="link" href="tiki-edit_banner.php?bannerId={$listpages[changes].bannerId}">{icon _id='page_edit'}</a>
<a class="link" href="tiki-list_banners.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$listpages[changes].bannerId}">{icon _id='cross' alt='{tr}Remove{/tr}'}</a>
{/if}
<a class="link" href="tiki-view_banner.php?bannerId={$listpages[changes].bannerId}">{icon _id='chart_curve' alt='{tr}Stats{/tr}'}</a>
</td>
</tr>
{sectionelse}
<tr><td class="odd" colspan="11">
{tr}No records found{/tr}
</td></tr>
{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}
