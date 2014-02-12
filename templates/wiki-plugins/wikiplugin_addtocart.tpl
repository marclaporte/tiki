{* $Id$ *}
<form method="post" action="{query _type=relative _keepall=y}" style="display: inline;" class="wp_addtocart_form"{$form_data}>
	<input type="hidden" name="code" value="{$params.code|escape}">
	{if $onbehalf == 'y'}
		{tr}Buy on behalf of:{/tr}
		<select name="buyonbehalf">
			<option value="">{tr}None{/tr}</option>
			{foreach key=id item=one from=$cartuserlist}
				<option value="{$one|escape}">{$one|escape}</option>
			{/foreach}
		</select>
		<br>
	{/if}
	
	<table>
		{if $params.giftcertificate == 'y'}
			<tr>
				<th style="text-align: right;">{tr}Gift Certificate:{/tr}</th>
				<td><input type="text" name="gift_certificate" size="2"></td>
			</tr>
		{/if}

		{if $hideamountfield eq 'y'}
		<input type="hidden" name="quantity" value="1">
		{else}			
		<tr>
			<th style="text-align: right;">{tr}Qty:{/tr}</th>
			<td><input type="text" name="quantity" value="1" size="2"></td>
		</tr>
		{/if}
	</table>
	<input type="submit" class="btn btn-default" value="{tr}{$params.label|escape}{/tr}">
	{if $params.exchangeorderitemid}
		<input type="hidden" value="{$params.exchangeorderitemid|escape}" name="exchangeorderitemid">
		<input type="hidden" value="{$params.exchangetoproductid|escape}" name="exchangetoproductid">
	{/if}
</form>

