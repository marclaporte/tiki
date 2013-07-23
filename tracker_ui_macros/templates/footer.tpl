{* $Id$ *}
{* ==> put in this file what is not displayed in the layout (javascript, debug..)*}
{if (! isset($display) or $display eq '')}
	{if count($phpErrors)}
		{button href="#" _id="show-errors-button" _onclick="flip('errors');return false;" _text="{tr}Show php error messages{/tr}"}
		<br />
		<div id="errors" style="display:{if (isset($smarty.session.tiki_cookie_jar.show_errors) and $smarty.session.tiki_cookie_jar.show_errors eq 'y') or $prefs.javascript_enabled ne 'y'}block{else}none{/if};">
			{foreach item=err from=$phpErrors}
				{$err}
			{/foreach}
		</div>
	{/if}

	{if $tiki_p_admin eq 'y' and $prefs.feature_debug_console eq 'y'}
		{* Include debugging console. Note it shoudl be processed as near as possible to the end of file *}

		{php} include_once("tiki-debug_console.php"); {/php}
		{include file="tiki-debug_console.tpl"}
	{/if}
	
	{if $prefs.feature_phplayers eq 'y' and isset($phplayers_LayersMenu)}
		{$phplayers_LayersMenu->printHeader()}
		{$phplayers_LayersMenu->printFooter()}
	{/if}
{/if}

{if $prefs.feature_endbody_code}{*this code must be added just before </body>: needed by google analytics *}
	{eval var=$prefs.feature_endbody_code}
{/if}
</body>
</html>