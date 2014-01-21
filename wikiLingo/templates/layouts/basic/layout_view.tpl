{* $Id: layout_view.tpl 48366 2013-11-08 16:12:24Z lphuberdeau $ *}<!DOCTYPE html>
<html lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}"{if !empty($page_id)} id="page_{$page_id}"{/if}>
	<head>
		{include file='header.tpl'}
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body{html_body_attributes}>
		{$cookie_consent_html}

		{if $prefs.feature_ajax eq 'y'}
			{include file='tiki-ajax_header.tpl'}
		{/if}
		
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					{modulelist zone=top}
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					{modulelist zone=topbar}
				</div>
			</div>

			<div class="row">
				{if zone_is_empty('left') and zone_is_empty('right')}
					<div class="col-md-12" id="col1">
						{block name=title}{/block}
						{error_report}
						{block name=content}{/block}
					</div>
				{elseif zone_is_empty('left')}
					<div class="col-md-10" id="col1">
						{block name=title}{/block}
						{error_report}
						{block name=content}{/block}
					</div>
					<div class="col-md-2">
						{modulelist zone=right}
					</div>
				{elseif zone_is_empty('right')}
					<div class="col-md-10 col-md-push-2" id="col1">
						{block name=title}{/block}
						{error_report}
						{block name=content}{/block}
					</div>
					<div class="col-md-2 col-md-pull-10">
						{modulelist zone=left}
					</div>
				{else}
					<div class="col-md-8 col-md-push-2" id="col1">
						{block name=title}{/block}
						{error_report}
						{block name=content}{/block}
					</div>
					<div class="col-md-2 col-md-pull-8">
						{modulelist zone=left}
					</div>
					<div class="col-md-2">
						{modulelist zone=right}
					</div>
				{/if}
			</div>

			<div class="row">
				<div class="col-md-12 well">
					{modulelist zone=bottom}
				</div>
			</div>
		</div>

		{include file='footer.tpl'}
		{if isset($prefs.socialnetworks_user_firstlogin) && $prefs.socialnetworks_user_firstlogin == 'y'}
			{include file='tiki-socialnetworks_firstlogin_launcher.tpl'}
		{/if}

		{if $prefs.site_google_analytics_account}
			{wikiplugin _name=googleanalytics account=$prefs.site_google_analytics_account}{/wikiplugin}
		{/if}
		{if $prefs.feature_endbody_code}
			{eval var=$prefs.feature_endbody_code}
		{/if}
		{interactivetranslation}
		<!-- Put JS at the end -->
		{if $headerlib}
			{$headerlib->output_js_config()}
			{$headerlib->output_js_files()}
			{$headerlib->output_js()}
		{/if}
	</body>
</html>
{if !empty($smarty.request.show_smarty_debug)}
	{debug}
{/if}
