{*Smarty template*}
<h1><a class="pagetitle" href="tiki-user_contacts_prefs.php">{tr}User Contacts Preferences{/tr}</a>

{if $feature_help eq 'y'}
<a href="{$helpurl}User+Contacts+Prefs" target="tikihelp" class="tikihelp" title="{tr}Tikiwiki.org help{/tr}: {tr}edit user contacts preferences{/tr}">
<img border='0' width='16' height='16' src='pics/icons/help.png' alt="{tr}help{/tr}" /></a>{/if}

{if $feature_view_tpl eq 'y'}
<a href="tiki-edit_templates.php?template=tiki-user_contacts_prefs.tpl" target="tikihelp" class="tikihelp" title="{tr}View tpl{/tr}: {tr}edit quiz stats tpl{/tr}">
<img src="pics/icons/shape_square_edit.png" border="0" height="16" width="16" alt='{tr}Edit template{/tr}' />
</a>
{/if}</h1>

<!-- this bar is created by a ref to {include file=tiki-mytiki_bar.tpl} :) -->
{include file=tiki-mytiki_bar.tpl}
<h2>{tr}User Contacts Preferences{/tr}</h2>

<h3>Contacts Possible Fields:</h3>
<form method='POST' action='tiki-user_contacts_prefs.php'>
<table>
  {foreach from=$exts item=ext key=k}
  <tr><td><a href='?ext_remove={$k}'>remove</a></td><td>{$ext|escape}</td></tr>
  {/foreach}
</table>
add: <input type='text' name='ext_add' /> <input type='submit' value='Add' />
</form>
