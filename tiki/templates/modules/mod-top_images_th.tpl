{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-top_images_th.tpl,v 1.5 2003-08-07 20:56:53 zaufi Exp $ *}

leries eq 'y'}
<div class="box">
<div class="box-title">
{include file="modules/module-title.tpl" module_title="{tr}Top Images{/tr}" module_name="top_images_th"}
</div>
<div class="box-data">
{section name=ix loop=$modTopImages}
{if $smarty.section.ix.index < 5}
<div align="center" class="imagerank">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<!--<td  class="module" width="5%" valign="middle"><span class="user-box-text">{$smarty.section.ix.index_next})</span></td>-->
<td align="center">
<a class="linkmodule" href="tiki-browse_image.php?imageId={$modTopImages[ix].imageId}">
<img alt="image" src="show_image.php?id={$modTopImages[ix].imageId}" height="50" width="90" />
</a>
</td></tr>
</table>
</div>
{/if}
{/section}
</div>
</div>
{/if}
