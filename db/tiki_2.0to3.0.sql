# $Id: tiki_2.0to3.0.sql 13749 2008-07-19 23:57:28Z m_stef $

# The following script will update a tiki database from version 2.0 to 3.0
# 
# To execute this file do the following:
#
# $ mysql -f dbname < tiki_2.0to3.0.sql
#
# where dbname is the name of your tiki database.
#
# For example, if your tiki database is named tiki (not a bad choice), type:
#
# $ mysql -f tiki < tiki_2.0to3.0.sql
# 
# You may execute this command as often as you like, 
# and may safely ignore any error messages that appear.

#2008-07-24 sylvieg
SET @fgcant=0;
SELECT (@fgcant:=count(*)) FROM users_permissions WHERE permName = 'tiki_p_search_categorized';
INSERT INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_search_categorized', 'Can search on objects of this category', 'basic', 'category');
INSERT INTO `users_objectpermissions` (groupName, permName, objectType, objectId) SELECT  groupName, 'tiki_p_search_categorized', objectType , objectId FROM `users_objectpermissions` WHERE permName = 'tiki_p_view_categorized' AND @fgcant = 0;

#2008-08-05 sylvieg
DELETE FROM tiki_quicktags WHERE taglabel='Deleted' AND taginsert='--text--' AND tagicon='pics/icons/text_strikethrough.png';
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','wiki');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','newsletters');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','trackers');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','blogs');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','calendar');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','articles');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','faqs');
INSERT INTO tiki_quicktags (taglabel, taginsert, tagicon, tagcategory) VALUES ('Deleted','--text--','pics/icons/text_strikethrough.png','forums');

#2008-08-14 sept
UPDATE `tiki_menu_options` set `url`='tiki-list_file_gallery.php' where `url`='tiki-file_galleres.php';

#2008-08-14 pkdille
UPDATE `tiki_menu_options` SET `url` = 'tiki-admin_include_score.php' where `url` = 'tiki-admin_score.php'
