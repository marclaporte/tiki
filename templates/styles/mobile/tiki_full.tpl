{* $Id$ *}<!DOCTYPE html>
<html lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}">
	<head>
{include file='header.tpl'}
	</head>
	<body{html_body_attributes}>

{* Index we display a wiki page here *}
{if $prefs.feature_bidi eq 'y'}
<div dir="rtl">
{/if}
{if $prefs.feature_ajax eq 'y'}
{include file='tiki-ajax_header.tpl'}
{/if}
<div id="main" data-role="page">{* mobile *}
	<div id="tiki-center">
		<div id="role_main">
			{$mid_data}
		</div>
	</div>
</div>

{if $prefs.feature_bidi eq 'y'}
</div>
{/if}
{include file='footer.tpl'}
<!-- Put JS at the end -->
{if $headerlib}
	{$headerlib->output_js_files()}
	{$headerlib->output_js()}
{/if}
	</body>
</html>
