{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-top_articles.tpl,v 1.6 2003-10-20 01:13:16 zaufi Exp $ *}

{if $feature_articles eq 'y'}
<div class="box">
<div class="box-title">
{include file="modules/module-title.tpl" module_title="{tr}Top articles{/tr}" module_name="top_articles"}
</div>
<div class="box-data">
<table  border="0" cellpadding="0" cellspacing="0">
{section name=ix loop=$modTopArticles}
<tr>{if $nonums != 'y'}<td class="module" valign="top">{$smarty.section.ix.index_next})</td>{/if}
<td class="module"><a class="linkmodule" href="tiki-read_article.php?articleId={$modTopArticles[ix].articleId}">{$modTopArticles[ix].title}</a></td></tr>
{/section}
</table>
</div>
</div>
{/if}