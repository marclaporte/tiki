<div class="adminoptionbox preference clearfix {$p.tagstring|escape}{if isset($smarty.request.highlight) and $smarty.request.highlight eq $p.preference} highlight{/if}">
	<div class="checkbox adminoption">
		<label>
			<input id="{$p.id|escape}" type="checkbox" name="{$p.preference|escape}" {if $p.value eq 'y'}checked="checked" {/if} 
				{if ! $p.available}disabled="disabled"{/if} {$p.params}
				data-tiki-admin-child-block="#{$p.preference|escape}_childcontainer"
				data-tiki-admin-child-mode="{$mode|escape}"
			>

			{$p.name|escape}
		</label>
		{include file="prefs/shared-flags.tpl"}
		{if $p.hint}
			<div class="help-block">{$p.hint|simplewiki}</div>
		{/if}
	</div>
	{include file="prefs/shared-dependencies.tpl"}
</div>
