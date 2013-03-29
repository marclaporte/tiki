{* $Id$ *}

{if !isset($tpl_module_title)}{eval assign=tpl_module_title var="{tr}Admin Menu{/tr}"}{/if}
{tikimodule error=$module_params.error title="{tr}$tpl_module_title{/tr}" name="admin_menu" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}

{if $tiki_p_admin eq 'y' or
 $tiki_p_admin_chat eq 'y' or
 $tiki_p_admin_categories eq 'y' or
 $tiki_p_admin_banners eq 'y' or
 $tiki_p_edit_templates eq 'y' or
 $tiki_p_admin_mailin eq 'y' or
 $tiki_p_admin_dynamic eq 'y' or
 $tiki_p_admin_dynamic eq 'y' or
 $tiki_p_edit_content_templates eq 'y' or
 $tiki_p_edit_html_pages eq 'y' or
 $tiki_p_view_referer_stats eq 'y' or
 $tiki_p_admin_shoutbox eq 'y'
 }
		{if $prefs.feature_live_support eq 'y' and ($tiki_p_live_support_admin eq 'y' or $user_is_operator eq 'y')}
			<a href="tiki-live_support_admin.php" class="linkmenu">{tr}Live Support{/tr}</a>
		{/if}

		{if $prefs.feature_banning eq 'y' and ($tiki_p_admin_banning eq 'y')}
			<a href="tiki-admin_banning.php" class="linkmenu">{tr}Banning{/tr}</a>
		{/if}

		{if $tiki_p_admin eq 'y'}
			<a href="tiki-adminusers.php" class="linkmenu">{tr}Users{/tr}</a>
			<a href="tiki-admingroups.php" class="linkmenu">{tr}Groups{/tr}</a>
			<a href="tiki-list_cache.php" class="linkmenu">{tr}Cache{/tr}</a>
			<a href="tiki-admin_modules.php" class="linkmenu">{tr}Modules{/tr}</a>
			<a href="tiki-admin_links.php" class="linkmenu">{tr}Links{/tr}</a>
			<a href="tiki-admin_hotwords.php" class="linkmenu">{tr}Hotwords{/tr}</a>
			<a href="tiki-admin_rssmodules.php" class="linkmenu">{tr}RSS Modules{/tr}</a>
			<a href="tiki-admin_menus.php" class="linkmenu">{tr}Menus{/tr}</a>
			<a href="tiki-admin_polls.php" class="linkmenu">{tr}Polls{/tr}</a>
			<a href="tiki-admin_notifications.php" class="linkmenu">{tr}Mail Notifications{/tr}</a>
			<a href="tiki-search_stats.php" class="linkmenu">{tr}Search Stats{/tr}</a>
			<a href="tiki-admin_toolbars.php" class="linkmenu">{tr}Toolbars{/tr}</a>
		{/if}
		{if $tiki_p_admin_chat eq 'y'}
			<a href="tiki-admin_chat.php" class="linkmenu">{tr}Chat{/tr}</a>
		{/if}
		{if $tiki_p_admin_categories eq 'y'}
			<a href="tiki-admin_categories.php" class="linkmenu">{tr}Categories{/tr}</a>
		{/if}
		{if $tiki_p_admin_banners eq 'y'}
			<a href="tiki-list_banners.php" class="linkmenu">{tr}Banners{/tr}</a>
		{/if}
		{if $tiki_p_edit_templates eq 'y'}
			<a href="tiki-edit_templates.php" class="linkmenu">{tr}Edit Templates{/tr}</a>
		{/if}
		{if $tiki_p_admin_dynamic eq 'y'}
			<a href="tiki-list_contents.php" class="linkmenu">{tr}Dynamic Content{/tr}</a>
		{/if}
		{if $tiki_p_edit_cookies eq 'y'}
			<a href="tiki-admin_cookies.php" class="linkmenu">{tr}Cookies{/tr}</a>
		{/if}
		{if $tiki_p_admin_mailin eq 'y'}
			<a href="tiki-admin_mailin.php" class="linkmenu">{tr}Mail-in{/tr}</a>
		{/if}
		{if $tiki_p_edit_content_templates eq 'y'}
			<a href="tiki-admin_content_templates.php" class="linkmenu">{tr}Content Templates{/tr}</a>
		{/if}
		{if $tiki_p_edit_html_pages eq 'y'}
			<a href="tiki-admin_html_pages.php" class="linkmenu">{tr}HTML Pages{/tr}</a>
		{/if}
		{if $tiki_p_admin_shoutbox eq 'y'}
			<a href="tiki-shoutbox.php" class="linkmenu">{tr}Shoutbox{/tr}</a>
			<a href="tiki-admin_shoutbox_words.php" class="linkmenu">{tr}Shoutbox Words{/tr}</a>
		{/if}
		{if $tiki_p_view_referer_stats eq 'y'}
		<a href="tiki-referer_stats.php" class="linkmenu">{tr}Referer Stats{/tr}</a>
		{/if}

		{if $tiki_p_admin eq 'y'}
			<a href="tiki-import_phpwiki.php" class="linkmenu">{tr}Import PHPWiki Dump{/tr}</a>
			<a href="tiki-phpinfo.php" class="linkmenu">{tr}phpinfo{/tr}</a>
			<a href="tiki-admin_dsn.php" class="linkmenu">{tr}Admin dsn{/tr}</a>
			<a href="tiki-admin_external_wikis.php" class="linkmenu">{tr}External Wikis{/tr}</a>
			<a href="tiki-admin_system.php" class="linkmenu">{tr}Tiki Cache/Sys Admin{/tr}</a>
			<a href="tiki-admin_security.php" class="linkmenu">{tr}Security Admin{/tr}</a>
		{/if}
		{if $tiki_p_admin_code_hilight eq 'y'}
		<a href="tiki-admin_code_syntax.php" class="linkmenu">{tr}Syntax Highlighting{/tr}</a>
		{/if}
	{/if}
{/tikimodule}