{* $Id$ *}

{if !isset($tpl_module_title)}{assign var=tpl_module_title value="{tr}Site Language:{/tr}&nbsp;`$prefs.language`"}{/if}
{tikimodule error=$module_params.error title=$tpl_module_title name="switch_lang2" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
<table width="100%" border="0" cellpadding="0" cellspacing="0">
{section name=ix loop=$languages}
<tr>
  <td align="center">
    <a title="{$languages[ix].name|escape}" class="linkmodule" href="tiki-switch_lang.php?language={$languages[ix].value|escape}">
      {$languages[ix].display|escape}
    </a>
  </td>
</tr>
{/section}
</table>
{/tikimodule}