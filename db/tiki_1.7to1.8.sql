# $Id: tiki_1.7to1.8.sql,v 1.30 2003-10-13 04:12:23 dheltzel Exp $

# The following script will update a tiki database from verion 1.7 to 1.8
# 
# To execute this file do the following:
#
# $ mysql -f dbname <tiki_1.7to1.8.sql
#
# where dbname is the name of your tiki database.
#
# For example, if your tiki database is named tiki (not a bad choice), type:
#
# $ mysql -f tiki <tiki_1.7to1.8.sql
# 
# You may execute this command as often as you like, 
# and may safely ignore any error messages that appear.

INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('allowRegister', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('anonCanEdit', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('article_comments_default_ordering', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('article_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_author', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_date', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_img', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_reads', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_size', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_title', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_list_topic', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_author', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_date', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_img', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_reads', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_size', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_title', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('art_view_topic', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_create_user_auth', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_create_user_tiki', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_adminpass', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_adminuser', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_basedn', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_groupattr', 'cn');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_groupdn', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_groupoc', 'groupOfUniqueNames');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_host', 'localhost');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_memberattr', 'uniqueMember');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_memberisdn', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_port', '389');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_scope', 'sub');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_userattr', 'uid');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_userdn', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_ldap_useroc', 'inetOrgPerson');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_method', 'tiki');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('auth_skip_admin', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_comments_default_ordering', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_activity', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_created', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_description', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_lastmodif', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_order', 'created_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_posts', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_title', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_user', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_list_visits', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('blog_spellcheck', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cacheimages', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cachepages', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('change_language', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('change_theme', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cms_bot_bar', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cms_left_column', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cms_right_column', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cms_spellcheck', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('cms_top_bar', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('contact_user', 'admin');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('count_admin_pvs', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('directory_columns', '3');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('directory_links_per_page', '20');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('directory_open_links', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('directory_validate_urls', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('direct_pagination', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('display_timezone', 'EST');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('faq_comments_default_ordering', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('faq_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_article_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_articles', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_babelfish', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_babelfish_logo', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_backlinks', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_banners', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_banning', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_blog_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_blogposts_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_blog_rankings', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_blogs', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_bot_bar', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_calendar', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_categories', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_categoryobjects', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_categorypath', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_challenge', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_charts', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_chat', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_clear_passwords', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_cms_rankings', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_cms_templates', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_comm', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_contact', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_custom_home', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_debug_console', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_debugger_console', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_directory', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_drawings', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_dump', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_dynamic_content', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_editcss', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_edit_templates', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_eph', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_faq_comments', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_faqs', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_featuredLinks', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_file_galleries_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_file_galleries', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_file_galleries_rankings', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_forum_parse', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_forum_quickjump', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_forum_rankings', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_forums', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_forum_topicd', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_galleries', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_gal_rankings', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_games', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_history', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_hotwords_nw', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_hotwords', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_html_pages', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_image_galleries_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_lastChanges', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_left_column', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_likePages', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_listPages', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_live_support', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_menusfolderstyle', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_messages', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_minical', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_modulecontrols', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_newsletters', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_newsreader', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_notepad', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_obzip', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_page_title', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_phpopentracker', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_poll_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_polls', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_quizzes', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_ranking', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_referer_stats', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_right_column', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_sandbox', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_search_fulltext', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_search_stats', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_search', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_shoutbox', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_smileys', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_stats', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_submissions', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_surveys', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_tasks', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_theme_control', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_top_bar', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_trackers', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_user_bookmarks', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_userfiles', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_usermenu', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_userPreferences', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_userVersions', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_user_watches', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_warn_on_edit', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_webmail', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_attachments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_comments', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_description', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_discuss', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_footnotes', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_monosp', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_multiprint', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_notepad', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_pdf', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_pictures', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_rankings', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_tables', 'old');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_templates', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_undo', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki_usrlock', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wikiwords', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_wiki', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_workflow', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('feature_xmlrpc', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_created', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_description', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_files', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_hits', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_lastmodif', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_name', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_list_user', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_match_regex', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_nmatch_regex', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_use_db', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('fgal_use_dir', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('file_galleries_comments_default_ordering', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('file_galleries_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forgotPass', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forum_list_desc', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forum_list_lastpost', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forum_list_posts', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forum_list_ppd', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forum_list_topics', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forum_list_visits', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('forums_ordering', 'created_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_created', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_description', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_imgs', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_lastmodif', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_name', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_user', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_list_visits', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_match_regex', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_nmatch_regex', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_use_db', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_use_dir', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('gal_use_lib', 'gd');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('home_file_gallery', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('http_domain', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('http_port', '80');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('http_prefix', '/');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('https_domain', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('https_login', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('https_login_required', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('https_port', '443');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('https_prefix', '/');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('image_galleries_comments_default_orderin', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('image_galleries_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('keep_versions', '1');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('language', 'en');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('lang_use_db', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('layout_section', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('long_date_format', '%A %d of %B,  %Y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('long_time_format', '%H:%M:%S %Z');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('maxArticles', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('maxRecords', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_articles', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_blog', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_blogs', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_file_galleries', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_file_gallery', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_forum', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_forums', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_image_galleries', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_image_gallery', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('max_rss_wiki', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('maxVersions', '0');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('min_pass_length', '1');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('modallgroups', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('pass_chr_num', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('pass_due', '999');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('poll_comments_default_ordering', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('poll_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('popupLinks', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('proxy_host', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('proxy_port', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('record_untranslated', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('registerPasscode', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rememberme', 'disabled');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('remembertime', '7200');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rnd_num_reg', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_articles', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_blog', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_blogs', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_file_galleries', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_file_gallery', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_forums', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_forum', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_image_galleries', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_image_gallery', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('rss_wiki', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('sender_email', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('session_db', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('session_lifetime', '0');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('short_date_format', '%a %d of %b,  %Y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('short_time_format', '%H:%M %Z');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('siteTitle', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('slide_style', 'slidestyle.css');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('style', 'moreneat.css');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('system_os', 'unix');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('tikiIndex', 'tiki-index.php');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('tmpDir', '/tmp');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('t_use_db', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('t_use_dir', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('uf_use_db', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('uf_use_dir', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('urlIndex', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('use_proxy', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('user_assigned_modules', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('useRegisterPasscode', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('userfiles_quota', '30');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('useUrlIndex', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('validateUsers', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('eponymousGroups', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('warn_on_edit_time', '2');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('webmail_max_attachment', '1500000');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('webmail_view_html', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('webserverauth', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_bot_bar', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_cache', '0');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_comments_default_ordering', 'points_desc');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_comments_per_page', '10');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_creator_admin', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_feature_copyrights', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_forum', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_forum_id', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wikiHomePage', 'HomePage');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_left_column', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wikiLicensePage', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_backlinks', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_comment', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_creator', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_hits', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_lastmodif', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_lastver', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_links', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_name', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_size', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_status', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_user', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_list_versions', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_page_regex', 'strict');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_right_column', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_spellcheck', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wikiSubmitNotice', '');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('wiki_top_bar', 'n');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('w_use_db', 'y');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('w_use_dir', '');

INSERT /* IGNORE */ INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_map_edit', 'Can edit mapfiles', 'editor', 'maps');
INSERT /* IGNORE */ INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_map_create', 'Can create new mapfile', 'admin', 'maps');
INSERT /* IGNORE */ INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_map_delete', 'Can delete mapfiles', 'admin', 'maps');
INSERT /* IGNORE */ INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_map_view', 'Can view mapfiles', 'basic', 'maps');
INSERT /* IGNORE */ INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_access_closed_site', 'Can access site when closed', 'admin', 'tiki');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('map_path', '/var/www/html/map/');
INSERT /* IGNORE */ INTO tiki_preferences (name, value) VALUES ('default_map', 'pacific.map');

# adding field for group HomePage feature

# \todo lower case this field name: change to group_home
ALTER TABLE `users_groups` ADD `groupHome` VARCHAR( 255 ) AFTER `groupDesc` ;

ALTER TABLE `users_users` ADD `default_group` VARCHAR( 255 ) AFTER `realname` ;

# Per-forum from address.  -rlpowell
ALTER TABLE `tiki_forums` ADD `outbound_from` VARCHAR( 250 ) AFTER `outbound_address` ;

# Message Ids and In-Reply-To, for strict threading that extends to
# e-mail. -rlpowell
ALTER TABLE `tiki_comments` ADD `message_id` VARCHAR( 250 ) AFTER `smiley` ;
ALTER TABLE `tiki_comments` ADD `in_reply_to` VARCHAR( 250 ) AFTER `message_id` ;

#ALTER TABLE `tiki_comments` MODIFY `message_id` VARCHAR( 250 ) AFTER `smiley` ;
#ALTER TABLE `tiki_comments` MODIFY `in_reply_to` VARCHAR( 250 ) AFTER `message_id` ;

# Some more indexes for performance 
CREATE INDEX `hash` on `tiki_comments`(`hash`);
CREATE INDEX `in_reply_to` on `tiki_comments`(`in_reply_to`);

# \todo rename to tiki_sessions
# \todo lower case these field names, postgres dislikes non-lowercase fields
# \todo remove UNSIGNED attribute, it is a mysql specific construct

CREATE TABLE /* IF NOT EXISTS */ sessions (
       SESSKEY CHAR(32) NOT NULL, 
       EXPIRY INT(11) UNSIGNED NOT NULL, 
       DATA TEXT NOT NULL, 
       PRIMARY KEY (SESSKEY),  
       KEY (EXPIRY) 
);

CREATE TABLE /* IF NOT EXISTS */ tiki_download (
  id int(11) NOT NULL auto_increment,
  object varchar(255) NOT NULL default '',
  userId int(8) NOT NULL default '0',
  type varchar(20) NOT NULL default '',
  date int(14) NOT NULL default '0',
  IP varchar(50) NOT NULL default '',
  PRIMARY KEY  (id),
  KEY object (object,userId,type),
  KEY userId (userId),
  KEY type (type),
  KEY date (date)
);  

ALTER TABLE `tiki_pages` ADD `wiki_cache` int(10) default 0 AFTER `cache` ;

ALTER TABLE tiki_forums ADD forum_last_n int(2);
UPDATE tiki_forums SET forum_last_n = 0;

CREATE  TABLE tiki_dynamic_variables( name varchar( 40  ) not null,  DATA text,  PRIMARY  KEY ( name )  );
INSERT INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_edit_dynvar', 'Can edit dynamic variables', 'editors', 'wiki');

ALTER TABLE tiki_newsletters ADD allowUserSub char(1) DEFAULT 'y' AFTER `users`;
ALTER TABLE tiki_newsletters ADD unsubMsg char(1) DEFAULT 'y' AFTER `allowAnySub`;
ALTER TABLE tiki_newsletters ADD validateAddr char(1) DEFAULT 'y' AFTER `unsubMsg`;
UPDATE tiki_newsletters SET allowUserSub = 'y', unsubMsg = 'y', validateAddr = 'y';
