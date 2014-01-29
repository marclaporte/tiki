<input class="system" type="hidden" name="lm_preference[]" value="{$p.preference|escape}">
{if $p.dependencies}
	{foreach from=$p.dependencies item=dep}
		{if $dep.met}
			{icon _id="accept" class="pref_dependency tips" title="{tr}Requires:{/tr} "|cat:$dep.label|escape|cat:" (OK)"}
		{elseif $dep.type eq 'profile'}
			<div class="pref_dependency highlight">{tr}You need apply profile{/tr} <a href="{$dep.link|escape}">{$dep.label|escape}</a></div>
		{else}
			<div class="pref_dependency highlight">{tr}You need to set{/tr} <a href="{$dep.link|escape}">{$dep.label|escape}</a></div>
		{/if}
	{/foreach}
{/if}
{foreach from=$p.notes item=note}
	<div class="help-block pref_note">{$note|escape}</div>
{/foreach}
