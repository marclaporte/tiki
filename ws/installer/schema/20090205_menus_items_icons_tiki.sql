ALTER TABLE `tiki_menus` ADD COLUMN `use_items_icons` char(1) NOT NULL DEFAULT 'n';
ALTER TABLE `tiki_menu_options` ADD COLUMN `icon` varchar(200);
UPDATE tiki_menu_options SET icon = 'icon-configuration48x48' WHERE name = 'Admin';
UPDATE tiki_menu_options SET icon = 'xfce4-appfinder48x48' WHERE name = 'Search';
UPDATE tiki_menu_options SET icon = 'wikipages48x48' WHERE name = 'Wiki';
UPDATE tiki_menu_options SET icon = 'blogs48x48' WHERE name = 'Blogs';
UPDATE tiki_menu_options SET icon = 'stock_select-color48x48' WHERE name = 'Image Galleries';
UPDATE tiki_menu_options SET icon = 'file-manager48x48' WHERE name = 'File Galleries';
UPDATE tiki_menu_options SET icon = 'stock_bold48x48' WHERE name = 'Articles';
UPDATE tiki_menu_options SET icon = 'stock_index48x48' WHERE name = 'Forums';
UPDATE tiki_menu_options SET icon = 'gnome-settings-font48x48' WHERE name = 'Trackers';
UPDATE tiki_menu_options SET icon = 'users48x48' WHERE name = 'Community';
UPDATE tiki_menu_options SET icon = 'stock_dialog_question48x48' WHERE name = 'FAQs';
UPDATE tiki_menu_options SET icon = 'maps48x48' WHERE name = 'Maps';
UPDATE tiki_menu_options SET icon = 'messages48x48' WHERE name = 'Newsletters';
UPDATE tiki_menu_options SET icon = 'vcard48x48' WHERE name = 'Freetags';
UPDATE tiki_menu_options SET icon = 'date48x48' WHERE name = 'Calendar' AND url = 'tiki-calendar.php';
UPDATE tiki_menu_options SET icon = 'userfiles48x48' WHERE name = 'MyTiki';
UPDATE tiki_menu_options SET icon = '' WHERE name = 'Quizzes';
UPDATE tiki_menu_options SET icon = '' WHERE name = 'Surveys';
UPDATE tiki_menu_options SET icon = '' WHERE name = 'TikiSheet';
UPDATE tiki_menu_options SET icon = '' WHERE name = 'Workflow';
UPDATE tiki_menu_options SET icon = '' WHERE name = 'Charts';
UPDATE tiki_menus SET use_items_icons='y' WHERE menuId=42;