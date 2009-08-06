-- --------------------------------------------------------
-- Database : tikiwiki
-- --------------------------------------------------------
DROP TABLE `galaxia_activities`;

CREATE TABLE `galaxia_activities` (
  `activityId` number(14) NOT NULL auto_increment,
  `name` varchar(80) default NULL,
  `normalized_name` varchar(80) default NULL,
  `pId` number(14) default '0' NOT NULL,
  `type` enum('start','end','split','switch','join','activity','standalone') default NULL,
  `isAutoRouted` char(1) default NULL,
  `flowNum` number(10) default NULL,
  `isInteractive` char(1) default NULL,
  `lastModif` number(14) default NULL,
  `description` clob,
  `expirationTime` number(6) default '0' NOT NULL,
  PRIMARY KEY (`activityId`)
) ENGINE=MyISAM  ;


DROP TABLE `galaxia_activity_roles`;

CREATE TABLE `galaxia_activity_roles` (
  `activityId` number(14) default '0' NOT NULL,
  `roleId` number(14) default '0' NOT NULL,
  PRIMARY KEY (`activityId`,`roleId`)
) ENGINE=MyISAM;


DROP TABLE `galaxia_instance_activities`;

CREATE TABLE `galaxia_instance_activities` (
  `instanceId` number(14) default '0' NOT NULL,
  `activityId` number(14) default '0' NOT NULL,
  `started` number(14) default '0' NOT NULL,
  `ended` number(14) default '0' NOT NULL,
  `user` varchar(200) default '',
  `status` enum('running','completed') default NULL,
  PRIMARY KEY (`instanceId`,`activityId`)
) ENGINE=MyISAM;


DROP TABLE `galaxia_instance_comments`;

CREATE TABLE `galaxia_instance_comments` (
  `cId` number(14) NOT NULL auto_increment,
  `instanceId` number(14) default '0' NOT NULL,
  `user` varchar(200) default '',
  `activityId` number(14) default NULL,
  `hash` varchar(34) default NULL,
  `title` varchar(250) default NULL,
  `comment` clob,
  `activity` varchar(80) default NULL,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`cId`)
) ENGINE=MyISAM  ;


DROP TABLE `galaxia_instances`;

CREATE TABLE `galaxia_instances` (
  `instanceId` number(14) NOT NULL auto_increment,
  `pId` number(14) default '0' NOT NULL,
  `started` number(14) default NULL,
  `name` varchar(200) default 'No Name' NOT NULL,
  `owner` varchar(200) default NULL,
  `nextActivity` number(14) default NULL,
  `nextUser` varchar(200) default NULL,
  `ended` number(14) default NULL,
  `status` enum('active','exception','aborted','completed') default NULL,
  `properties` blob,
  PRIMARY KEY (`instanceId`)
) ENGINE=MyISAM  ;


DROP TABLE `galaxia_processes`;

CREATE TABLE `galaxia_processes` (
  `pId` number(14) NOT NULL auto_increment,
  `name` varchar(80) default NULL,
  `isValid` char(1) default NULL,
  `isActive` char(1) default NULL,
  `version` varchar(12) default NULL,
  `description` clob,
  `lastModif` number(14) default NULL,
  `normalized_name` varchar(80) default NULL,
  PRIMARY KEY (`pId`)
) ENGINE=MyISAM  ;


DROP TABLE `galaxia_roles`;

CREATE TABLE `galaxia_roles` (
  `roleId` number(14) NOT NULL auto_increment,
  `pId` number(14) default '0' NOT NULL,
  `lastModif` number(14) default NULL,
  `name` varchar(80) default NULL,
  `description` clob,
  PRIMARY KEY (`roleId`)
) ENGINE=MyISAM  ;


DROP TABLE `galaxia_transitions`;

CREATE TABLE `galaxia_transitions` (
  `pId` number(14) default '0' NOT NULL,
  `actFromId` number(14) default '0' NOT NULL,
  `actToId` number(14) default '0' NOT NULL,
  PRIMARY KEY (`actFromId`,`actToId`)
) ENGINE=MyISAM;


DROP TABLE `galaxia_user_roles`;

CREATE TABLE `galaxia_user_roles` (
  `pId` number(14) default '0' NOT NULL,
  `roleId` number(14) NOT NULL auto_increment,
  `user` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`roleId`, `user`)
) ENGINE=MyISAM  ;


DROP TABLE `galaxia_workitems`;

CREATE TABLE `galaxia_workitems` (
  `itemId` number(14) NOT NULL auto_increment,
  `instanceId` number(14) default '0' NOT NULL,
  `orderId` number(14) default '0' NOT NULL,
  `activityId` number(14) default '0' NOT NULL,
  `properties` blob,
  `started` number(14) default NULL,
  `ended` number(14) default NULL,
  `user` varchar(200) default '',
  PRIMARY KEY (`itemId`)
) ENGINE=MyISAM  ;


DROP TABLE `messu_messages`;

CREATE TABLE `messu_messages` (
  `msgId` number(14) NOT NULL auto_increment,
  `user` varchar(200) default '' NOT NULL,
  `user_from` varchar(200) default '' NOT NULL,
  `user_to` clob,
  `user_cc` clob,
  `user_bcc` clob,
  `subject` varchar(255) default NULL,
  `body` clob,
  `hash` varchar(32) default NULL,
  `replyto_hash` varchar(32) default NULL,
  `date` number(14) default NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `priority` number(2) default NULL,
  PRIMARY KEY (`msgId`),
  KEY `userIsRead` (user, isRead)
) ENGINE=MyISAM  ;


DROP TABLE `messu_archive`;

CREATE TABLE `messu_archive` (
  `msgId` number(14) NOT NULL auto_increment,
  `user` varchar(40) default '' NOT NULL,
  `user_from` varchar(40) default '' NOT NULL,
  `user_to` clob,
  `user_cc` clob,
  `user_bcc` clob,
  `subject` varchar(255) default NULL,
  `body` clob,
  `hash` varchar(32) default NULL,
  `replyto_hash` varchar(32) default NULL,
  `date` number(14) default NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `priority` number(2) default NULL,
  PRIMARY KEY (`msgId`)
) ENGINE=MyISAM  ;


DROP TABLE `messu_sent`;

CREATE TABLE `messu_sent` (
  `msgId` number(14) NOT NULL auto_increment,
  `user` varchar(40) default '' NOT NULL,
  `user_from` varchar(40) default '' NOT NULL,
  `user_to` clob,
  `user_cc` clob,
  `user_bcc` clob,
  `subject` varchar(255) default NULL,
  `body` clob,
  `hash` varchar(32) default NULL,
  `replyto_hash` varchar(32) default NULL,
  `date` number(14) default NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `priority` number(2) default NULL,
  PRIMARY KEY (`msgId`)
) ENGINE=MyISAM  ;


DROP TABLE `sessions`;

CREATE TABLE "sessions"(
  `sesskey` char(32) NOT NULL,
  `expiry` number(11) NOT NULL,
  `expireref` varchar(64),
  `data` clob NOT NULL,
  PRIMARY KEY (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MyISAM;


DROP TABLE `tiki_actionlog`;

CREATE TABLE `tiki_actionlog` (
  `actionId` number(8) NOT NULL auto_increment,
  `action` varchar(255) default '' NOT NULL,
  `lastModif` number(14) default NULL,
  `object` varchar(255) default NULL,
  `objectType` varchar(32) default '' NOT NULL,
  `user` varchar(200) default '',
  `ip` varchar(15) default NULL,
  `comment` varchar(200) default NULL,
  `categId` number(12) default '0' NOT NULL,
  PRIMARY KEY (`actionId`),
  KEY `lastModif` (`lastModif`),
  KEY `object` (`object`(100), `objectType`, `action`(100))
) ENGINE=MyISAM;


DROP TABLE `tiki_actionlog_params`;

CREATE TABLE `tiki_actionlog_params` (
  `actionId` number(8) NOT NULL,
  `name` varchar(40) NOT NULL,
  `value` clob,
  KEY `actionIDIndex` (`actionId`),
  KEY `nameValue` (`name`, `value`(200))
) ENGINE=MyISAM;


DROP TABLE `tiki_articles`;

CREATE TABLE `tiki_articles` (
  `articleId` number(8) NOT NULL auto_increment,
  `topline` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `subtitle` varchar(255) default NULL,
  `linkto` varchar(255) default NULL,
  `lang` varchar(16) default NULL,
  `state` char(1) default 's',
  `authorName` varchar(60) default NULL,
  `topicId` number(14) default NULL,
  `topicName` varchar(40) default NULL,
  `size` number(12) default NULL,
  `useImage` char(1) default NULL,
  `image_name` varchar(80) default NULL,
  `image_caption` clob default NULL,
  `image_type` varchar(80) default NULL,
  `image_size` number(14) default NULL,
  `image_x` number(4) default NULL,
  `image_y` number(4) default NULL,
  `image_data` blob,
  `publishDate` number(14) default NULL,
  `expireDate` number(14) default NULL,
  `created` number(14) default NULL,
  `heading` clob,
  `body` clob,
  `hash` varchar(32) default NULL,
  `author` varchar(200) default NULL,
  `nbreads` number(14) default NULL,
  `votes` number(8) default NULL,
  `points` number(14) default NULL,
  `type` varchar(50) default NULL,
  `rating` decimal(3,2) default NULL,
  `isfloat` char(1) default NULL,
  PRIMARY KEY (`articleId`),
  KEY `title` (`title`),
  KEY `heading` (`heading`(255)),
  KEY `body` (`body`(255)),
  KEY `nbreads` (`nbreads`),
  KEY `author` (`author`(32)),
  KEY `topicId` (`topicId`),
  KEY `publishDate` (`publishDate`),
  KEY `expireDate` (`expireDate`),
  KEY `type` (`type`),
  FULLTEXT KEY `ft` (`title`, `heading`, `body`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_article_types`;

CREATE TABLE `tiki_article_types` (
  `type` varchar(50) NOT NULL,
  `use_ratings` varchar(1) default NULL,
  `show_pre_publ` varchar(1) default NULL,
  `show_post_expire` varchar(1) default 'y',
  `heading_only` varchar(1) default NULL,
  `allow_comments` varchar(1) default 'y',
  `show_image` varchar(1) default 'y',
  `show_avatar` varchar(1) default NULL,
  `show_author` varchar(1) default 'y',
  `show_pubdate` varchar(1) default 'y',
  `show_expdate` varchar(1) default NULL,
  `show_reads` varchar(1) default 'y',
  `show_size` varchar(1) default 'n',
  `show_topline` varchar(1) default 'n',
  `show_subtitle` varchar(1) default 'n',
  `show_linkto` varchar(1) default 'n',
  `show_image_caption` varchar(1) default 'n',
  `show_lang` varchar(1) default 'n',
  `creator_edit` varchar(1) default NULL,
  `comment_can_rate_article` char(1) default NULL,
  PRIMARY KEY (`type`),
  KEY `show_pre_publ` (`show_pre_publ`),
  KEY `show_post_expire` (`show_post_expire`)
) ENGINE=MyISAM ;


INSERT INTO "tiki_article_types" ("type") VALUES ('Article');

INSERT INTO "tiki_article_types" ("type","use_ratings") VALUES ('Review','y');

INSERT INTO "tiki_article_types" ("type","show_post_expire") VALUES ('Event','n');

INSERT INTO "tiki_article_types" ("type","show_post_expire","heading_only","allow_comments") VALUES ('Classified','n','y','n');


DROP TABLE `tiki_banners`;

CREATE TABLE `tiki_banners` (
  `bannerId` number(12) NOT NULL auto_increment,
  `client` varchar(200) default '' NOT NULL,
  `url` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `alt` varchar(250) default NULL,
  `which` varchar(50) default NULL,
  `imageData` blob,
  `imageType` varchar(200) default NULL,
  `imageName` varchar(100) default NULL,
  `HTMLData` clob,
  `fixedURLData` varchar(255) default NULL,
  `textData` clob,
  `fromDate` number(14) default NULL,
  `toDate` number(14) default NULL,
  `useDates` char(1) default NULL,
  `mon` char(1) default NULL,
  `tue` char(1) default NULL,
  `wed` char(1) default NULL,
  `thu` char(1) default NULL,
  `fri` char(1) default NULL,
  `sat` char(1) default NULL,
  `sun` char(1) default NULL,
  `hourFrom` varchar(4) default NULL,
  `hourTo` varchar(4) default NULL,
  `created` number(14) default NULL,
  `maxImpressions` number(8) default NULL,
  `impressions` number(8) default NULL,
  `maxUserImpressions` number(8) default -1,
  `maxClicks` number(8) default NULL,
  `clicks` number(8) default NULL,
  `zone` varchar(40) default NULL,
  PRIMARY KEY (`bannerId`),
  "INDEX" ban1(zone,useDates,impressions,maxImpressions,hourFrom,hourTo,fromDate,toDate,mon,tue,wed,thu,fri,sat,sun)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_banning`;

CREATE TABLE `tiki_banning` (
  `banId` number(12) NOT NULL auto_increment,
  `mode` enum('user','ip') default NULL,
  `title` varchar(200) default NULL,
  `ip1` char(3) default NULL,
  `ip2` char(3) default NULL,
  `ip3` char(3) default NULL,
  `ip4` char(3) default NULL,
  `user` varchar(200) default '',
  `date_from` timestamp(3) NOT NULL,
  `date_to` timestamp(3) NOT NULL,
  `use_dates` char(1) default NULL,
  `created` number(14) default NULL,
  `message` clob,
  PRIMARY KEY (`banId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_banning_sections`;

CREATE TABLE `tiki_banning_sections` (
  `banId` number(12) default '0' NOT NULL,
  `section` varchar(100) default '' NOT NULL,
  PRIMARY KEY (`banId`,`section`)
) ENGINE=MyISAM;


DROP TABLE `tiki_blog_activity`;

CREATE TABLE `tiki_blog_activity` (
  `blogId` number(8) default '0' NOT NULL,
  `day` number(14) default '0' NOT NULL,
  `posts` number(8) default NULL,
  PRIMARY KEY (`blogId`,`day`)
) ENGINE=MyISAM;


DROP TABLE `tiki_blog_posts`;

CREATE TABLE `tiki_blog_posts` (
  `postId` number(8) NOT NULL auto_increment,
  `blogId` number(8) default '0' NOT NULL,
  `data` clob,
  `data_size` number(11) default '0' NOT NULL,
  `created` number(14) default NULL,
  `user` varchar(200) default '',
  `trackbacks_to` clob,
  `trackbacks_from` clob,
  `title` varchar(255) default NULL,
  `priv` varchar(1) default NULL,
  PRIMARY KEY (`postId`),
  KEY `data` (`data`(255)),
  KEY `blogId` (`blogId`),
  KEY `created` (`created`),
  FULLTEXT KEY `ft` (`data`, `title`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_blog_posts_images`;

CREATE TABLE `tiki_blog_posts_images` (
  `imgId` number(14) NOT NULL auto_increment,
  `postId` number(14) default '0' NOT NULL,
  `filename` varchar(80) default NULL,
  `filetype` varchar(80) default NULL,
  `filesize` number(14) default NULL,
  `data` blob,
  PRIMARY KEY (`imgId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_blogs`;

CREATE TABLE `tiki_blogs` (
  `blogId` number(8) NOT NULL auto_increment,
  `created` number(14) default NULL,
  `lastModif` number(14) default NULL,
  `title` varchar(200) default NULL,
  `description` clob,
  `user` varchar(200) default '',
  `public` char(1) default NULL,
  `posts` number(8) default NULL,
  `maxPosts` number(8) default NULL,
  `hits` number(8) default NULL,
  `activity` decimal(4,2) default NULL,
  `heading` clob,
  `use_find` char(1) default NULL,
  `use_title` char(1) default NULL,
  `add_date` char(1) default NULL,
  `add_poster` char(1) default NULL,
  `allow_comments` char(1) default NULL,
  `show_avatar` char(1) default NULL,
  PRIMARY KEY (`blogId`),
  KEY `title` (`title`),
  KEY `description` (`description`(255)),
  KEY `hits` (`hits`),
  FULLTEXT KEY `ft` (`title`, `description`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_calendar_categories`;

CREATE TABLE `tiki_calendar_categories` (
  `calcatId` number(11) NOT NULL auto_increment,
  `calendarId` number(14) default '0' NOT NULL,
  `name` varchar(255) default '' NOT NULL,
  PRIMARY KEY (`calcatId`),
  UNIQUE KEY `catname` (`calendarId`, `name`(16))
) ENGINE=MyISAM  ;


DROP TABLE `tiki_calendar_recurrence`;

CREATE TABLE `tiki_calendar_recurrence` (
  `recurrenceId` number(14) NOT NULL auto_increment,
  `calendarId` number(14) default '0' NOT NULL,
  `start` number(4) default '0' NOT NULL,
  `end` number(4) default '2359' NOT NULL,
  `allday` number(1) default '0' NOT NULL,
  `locationId` number(14) default NULL,
  `categoryId` number(14) default NULL,
  `nlId` number(12) default '0' NOT NULL,
  `priority` enum('1','2','3','4','5','6','7','8','9') default '1' NOT NULL,
  `status` enum('0','1','2') default '0' NOT NULL,
  `url` varchar(255) default NULL,
  `lang` char(16) default 'en' NOT NULL,
  `name` varchar(255) default '' NOT NULL,
  `description` blob,
  `weekly` number(1) default '0',
  `weekday` number(1),
  `monthly` number(1) default '0',
  `dayOfMonth` number(2),
  `yearly` number(1) default '0',
  `dateOfYear` number(4),
  `nbRecurrences` number(8),
  `startPeriod` number(14),
  `endPeriod` number(14),
  `user` varchar(200) default '',
  `created` number(14) default '0' NOT NULL,
  `lastmodif` number(14) default '0' NOT NULL,
  PRIMARY KEY (`recurrenceId`),
  KEY `calendarId` (`calendarId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_calendar_items`;

CREATE TABLE `tiki_calendar_items` (
  `calitemId` number(14) NOT NULL auto_increment,
  `calendarId` number(14) default '0' NOT NULL,
  `start` number(14) default '0' NOT NULL,
  `end` number(14) default '0' NOT NULL,
  `locationId` number(14) default NULL,
  `categoryId` number(14) default NULL,
  `nlId` number(12) default '0' NOT NULL,
  `priority` enum('0', '1','2','3','4','5','6','7','8','9') default '0',
  `status` enum('0','1','2') default '0' NOT NULL,
  `url` varchar(255) default NULL,
  `lang` char(16) default 'en' NOT NULL,
  `name` varchar(255) default '' NOT NULL,
  `description` clob,
  `recurrenceId` number(14),
  `changed` number(1) DEFAULT '0',
  `user` varchar(200) default '',
  `created` number(14) default '0' NOT NULL,
  `lastmodif` number(14) default '0' NOT NULL,
  `allday` number(1) default '0' NOT NULL,
  PRIMARY KEY (`calitemId`),
  KEY `calendarId` (`calendarId`),
  FULLTEXT KEY `ft` (`name`,`description`),
  "CONSTRAINT" `fk_calitems_recurrence`
  "FOREIGN" KEY (`recurrenceId`) REFERENCES `tiki_calendar_recurrence`(`recurrenceId`)
  "ON" UPDATE CASCADE ON DELETE SET NULL
) ENGINE=MyISAM  ;


DROP TABLE `tiki_calendar_locations`;

CREATE TABLE `tiki_calendar_locations` (
  `callocId` number(14) NOT NULL auto_increment,
  `calendarId` number(14) default '0' NOT NULL,
  `name` varchar(255) default '' NOT NULL,
  `description` blob,
  PRIMARY KEY (`callocId`),
  UNIQUE KEY `locname` (`calendarId`, `name`(16))
) ENGINE=MyISAM  ;


DROP TABLE `tiki_calendar_roles`;

CREATE TABLE `tiki_calendar_roles` (
  `calitemId` number(14) default '0' NOT NULL,
  `username` varchar(200) default '' NOT NULL,
  `role` enum('0','1','2','3','6') default '0' NOT NULL,
  PRIMARY KEY (`calitemId`,`username`(16),`role`)
) ENGINE=MyISAM;


DROP TABLE `tiki_calendars`;

CREATE TABLE `tiki_calendars` (
  `calendarId` number(14) NOT NULL auto_increment,
  `name` varchar(80) default '' NOT NULL,
  `description` varchar(255) default NULL,
  `user` varchar(200) default '' NOT NULL,
  `customlocations` enum('n','y') default 'n' NOT NULL,
  `customcategories` enum('n','y') default 'n' NOT NULL,
  `customlanguages` enum('n','y') default 'n' NOT NULL,
  `custompriorities` enum('n','y') default 'n' NOT NULL,
  `customparticipants` enum('n','y') default 'n' NOT NULL,
  `customsubscription` enum('n','y') default 'n' NOT NULL,
  `customstatus` enum('n','y') default 'y' NOT NULL,
  `created` number(14) default '0' NOT NULL,
  `lastmodif` number(14) default '0' NOT NULL,
  `personal` enum ('n', 'y') default 'n' NOT NULL,
  PRIMARY KEY (`calendarId`)
) ENGINE=MyISAM ;


DROP TABLE `tiki_calendar_options`;

CREATE TABLE `tiki_calendar_options` (
  "calendarId" number(14) default 0 NOT NULL,
  "optionName" varchar(120) default '' NOT NULL,
  "value" varchar(255),
  PRIMARY KEY (`calendarId`,`optionName`)
) ENGINE=MyISAM ;


DROP TABLE `tiki_categories`;

CREATE TABLE `tiki_categories` (
  `categId` number(12) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `description` varchar(250) default NULL,
  `parentId` number(12) default NULL,
  `hits` number(8) default NULL,
  PRIMARY KEY (`categId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_objects`;

CREATE TABLE `tiki_objects` (
  `objectId` number(12) NOT NULL auto_increment,
  `type` varchar(50) default NULL,
  `itemId` varchar(255) default NULL,
  `description` clob,
  `created` number(14) default NULL,
  `name` varchar(200) default NULL,
  `href` varchar(200) default NULL,
  `hits` number(8) default NULL,
  `comments_locked` char(1) default 'n' NOT NULL,
  PRIMARY KEY (`objectId`),
  KEY (`type`, `objectId`),
  KEY (`itemId`, `type`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_categorized_objects`;

CREATE TABLE `tiki_categorized_objects` (
  `catObjectId` number(11) default '0' NOT NULL,
  PRIMARY KEY (`catObjectId`)
) ENGINE=MyISAM ;


DROP TABLE `tiki_category_objects`;

CREATE TABLE `tiki_category_objects` (
  `catObjectId` number(12) default '0' NOT NULL,
  `categId` number(12) default '0' NOT NULL,
  PRIMARY KEY (`catObjectId`,`categId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_object_ratings`;

CREATE TABLE `tiki_object_ratings` (
  `catObjectId` number(12) default '0' NOT NULL,
  `pollId` number(12) default '0' NOT NULL,
  PRIMARY KEY (`catObjectId`,`pollId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_category_sites`;

CREATE TABLE `tiki_category_sites` (
  `categId` number(10) default '0' NOT NULL,
  `siteId` number(14) default '0' NOT NULL,
  PRIMARY KEY (`categId`,`siteId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_chat_channels`;

CREATE TABLE `tiki_chat_channels` (
  `channelId` number(8) NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `description` varchar(250) default NULL,
  `max_users` number(8) default NULL,
  `mode` char(1) default NULL,
  `moderator` varchar(200) default NULL,
  `active` char(1) default NULL,
  `refresh` number(6) default NULL,
  PRIMARY KEY (`channelId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_chat_messages`;

CREATE TABLE `tiki_chat_messages` (
  `messageId` number(8) NOT NULL auto_increment,
  `channelId` number(8) default '0' NOT NULL,
  `data` varchar(255) default NULL,
  `poster` varchar(200) default 'anonymous' NOT NULL,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`messageId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_chat_users`;

CREATE TABLE `tiki_chat_users` (
  `nickname` varchar(200) default '' NOT NULL,
  `channelId` number(8) default '0' NOT NULL,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`nickname`,`channelId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_comments`;

CREATE TABLE `tiki_comments` (
  `threadId` number(14) NOT NULL auto_increment,
  `object` varchar(255) default '' NOT NULL,
  `objectType` varchar(32) default '' NOT NULL,
  `parentId` number(14) default NULL,
  `userName` varchar(200) default '',
  `commentDate` number(14) default NULL,
  `hits` number(8) default NULL,
  `type` char(1) default NULL,
  `points` decimal(8,2) default NULL,
  `votes` number(8) default NULL,
  `average` decimal(8,4) default NULL,
  `title` varchar(255) default NULL,
  `data` clob,
  `hash` varchar(32) default NULL,
  `user_ip` varchar(15) default NULL,
  `summary` varchar(240) default NULL,
  `smiley` varchar(80) default NULL,
  `message_id` varchar(128) default NULL,
  `in_reply_to` varchar(128) default NULL,
  `comment_rating` number(2) default NULL,
  `archived` char(1) default NULL,
  `approved` char(1) default 'y' NOT NULL,
  `locked` char(1) default 'n' NOT NULL,
  PRIMARY KEY (`threadId`),
  UNIQUE KEY `no_repeats` (parentId, userName(40), title(100), commentDate, message_id(40), in_reply_to(40)),
  KEY `title` (title),
  KEY `data` (data(255)),
  KEY `hits` (hits),
  KEY `tc_pi` (parentId),
  KEY `objectType` (object, objectType),
  KEY `commentDate` (commentDate),
  KEY `threaded` (message_id, in_reply_to, parentId),
  FULLTEXT KEY `ft` (title,data)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_content`;

CREATE TABLE `tiki_content` (
  `contentId` number(8) NOT NULL auto_increment,
  `description` clob,
  `contentLabel` varchar(255) default '' NOT NULL,
  PRIMARY KEY (`contentId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_content_templates`;

CREATE TABLE `tiki_content_templates` (
  `templateId` number(10) NOT NULL auto_increment,
  `content` blob,
  `name` varchar(200) default NULL,
  `created` number(14) default NULL,
  PRIMARY KEY (`templateId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_content_templates_sections`;

CREATE TABLE `tiki_content_templates_sections` (
  `templateId` number(10) default '0' NOT NULL,
  `section` varchar(250) default '' NOT NULL,
  PRIMARY KEY (`templateId`,`section`)
) ENGINE=MyISAM;


DROP TABLE `tiki_cookies`;

CREATE TABLE `tiki_cookies` (
  `cookieId` number(10) NOT NULL auto_increment,
  `cookie` clob,
  PRIMARY KEY (`cookieId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_copyrights`;

CREATE TABLE `tiki_copyrights` (
  `copyrightId` number(12) NOT NULL auto_increment,
  `page` varchar(200) default NULL,
  `title` varchar(200) default NULL,
  `year` number(11) default NULL,
  `authors` varchar(200) default NULL,
  `copyright_order` number(11) default NULL,
  `userName` varchar(200) default '',
  PRIMARY KEY (`copyrightId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_directory_categories`;

CREATE TABLE `tiki_directory_categories` (
  `categId` number(10) NOT NULL auto_increment,
  `parent` number(10) default NULL,
  `name` varchar(240) default NULL,
  `description` clob,
  `childrenType` char(1) default NULL,
  `sites` number(10) default NULL,
  `viewableChildren` number(4) default NULL,
  `allowSites` char(1) default NULL,
  `showCount` char(1) default NULL,
  `editorGroup` varchar(200) default NULL,
  `hits` number(12) default NULL,
  PRIMARY KEY (`categId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_directory_search`;

CREATE TABLE `tiki_directory_search` (
  `term` varchar(250) default '' NOT NULL,
  `hits` number(14) default NULL,
  PRIMARY KEY (`term`)
) ENGINE=MyISAM;


DROP TABLE `tiki_directory_sites`;

CREATE TABLE `tiki_directory_sites` (
  `siteId` number(14) NOT NULL auto_increment,
  `name` varchar(240) default NULL,
  `description` clob,
  `url` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `hits` number(12) default NULL,
  `isValid` char(1) default NULL,
  `created` number(14) default NULL,
  `lastModif` number(14) default NULL,
  `cache` blob,
  `cache_timestamp` number(14) default NULL,
  PRIMARY KEY (`siteId`),
  KEY (isValid),
  KEY (url),
  FULLTEXT KEY `ft` (name,description)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_dsn`;

CREATE TABLE `tiki_dsn` (
  `dsnId` number(12) NOT NULL auto_increment,
  `name` varchar(200) default '' NOT NULL,
  `dsn` varchar(255) default NULL,
  PRIMARY KEY (`dsnId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_dynamic_variables`;

CREATE TABLE `tiki_dynamic_variables` (
  `name` varchar(40) NOT NULL,
  `data` clob,
  PRIMARY KEY (`name`)
);


DROP TABLE `tiki_extwiki`;

CREATE TABLE `tiki_extwiki` (
  `extwikiId` number(12) NOT NULL auto_increment,
  `name` varchar(200) default '' NOT NULL,
  `extwiki` varchar(255) default NULL,
  PRIMARY KEY (`extwikiId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_faq_questions`;

CREATE TABLE `tiki_faq_questions` (
  `questionId` number(10) NOT NULL auto_increment,
  `faqId` number(10) default NULL,
  `position` number(4) default NULL,
  `question` clob,
  `answer` clob,
  PRIMARY KEY (`questionId`),
  KEY `faqId` (faqId),
  KEY `question` (question(255)),
  KEY `answer` (answer(255)),
  FULLTEXT KEY `ft` (question,answer)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_faqs`;

CREATE TABLE `tiki_faqs` (
  `faqId` number(10) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `description` clob,
  `created` number(14) default NULL,
  `questions` number(5) default NULL,
  `hits` number(8) default NULL,
  `canSuggest` char(1) default NULL,
  PRIMARY KEY (`faqId`),
  KEY `title` (title),
  KEY `description` (description(255)),
  KEY `hits` (hits),
  FULLTEXT KEY `ft` (title,description)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_featured_links`;

CREATE TABLE `tiki_featured_links` (
  `url` varchar(200) default '' NOT NULL,
  `title` varchar(200) default NULL,
  `description` clob,
  `hits` number(8) default NULL,
  `position` number(6) default NULL,
  `type` char(1) default NULL,
  PRIMARY KEY (`url`)
) ENGINE=MyISAM;


DROP TABLE `tiki_file_galleries`;

CREATE TABLE `tiki_file_galleries` (
  `galleryId` number(14) NOT NULL auto_increment,
  `name` varchar(80) default '' NOT NULL,
  `type` varchar(20) default 'default' NOT NULL,
  `description` clob,
  `created` number(14) default NULL,
  `visible` char(1) default NULL,
  `lastModif` number(14) default NULL,
  `user` varchar(200) default '',
  `hits` number(14) default NULL,
  `votes` number(8) default NULL,
  `points` decimal(8,2) default NULL,
  `maxRows` number(10) default NULL,
  `public` char(1) default NULL,
  `show_id` char(1) default NULL,
  `show_icon` char(1) default NULL,
  `show_name` char(1) default NULL,
  `show_size` char(1) default NULL,
  `show_description` char(1) default NULL,
  `max_desc` number(8) default NULL,
  `show_created` char(1) default NULL,
  `show_hits` char(1) default NULL,
  `parentId` number(14) default -1 NOT NULL,
  `lockable` char(1) default 'n',
  `show_lockedby` char(1) default NULL,
  `archives` number(4) default -1,
  `sort_mode` char(20) default NULL,
  `show_modified` char(1) default NULL,
  `show_author` char(1) default NULL,
  `show_creator` char(1) default NULL,
  `subgal_conf` varchar(200) default NULL,
  `show_last_user` char(1) default NULL,
  `show_comment` char(1) default NULL,
  `show_files` char(1) default NULL,
  `show_explorer` char(1) default NULL,
  `show_path` char(1) default NULL,
  `show_slideshow` char(1) default NULL,
  `default_view` varchar(20) default NULL,
  PRIMARY KEY (`galleryId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_files`;

CREATE TABLE `tiki_files` (
  `fileId` number(14) NOT NULL auto_increment,
  `galleryId` number(14) default '0' NOT NULL,
  `name` varchar(200) default '' NOT NULL,
  `description` clob,
  `created` number(14) default NULL,
  `filename` varchar(80) default NULL,
  `filesize` number(14) default NULL,
  `filetype` varchar(250) default NULL,
  `data` blob,
  `user` varchar(200) default '',
  `author` varchar(40) default NULL,
  `hits` number(14) default NULL,
  `votes` number(8) default NULL,
  `points` decimal(8,2) default NULL,
  `path` varchar(255) default NULL,
  `reference_url` varchar(250) default NULL,
  `is_reference` char(1) default NULL,
  `hash` varchar(32) default NULL,
  `search_data` longtext,
  `lastModif` integer(14) DEFAULT NULL,
  `lastModifUser` varchar(200) DEFAULT NULL,
  `lockedby` varchar(200) default '',
  `comment` varchar(200) default NULL,
  `archiveId` number(14) default 0,
  PRIMARY KEY (`fileId`),
  KEY `name` (name),
  KEY `description` (description(255)),
  KEY `created` (created),
  KEY `archiveId` (archiveId),
  KEY `galleryId` (galleryId),
  KEY `hits` (hits),
  FULLTEXT KEY `ft` (name,description,search_data,filename)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_forum_attachments`;

CREATE TABLE `tiki_forum_attachments` (
  `attId` number(14) NOT NULL auto_increment,
  `threadId` number(14) default '0' NOT NULL,
  `qId` number(14) default '0' NOT NULL,
  `forumId` number(14) default NULL,
  `filename` varchar(250) default NULL,
  `filetype` varchar(250) default NULL,
  `filesize` number(12) default NULL,
  `data` blob,
  `dir` varchar(200) default NULL,
  `created` number(14) default NULL,
  `path` varchar(250) default NULL,
  PRIMARY KEY (`attId`),
  KEY `threadId` (threadId)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_forum_reads`;

CREATE TABLE `tiki_forum_reads` (
  `user` varchar(200) default '' NOT NULL,
  `threadId` number(14) default '0' NOT NULL,
  `forumId` number(14) default NULL,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`user`,`threadId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_forums`;

CREATE TABLE `tiki_forums` (
  `forumId` number(8) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` clob,
  `created` number(14) default NULL,
  `lastPost` number(14) default NULL,
  `threads` number(8) default NULL,
  `comments` number(8) default NULL,
  `controlFlood` char(1) default NULL,
  `floodInterval` number(8) default NULL,
  `moderator` varchar(200) default NULL,
  `hits` number(8) default NULL,
  `mail` varchar(200) default NULL,
  `useMail` char(1) default NULL,
  `section` varchar(200) default NULL,
  `usePruneUnreplied` char(1) default NULL,
  `pruneUnrepliedAge` number(8) default NULL,
  `usePruneOld` char(1) default NULL,
  `pruneMaxAge` number(8) default NULL,
  `topicsPerPage` number(6) default NULL,
  `topicOrdering` varchar(100) default NULL,
  `threadOrdering` varchar(100) default NULL,
  `att` varchar(80) default NULL,
  `att_store` varchar(4) default NULL,
  `att_store_dir` varchar(250) default NULL,
  `att_max_size` number(12) default NULL,
  `ui_level` char(1) default NULL,
  `forum_password` varchar(32) default NULL,
  `forum_use_password` char(1) default NULL,
  `moderator_group` varchar(200) default NULL,
  `approval_type` varchar(20) default NULL,
  `outbound_address` varchar(250) default NULL,
  `outbound_mails_for_inbound_mails` char(1) default NULL,
  `outbound_mails_reply_link` char(1) default NULL,
  `outbound_from` varchar(250) default NULL,
  `inbound_pop_server` varchar(250) default NULL,
  `inbound_pop_port` number(4) default NULL,
  `inbound_pop_user` varchar(200) default NULL,
  `inbound_pop_password` varchar(80) default NULL,
  `topic_smileys` char(1) default NULL,
  `ui_avatar` char(1) default NULL,
  `ui_flag` char(1) default NULL,
  `ui_posts` char(1) default NULL,
  `ui_email` char(1) default NULL,
  `ui_online` char(1) default NULL,
  `topic_summary` char(1) default NULL,
  `show_description` char(1) default NULL,
  `topics_list_replies` char(1) default NULL,
  `topics_list_reads` char(1) default NULL,
  `topics_list_pts` char(1) default NULL,
  `topics_list_lastpost` char(1) default NULL,
  `topics_list_author` char(1) default NULL,
  `vote_threads` char(1) default NULL,
  `forum_last_n` number(2) default 0,
  `threadStyle` varchar(100) default NULL,
  `commentsPerPage` varchar(100) default NULL,
  `is_flat` char(1) default NULL,
  `mandatory_contribution` char(1) default NULL,
  PRIMARY KEY (`forumId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_forums_queue`;

CREATE TABLE `tiki_forums_queue` (
  `qId` number(14) NOT NULL auto_increment,
  `object` varchar(32) default NULL,
  `parentId` number(14) default NULL,
  `forumId` number(14) default NULL,
  `timestamp` number(14) default NULL,
  `user` varchar(200) default '',
  `title` varchar(240) default NULL,
  `data` clob,
  `type` varchar(60) default NULL,
  `hash` varchar(32) default NULL,
  `topic_smiley` varchar(80) default NULL,
  `topic_title` varchar(240) default NULL,
  `summary` varchar(240) default NULL,
  `in_reply_to` varchar(128) default NULL,
  `tags` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  PRIMARY KEY (`qId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_forums_reported`;

CREATE TABLE `tiki_forums_reported` (
  `threadId` number(12) default '0' NOT NULL,
  `forumId` number(12) default '0' NOT NULL,
  `parentId` number(12) default '0' NOT NULL,
  `user` varchar(200) default '',
  `timestamp` number(14) default NULL,
  `reason` varchar(250) default NULL,
  PRIMARY KEY (`threadId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_galleries`;

CREATE TABLE `tiki_galleries` (
  `galleryId` number(14) NOT NULL auto_increment,
  `name` varchar(80) default '' NOT NULL,
  `description` clob,
  `created` number(14) default NULL,
  `lastModif` number(14) default NULL,
  `visible` char(1) default NULL,
  `geographic` char(1) default NULL,
  `theme` varchar(60) default NULL,
  `user` varchar(200) default '',
  `hits` number(14) default NULL,
  `maxRows` number(10) default NULL,
  `rowImages` number(10) default NULL,
  `thumbSizeX` number(10) default NULL,
  `thumbSizeY` number(10) default NULL,
  `public` char(1) default NULL,
  `sortorder` varchar(20) default 'created' NOT NULL,
  `sortdirection` varchar(4) default 'desc' NOT NULL,
  `galleryimage` varchar(20) default 'first' NOT NULL,
  `parentgallery` number(14) default -1 NOT NULL,
  `showname` char(1) default 'y' NOT NULL,
  `showimageid` char(1) default 'n' NOT NULL,
  `showdescription` char(1) default 'n' NOT NULL,
  `showcreated` char(1) default 'n' NOT NULL,
  `showuser` char(1) default 'n' NOT NULL,
  `showhits` char(1) default 'y' NOT NULL,
  `showxysize` char(1) default 'y' NOT NULL,
  `showfilesize` char(1) default 'n' NOT NULL,
  `showfilename` char(1) default 'n' NOT NULL,
  `defaultscale` varchar(10) DEFAULT 'o' NOT NULL,
  `showcategories` char(1) default 'n' NOT NULL, 
  PRIMARY KEY (`galleryId`),
  KEY `name` (name),
  KEY `description` (description(255)),
  KEY `hits` (hits),
  KEY `parentgallery` (parentgallery),
  KEY `visibleUser` (visible, user),
  FULLTEXT KEY `ft` (name,description)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_galleries_scales`;

CREATE TABLE `tiki_galleries_scales` (
  `galleryId` number(14) default '0' NOT NULL,
  `scale` number(11) default '0' NOT NULL,
  PRIMARY KEY (`galleryId`,`scale`)
) ENGINE=MyISAM;


DROP TABLE `tiki_group_inclusion`;

CREATE TABLE `tiki_group_inclusion` (
  `groupName` varchar(255) default '' NOT NULL,
  `includeGroup` varchar(255) default '' NOT NULL,
  PRIMARY KEY (`groupName`(30),`includeGroup`(30))
) ENGINE=MyISAM;


DROP TABLE `tiki_group_watches`;

CREATE TABLE `tiki_group_watches` (
  `watchId` number(12) NOT NULL auto_increment,
  `group` varchar(200) default '' NOT NULL,
  `event` varchar(40) default '' NOT NULL,
  `object` varchar(200) default '' NOT NULL,
  `title` varchar(250) default NULL,
  `type` varchar(200) default NULL,
  `url` varchar(250) default NULL,
  KEY `watchId` (watchId),
  PRIMARY KEY (`group`(50),event,object(100))
) ENGINE=MyISAM;


DROP TABLE `tiki_history`;

CREATE TABLE `tiki_history` (
  `historyId` number(12) NOT NULL auto_increment,
  `pageName` varchar(160) default '' NOT NULL,
  `version` number(8) default '0' NOT NULL,
  `version_minor` number(8) default '0' NOT NULL,
  `lastModif` number(14) default NULL,
  `description` varchar(200) default NULL,
  `user` varchar(200) default '' not null,
  `ip` varchar(15) default NULL,
  `comment` varchar(200) default NULL,
  `data` blob,
  `type` varchar(50) default NULL,
  `is_html` TINYINT(1) DEFAULT 0 NOT NULL,
  PRIMARY KEY (`pageName`,`version`),
  KEY `user` (`user`),
  KEY(historyId)
) ENGINE=MyISAM;


DROP TABLE `tiki_hotwords`;

CREATE TABLE `tiki_hotwords` (
  `word` varchar(40) default '' NOT NULL,
  `url` varchar(255) default '' NOT NULL,
  PRIMARY KEY (`word`)
) ENGINE=MyISAM;


DROP TABLE `tiki_html_pages`;

CREATE TABLE `tiki_html_pages` (
  `pageName` varchar(200) default '' NOT NULL,
  `content` blob,
  `refresh` number(10) default NULL,
  `type` char(1) default NULL,
  `created` number(14) default NULL,
  PRIMARY KEY (`pageName`)
) ENGINE=MyISAM;


DROP TABLE `tiki_html_pages_dynamic_zones`;

CREATE TABLE `tiki_html_pages_dynamic_zones` (
  `pageName` varchar(40) default '' NOT NULL,
  `zone` varchar(80) default '' NOT NULL,
  `type` char(2) default NULL,
  `content` clob,
  PRIMARY KEY (`pageName`,`zone`)
) ENGINE=MyISAM;


DROP TABLE `tiki_images`;

CREATE TABLE `tiki_images` (
  `imageId` number(14) NOT NULL auto_increment,
  `galleryId` number(14) default '0' NOT NULL,
  `name` varchar(200) default '' NOT NULL,
  `description` clob,
  `lon` float default NULL,
  `lat` float default NULL,
  `created` number(14) default NULL,
  `user` varchar(200) default '',
  `hits` number(14) default NULL,
  `path` varchar(255) default NULL,
  PRIMARY KEY (`imageId`),
  KEY `name` (name),
  KEY `description` (description(255)),
  KEY `hits` (hits),
  KEY `ti_gId` (galleryId),
  KEY `ti_cr` (created),
  KEY `ti_us` (user),
  FULLTEXT KEY `ft` (name,description)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_images_data`;

CREATE TABLE `tiki_images_data` (
  `imageId` number(14) default '0' NOT NULL,
  `xsize` number(8) default '0' NOT NULL,
  `ysize` number(8) default '0' NOT NULL,
  `type` char(1) default '' NOT NULL,
  `filesize` number(14) default NULL,
  `filetype` varchar(80) default NULL,
  `filename` varchar(80) default NULL,
  `data` blob,
  `etag` varchar(32) default NULL,
  PRIMARY KEY (`imageId`,`xsize`,`ysize`,`type`),
  KEY `t_i_d_it` (imageId,type)
) ENGINE=MyISAM;


DROP TABLE `tiki_language`;

CREATE TABLE `tiki_language` (
  `source` blob NOT NULL,
  `lang` char(16) default '' NOT NULL,
  `tran` blob,
  PRIMARY KEY (`source`(255),`lang`)
) ENGINE=MyISAM;


DROP TABLE `tiki_languages`;

CREATE TABLE `tiki_languages` (
  `lang` char(16) default '' NOT NULL,
  `language` varchar(255) default NULL,
  PRIMARY KEY (`lang`)
) ENGINE=MyISAM;


INSERT INTO tiki_languages(lang, language) VALUES('en','English');


DROP TABLE `tiki_link_cache`;

CREATE TABLE `tiki_link_cache` (
  `cacheId` number(14) NOT NULL auto_increment,
  `url` varchar(250) default NULL,
  `data` blob,
  `refresh` number(14) default NULL,
  PRIMARY KEY (`cacheId`),
  KEY `url` (url)
) ENGINE=MyISAM  ;

CREATE INDEX urlindex ON tiki_link_cache (url(250));


DROP TABLE `tiki_links`;

CREATE TABLE `tiki_links` (
  `fromPage` varchar(160) default '' NOT NULL,
  `toPage` varchar(160) default '' NOT NULL,
  `reltype` varchar(50),
  PRIMARY KEY (`fromPage`,`toPage`),
  KEY `toPage` (toPage)
) ENGINE=MyISAM;


DROP TABLE `tiki_live_support_events`;

CREATE TABLE `tiki_live_support_events` (
  `eventId` number(14) NOT NULL auto_increment,
  `reqId` varchar(32) default '' NOT NULL,
  `type` varchar(40) default NULL,
  `seqId` number(14) default NULL,
  `senderId` varchar(32) default NULL,
  `data` clob,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`eventId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_live_support_message_comments`;

CREATE TABLE `tiki_live_support_message_comments` (
  `cId` number(12) NOT NULL auto_increment,
  `msgId` number(12) default NULL,
  `data` clob,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`cId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_live_support_messages`;

CREATE TABLE `tiki_live_support_messages` (
  `msgId` number(12) NOT NULL auto_increment,
  `data` clob,
  `timestamp` number(14) default NULL,
  `user` varchar(200) default '' not null,
  `username` varchar(200) default NULL,
  `priority` number(2) default NULL,
  `status` char(1) default NULL,
  `assigned_to` varchar(200) default NULL,
  `resolution` varchar(100) default NULL,
  `title` varchar(200) default NULL,
  `module` number(4) default NULL,
  `email` varchar(250) default NULL,
  PRIMARY KEY (`msgId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_live_support_modules`;

CREATE TABLE `tiki_live_support_modules` (
  `modId` number(4) NOT NULL auto_increment,
  `name` varchar(90) default NULL,
  PRIMARY KEY (`modId`)
) ENGINE=MyISAM  ;


INSERT INTO tiki_live_support_modules(name) VALUES('wiki');

INSERT INTO tiki_live_support_modules(name) VALUES('forums');

INSERT INTO tiki_live_support_modules(name) VALUES('image galleries');

INSERT INTO tiki_live_support_modules(name) VALUES('file galleries');

INSERT INTO tiki_live_support_modules(name) VALUES('directory');

INSERT INTO tiki_live_support_modules(name) VALUES('workflow');


DROP TABLE `tiki_live_support_operators`;

CREATE TABLE `tiki_live_support_operators` (
  `user` varchar(200) default '' NOT NULL,
  `accepted_requests` number(10) default NULL,
  `status` varchar(20) default NULL,
  `longest_chat` number(10) default NULL,
  `shortest_chat` number(10) default NULL,
  `average_chat` number(10) default NULL,
  `last_chat` number(14) default NULL,
  `time_online` number(10) default NULL,
  `votes` number(10) default NULL,
  `points` number(10) default NULL,
  `status_since` number(14) default NULL,
  PRIMARY KEY (`user`)
) ENGINE=MyISAM;


DROP TABLE `tiki_live_support_requests`;

CREATE TABLE `tiki_live_support_requests` (
  `reqId` varchar(32) default '' NOT NULL,
  `user` varchar(200) default '' NOT NULL,
  `tiki_user` varchar(200) default NULL,
  `email` varchar(200) default NULL,
  `operator` varchar(200) default NULL,
  `operator_id` varchar(32) default NULL,
  `user_id` varchar(32) default NULL,
  `reason` clob,
  `req_timestamp` number(14) default NULL,
  `timestamp` number(14) default NULL,
  `status` varchar(40) default NULL,
  `resolution` varchar(40) default NULL,
  `chat_started` number(14) default NULL,
  `chat_ended` number(14) default NULL,
  PRIMARY KEY (`reqId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_logs`;

CREATE TABLE `tiki_logs` (
  `logId` number(8) NOT NULL auto_increment,
  `logtype` varchar(20) NOT NULL,
  `logmessage` clob NOT NULL,
  `loguser` varchar(40) NOT NULL,
  `logip` varchar(200),
  `logclient` clob NOT NULL,
  `logtime` number(14) NOT NULL,
  PRIMARY KEY (`logId`),
  KEY `logtype` (logtype)
) ENGINE=MyISAM;


DROP TABLE `tiki_mail_events`;

CREATE TABLE `tiki_mail_events` (
  `event` varchar(200) default NULL,
  `object` varchar(200) default NULL,
  `email` varchar(200) default NULL
) ENGINE=MyISAM;


DROP TABLE `tiki_mailin_accounts`;

CREATE TABLE `tiki_mailin_accounts` (
  `accountId` number(12) NOT NULL auto_increment,
  `user` varchar(200) default '' NOT NULL,
  `account` varchar(50) default '' NOT NULL,
  `pop` varchar(255) default NULL,
  `port` number(4) default NULL,
  `username` varchar(100) default NULL,
  `pass` varchar(100) default NULL,
  `active` char(1) default NULL,
  `type` varchar(40) default NULL,
  `smtp` varchar(255) default NULL,
  `useAuth` char(1) default NULL,
  `smtpPort` number(4) default NULL,
  `anonymous` char(1) default 'y' NOT NULL,
  `attachments` char(1) default 'n' NOT NULL,
  `article_topicId` number(4) default NULL,
  `article_type` varchar(50) default NULL,
  `discard_after` varchar(255) default NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_menu_languages`;

CREATE TABLE `tiki_menu_languages` (
  `menuId` number(8) NOT NULL auto_increment,
  `language` char(16) default '' NOT NULL,
  PRIMARY KEY (`menuId`,`language`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_menu_options`;

CREATE TABLE `tiki_menu_options` (
  `optionId` number(8) NOT NULL auto_increment,
  `menuId` number(8) default NULL,
  `type` char(1) default NULL,
  `name` varchar(200) default NULL,
  `url` varchar(255) default NULL,
  `position` number(4) default NULL,
  `section` clob default NULL,
  `perm` clob default NULL,
  `groupname` clob default NULL,
  `userlevel` number(4) default 0,
  `icon` varchar(200),
  PRIMARY KEY (`optionId`),
  UNIQUE KEY `uniq_menu` (menuId,name(30),url(50),position,section(60),perm(50),groupname(50))
) ENGINE=MyISAM  ;


-- when adding new inserts, order commands by position
INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Home','./',10,'','','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Search','tiki-searchresults.php',13,'feature_search_fulltext','tiki_p_search','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Search','tiki-searchindex.php',13,'feature_search','tiki_p_search','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Contact Us','tiki-contact.php',20,'feature_contact,feature_messages','','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Stats','tiki-stats.php',23,'feature_stats','tiki_p_view_stats','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Categories','tiki-browse_categories.php',25,'feature_categories','tiki_p_view_categories','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Freetags','tiki-browse_freetags.php',27,'feature_freetags','tiki_p_view_freetags','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Calendar','tiki-calendar.php',35,'feature_calendar','tiki_p_view_calendar','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Users Map','tiki-gmap_usermap.php',36,'feature_gmap','','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Tiki Calendar','tiki-action_calendar.php',37,'feature_action_calendar','tiki_p_view_tiki_calendar','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Mobile','tiki-mobile.php',37,'feature_mobile','','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','(debug)','javascript:toggle(\'debugconsole\')',40,'feature_debug_console','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','MyTiki','tiki-my_tiki.php',50,'feature_mytiki','','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','MyTiki Home','tiki-my_tiki.php',51,'feature_mytiki','','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Preferences','tiki-user_preferences.php',55,'feature_mytiki,feature_userPreferences','','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Messages','messu-mailbox.php',60,'feature_mytiki,feature_messages','tiki_p_messages','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Tasks','tiki-user_tasks.php',65,'feature_mytiki,feature_tasks','tiki_p_tasks','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Bookmarks','tiki-user_bookmarks.php',70,'feature_mytiki,feature_user_bookmarks','tiki_p_create_bookmarks','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Modules','tiki-user_assigned_modules.php',75,'feature_mytiki,user_assigned_modules','tiki_p_configure_modules','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Webmail','tiki-webmail.php',85,'feature_mytiki,feature_webmail','tiki_p_use_webmail','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Contacts','tiki-contacts.php',87,'feature_mytiki,feature_contacts','','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Notepad','tiki-notepad_list.php',90,'feature_mytiki,feature_notepad','tiki_p_notepad','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','My Files','tiki-userfiles.php',95,'feature_mytiki,feature_userfiles','tiki_p_userfiles','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','User Menu','tiki-usermenu.php',100,'feature_mytiki,feature_usermenu','tiki_p_usermenu','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Mini Calendar','tiki-minical.php',105,'feature_mytiki,feature_minical','tiki_p_minical','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','My Watches','tiki-user_watches.php',110,'feature_mytiki,feature_user_watches','','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Workflow','tiki-g-user_processes.php',150,'feature_workflow','tiki_p_use_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Processes','tiki-g-admin_processes.php',155,'feature_workflow','tiki_p_admin_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Monitor Processes','tiki-g-monitor_processes.php',160,'feature_workflow','tiki_p_admin_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Monitor Activities','tiki-g-monitor_activities.php',165,'feature_workflow','tiki_p_admin_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Monitor Instances','tiki-g-monitor_instances.php',170,'feature_workflow','tiki_p_admin_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','User Processes','tiki-g-user_processes.php',175,'feature_workflow','tiki_p_use_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','User activities','tiki-g-user_activities.php',180,'feature_workflow','tiki_p_use_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','User instances','tiki-g-user_instances.php',185,'feature_workflow','tiki_p_use_workflow','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Community','tiki-list_users.php',187,'feature_friends','tiki_p_list_users','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','User List','tiki-list_users.php',188,'feature_friends','tiki_p_list_users','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Friendship Network','tiki-friends.php',189,'feature_friends','','Registered',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Wiki','tiki-index.php',200,'feature_wiki','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Wiki Home','tiki-index.php',202,'feature_wiki','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Last Changes','tiki-lastchanges.php',205,'feature_wiki,feature_lastChanges','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Dump','dump/new.tar',210,'feature_wiki,feature_dump','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Rankings','tiki-wiki_rankings.php',215,'feature_wiki,feature_wiki_rankings','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Pages','tiki-listpages.php',220,'feature_wiki,feature_listPages','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Orphan Pages','tiki-orphan_pages.php',225,'feature_wiki,feature_listorphanPages','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Sandbox','tiki-editpage.php?page=sandbox',230,'feature_wiki,feature_sandbox','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Multiple Print','tiki-print_pages.php',235,'feature_wiki,feature_wiki_multiprint','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Send Pages','tiki-send_objects.php',240,'feature_wiki,feature_comm','tiki_p_view,tiki_p_send_pages','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Received Pages','tiki-received_pages.php',245,'feature_wiki,feature_comm','tiki_p_view,tiki_p_admin_received_pages','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Structures','tiki-admin_structures.php',250,'feature_wiki,feature_wiki_structure','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Mind Map','tiki-mindmap.php',255,'feature_wiki_mindmap','tiki_p_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Image Galleries','tiki-galleries.php',300,'feature_galleries','tiki_p_view_image_gallery','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Galleries','tiki-galleries.php',305,'feature_galleries','tiki_p_list_image_galleries','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Rankings','tiki-galleries_rankings.php',310,'feature_galleries,feature_gal_rankings','tiki_p_list_image_galleries','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Upload Image','tiki-upload_image.php',315,'feature_galleries','tiki_p_upload_images','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Directory Batch','tiki-batch_upload.php',318,'feature_galleries,feature_gal_batch','tiki_p_batch_upload','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','System Gallery','tiki-list_gallery.php?galleryId=0',320,'feature_galleries','tiki_p_admin_galleries','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Articles','tiki-view_articles.php',350,'feature_articles','tiki_p_read_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Articles','tiki-view_articles.php',350,'feature_articles','tiki_p_articles_read_heading','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Articles Home','tiki-view_articles.php',355,'feature_articles','tiki_p_read_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Articles Home','tiki-view_articles.php',355,'feature_articles','tiki_p_articles_read_heading','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Articles','tiki-list_articles.php',360,'feature_articles','tiki_p_read_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Articles','tiki-list_articles.php',360,'feature_articles','tiki_p_articles_read_heading','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Rankings','tiki-cms_rankings.php',365,'feature_articles,feature_cms_rankings','tiki_p_read_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Submit Article','tiki-edit_submission.php',370,'feature_articles,feature_submissions','tiki_p_read_article,tiki_p_submit_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','View submissions','tiki-list_submissions.php',375,'feature_articles,feature_submissions','tiki_p_read_article,tiki_p_submit_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','View submissions','tiki-list_submissions.php',375,'feature_articles,feature_submissions','tiki_p_read_article,tiki_p_approve_submission','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','View Submissions','tiki-list_submissions.php',375,'feature_articles,feature_submissions','tiki_p_read_article,tiki_p_remove_submission','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','New Article','tiki-edit_article.php',380,'feature_articles','tiki_p_read_article,tiki_p_edit_article','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Send Articles','tiki-send_objects.php',385,'feature_articles,feature_comm','tiki_p_read_article,tiki_p_send_articles','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Received Articles','tiki-received_articles.php',385,'feature_articles,feature_comm','tiki_p_read_article,tiki_p_admin_received_articles','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Types','tiki-article_types.php',395,'feature_articles','tiki_p_articles_admin_types','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Topics','tiki-admin_topics.php',390,'feature_articles','tiki_p_articles_admin_topics','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Blogs','tiki-list_blogs.php',450,'feature_blogs','tiki_p_read_blog','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Blogs','tiki-list_blogs.php',455,'feature_blogs','tiki_p_read_blog','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Rankings','tiki-blog_rankings.php',460,'feature_blogs,feature_blog_rankings','tiki_p_read_blog','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Create/Edit Blog','tiki-edit_blog.php',465,'feature_blogs','tiki_p_read_blog,tiki_p_create_blogs','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Post','tiki-blog_post.php',470,'feature_blogs','tiki_p_read_blog,tiki_p_blog_post','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Posts','tiki-list_posts.php',475,'feature_blogs','tiki_p_read_blog,tiki_p_blog_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Forums','tiki-forums.php',500,'feature_forums','tiki_p_forum_read','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Forums','tiki-forums.php',505,'feature_forums','tiki_p_forum_read','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Rankings','tiki-forum_rankings.php',510,'feature_forums,feature_forum_rankings','tiki_p_forum_read','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Forums','tiki-admin_forums.php',515,'feature_forums','tiki_p_forum_read,tiki_p_admin_forum','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Directory','tiki-directory_browse.php',550,'feature_directory','tiki_p_view_directory','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Submit a new link','tiki-directory_add_site.php',555,'feature_directory','tiki_p_submit_link','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Browse Directory','tiki-directory_browse.php',560,'feature_directory','tiki_p_view_directory','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Directory','tiki-directory_admin.php',565,'feature_directory','tiki_p_view_directory,tiki_p_admin_directory_cats','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Directory','tiki-directory_admin.php',565,'feature_directory','tiki_p_view_directory,tiki_p_admin_directory_sites','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Directory','tiki-directory_admin.php',565,'feature_directory','tiki_p_view_directory,tiki_p_validate_links','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','File Galleries','tiki-list_file_gallery.php',600,'feature_file_galleries','tiki-list_file_gallery.php|tiki_p_view_file_gallery|tiki_p_upload_files','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Galleries','tiki-list_file_gallery.php',605,'feature_file_galleries','tiki_p_list_file_galleries','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Rankings','tiki-file_galleries_rankings.php',610,'feature_file_galleries,feature_file_galleries_rankings','tiki_p_list_file_galleries','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Upload File','tiki-upload_file.php',615,'feature_file_galleries','tiki_p_upload_files','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Directory batch','tiki-batch_upload_files.php',617,'feature_file_galleries_batch','tiki_p_batch_upload_file_dir','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','FAQs','tiki-list_faqs.php',650,'feature_faqs','tiki_p_view_faqs','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List FAQs','tiki-list_faqs.php',665,'feature_faqs','tiki_p_view_faqs','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin FAQs','tiki-list_faqs.php',660,'feature_faqs','tiki_p_admin_faqs','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Maps','tiki-map.php',700,'feature_maps','tiki_p_map_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Mapfiles','tiki-map_edit.php',705,'feature_maps','tiki_p_map_view','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Layer Management','tiki-map_upload.php',710,'feature_maps','tiki_p_map_edit','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Quizzes','tiki-list_quizzes.php',750,'feature_quizzes','tiki_p_take_quiz','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Quizzes','tiki-list_quizzes.php',755,'feature_quizzes','tiki_p_take_quiz','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Quiz Stats','tiki-quiz_stats.php',760,'feature_quizzes','tiki_p_view_quiz_stats','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Quizzes','tiki-edit_quiz.php',765,'feature_quizzes','tiki_p_admin_quizzes','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','TikiSheet','tiki-sheets.php',780,'feature_sheet','tiki_p_view_sheet','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List TikiSheets','tiki-sheets.php',782,'feature_sheet','tiki_p_view_sheet','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Trackers','tiki-list_trackers.php',800,'feature_trackers','tiki_p_view_trackers','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Trackers','tiki-list_trackers.php',805,'feature_trackers','tiki_p_view_trackers','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Trackers','tiki-admin_trackers.php',810,'feature_trackers','tiki_p_admin_trackers','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Surveys','tiki-list_surveys.php',850,'feature_surveys','tiki_p_take_survey','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','List Surveys','tiki-list_surveys.php',855,'feature_surveys','tiki_p_take_survey','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Stats','tiki-survey_stats.php',860,'feature_surveys','tiki_p_view_survey_stats','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Surveys','tiki-admin_surveys.php',865,'feature_surveys','tiki_p_admin_surveys','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Newsletters','tiki-newsletters.php',900,'feature_newsletters','tiki_p_subscribe_newsletters','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Newsletters','tiki-newsletters.php',900,'feature_newsletters','tiki_p_send_newsletters','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Newsletters','tiki-newsletters.php',900,'feature_newsletters','tiki_p_admin_newsletters','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'s','Newsletters','tiki-newsletters.php',900,'feature_newsletters','tiki_p_list_newsletters','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Send Newsletters','tiki-send_newsletters.php',905,'feature_newsletters','tiki_p_send_newsletters','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Newsletters','tiki-admin_newsletters.php',910,'feature_newsletters','tiki_p_admin_newsletters','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_categories','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_banners','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_edit_templates','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_edit_cookies','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_dynamic','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_mailin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_edit_content_templates','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_edit_html_pages','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_view_referer_stats','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_shoutbox','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_live_support_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','user_is_operator','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'feature_integrator','tiki_p_admin_integrator','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'feature_edit_templates','tiki_p_edit_templates','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'feature_view_tpl','tiki_p_edit_templates','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'feature_editcss','tiki_p_create_css','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_contribution','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_users','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_admin_quicktags','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_edit_menu','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'r','Admin','tiki-admin.php',1050,'','tiki_p_clean_cache','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Admin Home','tiki-admin.php',1051,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Live Support','tiki-live_support_admin.php',1055,'feature_live_support','tiki_p_live_support_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Live Support','tiki-live_support_admin.php',1055,'feature_live_support','user_is_operator','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Banning','tiki-admin_banning.php',1060,'feature_banning','tiki_p_admin_banning','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Calendar','tiki-admin_calendars.php',1065,'feature_calendar','tiki_p_admin_calendar','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Users','tiki-adminusers.php',1070,'','tiki_p_admin_users','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Groups','tiki-admingroups.php',1075,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Wiki Cache','tiki-list_cache.php',1080,'cachepages','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Modules','tiki-admin_modules.php',1085,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Hotwords','tiki-admin_hotwords.php',1095,'feature_hotwords','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','RSS Modules','tiki-admin_rssmodules.php',1100,'','tiki_p_admin_rssmodules','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Menus','tiki-admin_menus.php',1105,'','tiki_p_edit_menu','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Polls','tiki-admin_polls.php',1110,'feature_polls','tiki_p_admin_polls','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Mail Notifications','tiki-admin_notifications.php',1120,'','tiki_p_admin_notifications','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Search Stats','tiki-search_stats.php',1125,'feature_search_stats','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Theme Control','tiki-theme_control.php',1130,'feature_theme_control','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','QuickTags','tiki-admin_quicktags.php',1135,'','tiki_p_admin_quicktags','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Categories','tiki-admin_categories.php',1145,'feature_categories','tiki_p_admin_categories','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Banners','tiki-list_banners.php',1150,'feature_banners','tiki_p_admin_banners','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Edit Templates','tiki-edit_templates.php',1155,'feature_edit_templates','tiki_p_edit_templates','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','View Templates','tiki-edit_templates.php',1155,'feature_view_tpl','tiki_p_edit_templates','',2);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Edit CSS','tiki-edit_css.php',1158,'feature_editcss','tiki_p_create_css','',2);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Dynamic content','tiki-list_contents.php',1165,'feature_dynamic_content','tiki_p_admin_dynamic','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Mail-in','tiki-admin_mailin.php',1175,'feature_mailin','tiki_p_admin_mailin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','HTML Pages','tiki-admin_html_pages.php',1185,'feature_html_pages','tiki_p_edit_html_pages','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Shoutbox','tiki-shoutbox.php',1190,'feature_shoutbox','tiki_p_admin_shoutbox','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Shoutbox Words','tiki-admin_shoutbox_words.php',1191,'feature_shoutbox','tiki_p_admin_shoutbox','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Referer Stats','tiki-referer_stats.php',1195,'feature_referer_stats','tiki_p_view_referer_stats','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Integrator','tiki-admin_integrator.php',1205,'feature_integrator','tiki_p_admin_integrator','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','phpinfo','tiki-phpinfo.php',1215,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Tiki Cache/Sys Admin','tiki-admin_system.php',1230,'','tiki_p_clean_cache','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Tiki Importer','tiki-importer.php',1240,'','tiki_p_admin_importer','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Tiki Logs','tiki-syslog.php',1245,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Security Admin','tiki-admin_security.php',1250,'','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Action Log','tiki-admin_actionlog.php',1255,'feature_actionlog','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Action Log','tiki-admin_actionlog.php',1255,'feature_actionlog','tiki_p_view_actionlog','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Action Log','tiki-admin_actionlog.php',1255,'feature_actionlog','tiki_p_view_actionlog_owngroups','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Content Templates','tiki-admin_content_templates.php',1256,'','tiki_p_edit_content_templates','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_wiki_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_article_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_blog_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_file_galleries_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_image_galleries_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_poll_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Comments','tiki-list_comments.php',1260,'feature_faq_comments','tiki_p_admin','',0);

INSERT INTO "," ("`menuId`","`type`","`name`","`url`","`position`","`section`","`perm`","`groupname`","`userlevel`") VALUES (42,'o','Contribution','tiki-admin_contribution.php',1265,'feature_contribution','tiki_p_admin_contribution','',0);


DROP TABLE `tiki_menus`;

CREATE TABLE `tiki_menus` (
  `menuId` number(8) NOT NULL auto_increment,
  `name` varchar(200) default '' NOT NULL,
  `description` clob,
  `type` char(1) default NULL,
  `icon` varchar(200) default NULL,
  `use_items_icons` char(1) DEFAULT 'n' NOT NULL,
  PRIMARY KEY (`menuId`)
) ENGINE=MyISAM  ;


INSERT INTO "tiki_menus" ("menuId","name","description","type") VALUES ('42','Application menu','Main extensive navigation menu','d');


DROP TABLE `tiki_minical_events`;

CREATE TABLE `tiki_minical_events` (
  `user` varchar(200) default '',
  `eventId` number(12) NOT NULL auto_increment,
  `title` varchar(250) default NULL,
  `description` clob,
  `start` number(14) default NULL,
  `end` number(14) default NULL,
  `security` char(1) default NULL,
  `duration` number(3) default NULL,
  `topicId` number(12) default NULL,
  `reminded` char(1) default NULL,
  PRIMARY KEY (`eventId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_minical_topics`;

CREATE TABLE `tiki_minical_topics` (
  `user` varchar(200) default '',
  `topicId` number(12) NOT NULL auto_increment,
  `name` varchar(250) default NULL,
  `filename` varchar(200) default NULL,
  `filetype` varchar(200) default NULL,
  `filesize` varchar(200) default NULL,
  `data` blob,
  `path` varchar(250) default NULL,
  `isIcon` char(1) default NULL,
  PRIMARY KEY (`topicId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_modules`;

CREATE TABLE `tiki_modules` (
  `moduleId` number(8) NOT NULL auto_increment,
  `name` varchar(200) default '' NOT NULL,
  `position` char(1) default NULL,
  `ord` number(4) default NULL,
  `type` char(1) default NULL,
  `title` varchar(255) default NULL,
  `cache_time` number(14) default NULL,
  `rows` number(4) default NULL,
  `params` varchar(255) default NULL,
  `groups` clob,
  PRIMARY KEY (`name`(100), `position`, `ord`, `params`(140)),
  KEY `positionType` (position, type),
  KEY `moduleId` (moduleId)
) ENGINE=MyISAM;


INSERT INTO "tiki_modules" ("name","position","ord","cache_time","params","groups") VALUES ('mnu_application_menu','l',30,0,'flip=y','a:1:{i:0;s:10:"Registered";}');


DROP TABLE `tiki_newsletter_subscriptions`;

CREATE TABLE `tiki_newsletter_subscriptions` (
  `nlId` number(12) default '0' NOT NULL,
  `email` varchar(255) default '' NOT NULL,
  `code` varchar(32) default NULL,
  `valid` char(1) default NULL,
  `subscribed` number(14) default NULL,
  `isUser` char(1) default 'n' NOT NULL,
  `included` char(1) default 'n' NOT NULL,
  PRIMARY KEY (`nlId`,`email`,`isUser`)
) ENGINE=MyISAM;


DROP TABLE `tiki_newsletter_groups`;

CREATE TABLE `tiki_newsletter_groups` (
  `nlId` number(12) default '0' NOT NULL,
  `groupName` varchar(255) default '' NOT NULL,
  `code` varchar(32) default NULL,
  PRIMARY KEY (`nlId`,`groupName`)
) ENGINE=MyISAM;


DROP TABLE `tiki_newsletter_included`;

CREATE TABLE `tiki_newsletter_included` (
  `nlId` number(12) default '0' NOT NULL,
  `includedId` number(12) default '0' NOT NULL,
  PRIMARY KEY (`nlId`,`includedId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_newsletters`;

CREATE TABLE `tiki_newsletters` (
  `nlId` number(12) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `description` clob,
  `created` number(14) default NULL,
  `lastSent` number(14) default NULL,
  `editions` number(10) default NULL,
  `users` number(10) default NULL,
  `allowUserSub` char(1) default 'y',
  `allowAnySub` char(1) default NULL,
  `unsubMsg` char(1) default 'y',
  `validateAddr` char(1) default 'y',
  `frequency` number(14) default NULL,
  `allowTxt` char(1) default 'y',
  `author` varchar(200) default NULL,
  PRIMARY KEY (`nlId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_page_footnotes`;

CREATE TABLE `tiki_page_footnotes` (
  `user` varchar(200) default '' NOT NULL,
  `pageName` varchar(250) default '' NOT NULL,
  `data` clob,
  PRIMARY KEY (`user`(150),pageName(100))
) ENGINE=MyISAM;


DROP TABLE `tiki_pages`;

CREATE TABLE `tiki_pages` (
  `page_id` number(14) NOT NULL auto_increment,
  `pageName` varchar(160) default '' NOT NULL,
  `hits` number(8) default NULL,
  `data` mediumtext,
  `description` varchar(200) default NULL,
  `lastModif` number(14) default NULL,
  `comment` varchar(200) default NULL,
  `version` number(8) default '0' NOT NULL,
  `user` varchar(200) default '',
  `ip` varchar(15) default NULL,
  `flag` char(1) default NULL,
  `points` number(8) default NULL,
  `votes` number(8) default NULL,
  `cache` longtext,
  `wiki_cache` number(10) default NULL,
  `cache_timestamp` number(14) default NULL,
  `pageRank` decimal(4,3) default NULL,
  `creator` varchar(200) default NULL,
  `page_size` number(10) default '0',
  `lang` varchar(16) default NULL,
  `lockedby` varchar(200) default NULL,
  `is_html` number(1) default 0,
  `created` number(14),
  `wysiwyg` char(1) default NULL,
  `wiki_authors_style` varchar(20) default '',
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `pageName` (pageName),
  KEY `data` (data(255)),
  KEY `pageRank` (pageRank),
  FULLTEXT KEY `ft` (pageName,description,data),
  KEY `lastModif`(lastModif)
) ENGINE=MyISAM ;


DROP TABLE `tiki_page_drafts`;

CREATE TABLE `tiki_page_drafts` (
  `user` varchar(200) default '',
  `pageName` varchar(255) NOT NULL,
  `data` mediumtext,
  `description` varchar(200) default NULL,
  `comment` varchar(200) default NULL,
  `lastModif` number(14) default NULL,
  PRIMARY KEY (`pageName`(120), `user`(120))
) ENGINE=MyISAM;


DROP TABLE `tiki_pageviews`;

CREATE TABLE `tiki_pageviews` (
  `day` number(14) default '0' NOT NULL,
  `pageviews` number(14) default NULL,
  PRIMARY KEY (`day`)
) ENGINE=MyISAM;


DROP TABLE `tiki_poll_objects`;

CREATE TABLE `tiki_poll_objects` (
  `catObjectId` number(11) default '0' NOT NULL,
  `pollId` number(11) default '0' NOT NULL,
  `title` varchar(255) default NULL,
  PRIMARY KEY (`catObjectId`,`pollId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_poll_options`;

CREATE TABLE `tiki_poll_options` (
  `pollId` number(8) default '0' NOT NULL,
  `optionId` number(8) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `position` number(4) default '0' NOT NULL,
  `votes` number(8) default NULL,
  PRIMARY KEY (`optionId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_polls`;

CREATE TABLE `tiki_polls` (
  `pollId` number(8) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `votes` number(8) default NULL,
  `active` char(1) default NULL,
  `publishDate` number(14) default NULL,
  `voteConsiderationSpan` number(4) default 0,
  PRIMARY KEY (`pollId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_preferences`;

CREATE TABLE `tiki_preferences` (
  `name` varchar(40) default '' NOT NULL,
  `value` clob,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM;


DROP TABLE `tiki_private_messages`;

CREATE TABLE `tiki_private_messages` (
  `messageId` number(8) NOT NULL auto_increment,
  `toNickname` varchar(200) default '' NOT NULL,
  `poster` varchar(200) default 'anonymous' NOT NULL,
  `timestamp` number(14) default NULL,
  `received` number(1) default 0 not null,
  `message` varchar(255) default NULL,
  PRIMARY KEY (`messageId`),
  KEY (`received`),
  KEY (`timestamp`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_programmed_content`;

CREATE TABLE `tiki_programmed_content` (
  `pId` number(8) NOT NULL auto_increment,
  `contentId` number(8) default '0' NOT NULL,
  `publishDate` number(14) default '0' NOT NULL,
  `data` clob,
  PRIMARY KEY (`pId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_quiz_question_options`;

CREATE TABLE `tiki_quiz_question_options` (
  `optionId` number(10) NOT NULL auto_increment,
  `questionId` number(10) default NULL,
  `optionText` clob,
  `points` number(4) default NULL,
  PRIMARY KEY (`optionId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_quiz_questions`;

CREATE TABLE `tiki_quiz_questions` (
  `questionId` number(10) NOT NULL auto_increment,
  `quizId` number(10) default NULL,
  `question` clob,
  `position` number(4) default NULL,
  `type` char(1) default NULL,
  `maxPoints` number(4) default NULL,
  PRIMARY KEY (`questionId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_quiz_results`;

CREATE TABLE `tiki_quiz_results` (
  `resultId` number(10) NOT NULL auto_increment,
  `quizId` number(10) default NULL,
  `fromPoints` number(4) default NULL,
  `toPoints` number(4) default NULL,
  `answer` clob,
  PRIMARY KEY (`resultId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_quiz_stats`;

CREATE TABLE `tiki_quiz_stats` (
  `quizId` number(10) default '0' NOT NULL,
  `questionId` number(10) default '0' NOT NULL,
  `optionId` number(10) default '0' NOT NULL,
  `votes` number(10) default NULL,
  PRIMARY KEY (`quizId`,`questionId`,`optionId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_quiz_stats_sum`;

CREATE TABLE `tiki_quiz_stats_sum` (
  `quizId` number(10) default '0' NOT NULL,
  `quizName` varchar(255) default NULL,
  `timesTaken` number(10) default NULL,
  `avgpoints` decimal(5,2) default NULL,
  `avgavg` decimal(5,2) default NULL,
  `avgtime` decimal(5,2) default NULL,
  PRIMARY KEY (`quizId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_quizzes`;

CREATE TABLE `tiki_quizzes` (
  `quizId` number(10) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` clob,
  `canRepeat` char(1) default NULL,
  `storeResults` char(1) default NULL,
  `questionsPerPage` number(4) default NULL,
  `timeLimited` char(1) default NULL,
  `timeLimit` number(14) default NULL,
  `created` number(14) default NULL,
  `taken` number(10) default NULL,
  `immediateFeedback` char(1) default NULL,
  `showAnswers` char(1) default NULL,
  `shuffleQuestions` char(1) default NULL,
  `shuffleAnswers` char(1) default NULL,
  `publishDate` number(14) default NULL,
  `expireDate` number(14) default NULL,
  `bDeleted` char(1) default NULL,
  `nVersion` number(4) NOT NULL,
  `nAuthor` number(4) default NULL,
  `bOnline` char(1) default NULL,
  `bRandomQuestions` char(1) default NULL,
  `nRandomQuestions` number(4) default NULL,
  `bLimitQuestionsPerPage` char(1) default NULL,
  `nLimitQuestionsPerPage` number(4) default NULL,
  `bMultiSession` char(1) default NULL,
  `nCanRepeat` number(4) default NULL,
  `sGradingMethod` varchar(80) default NULL,
  `sShowScore` varchar(80) default NULL,
  `sShowCorrectAnswers` varchar(80) default NULL,
  `sPublishStats` varchar(80) default NULL,
  `bAdditionalQuestions` char(1) default NULL,
  `bForum` char(1) default NULL,
  `sForum` varchar(80) default NULL,
  `sPrologue` clob,
  `sData` clob,
  `sEpilogue` clob,
  `passingperct` number(4) default 0,
  PRIMARY KEY (`quizId`, `nVersion`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_received_articles`;

CREATE TABLE `tiki_received_articles` (
  `receivedArticleId` number(14) NOT NULL auto_increment,
  `receivedFromSite` varchar(200) default NULL,
  `receivedFromUser` varchar(200) default NULL,
  `receivedDate` number(14) default NULL,
  `title` varchar(80) default NULL,
  `authorName` varchar(60) default NULL,
  `size` number(12) default NULL,
  `useImage` char(1) default NULL,
  `image_name` varchar(80) default NULL,
  `image_type` varchar(80) default NULL,
  `image_size` number(14) default NULL,
  `image_x` number(4) default NULL,
  `image_y` number(4) default NULL,
  `image_data` blob,
  `publishDate` number(14) default NULL,
  `expireDate` number(14) default NULL,
  `created` number(14) default NULL,
  `heading` clob,
  `body` blob,
  `hash` varchar(32) default NULL,
  `author` varchar(200) default NULL,
  `type` varchar(50) default NULL,
  `rating` decimal(3,2) default NULL,
  PRIMARY KEY (`receivedArticleId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_received_pages`;

CREATE TABLE `tiki_received_pages` (
  `receivedPageId` number(14) NOT NULL auto_increment,
  `pageName` varchar(160) default '' NOT NULL,
  `data` blob,
  `description` varchar(200) default NULL,
  `comment` varchar(200) default NULL,
  `receivedFromSite` varchar(200) default NULL,
  `receivedFromUser` varchar(200) default NULL,
  `receivedDate` number(14) default NULL,
  `parent` varchar(255) default NULL,
  `position` number(3) unsigned default NULL,
  `alias` varchar(255) default NULL,
  `structureName` varchar(250) default NULL,
  `parentName` varchar(250) default NULL,
  `page_alias` varchar(250) default '',
  `pos` number(4) default NULL,
  PRIMARY KEY (`receivedPageId`),
  KEY `structureName` (structureName)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_referer_stats`;

CREATE TABLE `tiki_referer_stats` (
  `referer` varchar(255) default '' NOT NULL,
  `hits` number(10) default NULL,
  `last` number(14) default NULL,
  PRIMARY KEY (`referer`)
) ENGINE=MyISAM;


DROP TABLE `tiki_related_categories`;

CREATE TABLE `tiki_related_categories` (
  `categId` number(10) default '0' NOT NULL,
  `relatedTo` number(10) default '0' NOT NULL,
  PRIMARY KEY (`categId`,`relatedTo`)
) ENGINE=MyISAM;


DROP TABLE `tiki_rss_modules`;

CREATE TABLE `tiki_rss_modules` (
  `rssId` number(8) NOT NULL auto_increment,
  `name` varchar(30) default '' NOT NULL,
  `description` clob,
  `url` varchar(255) default '' NOT NULL,
  `refresh` number(8) default NULL,
  `lastUpdated` number(14) default NULL,
  `showTitle` char(1) default 'n',
  `showPubDate` char(1) default 'n',
  `content` blob,
  PRIMARY KEY (`rssId`),
  KEY `name` (name)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_rss_feeds`;

CREATE TABLE `tiki_rss_feeds` (
  `name` varchar(30) default '' NOT NULL,
  `rssVer` char(1) default '1' NOT NULL,
  `refresh` number(8) default '300',
  `lastUpdated` number(14) default NULL,
  `cache` blob,
  PRIMARY KEY (`name`,`rssVer`)
) ENGINE=MyISAM;


DROP TABLE `tiki_searchindex`;

CREATE TABLE "tiki_searchindex"(
  `searchword` varchar(80) default '' NOT NULL,
  `location` varchar(80) default '' NOT NULL,
  `page` varchar(255) default '' NOT NULL,
  `count` number(11) default '1' NOT NULL,
  `last_update` number(11) default '0' NOT NULL,
  PRIMARY KEY (`searchword`,`location`,`page`(80)),
  KEY `last_update` (last_update),
  KEY `location` (location(50), page(200))
) ENGINE=MyISAM;


-- LRU (last recently used) list for searching parts of words
DROP TABLE `tiki_searchsyllable`;

CREATE TABLE "tiki_searchsyllable"(
  `syllable` varchar(80) default '' NOT NULL,
  `lastUsed` number(11) default '0' NOT NULL,
  `lastUpdated` number(11) default '0' NOT NULL,
  PRIMARY KEY (`syllable`),
  KEY `lastUsed` (lastUsed)
) ENGINE=MyISAM;


-- searchword caching table for search syllables
DROP TABLE `tiki_searchwords`;

CREATE TABLE "tiki_searchwords"(
  `syllable` varchar(80) default '' NOT NULL,
  `searchword` varchar(80) default '' NOT NULL,
  PRIMARY KEY (`syllable`,`searchword`)
) ENGINE=MyISAM;


DROP TABLE `tiki_search_stats`;

CREATE TABLE `tiki_search_stats` (
  `term` varchar(50) default '' NOT NULL,
  `hits` number(10) default NULL,
  PRIMARY KEY (`term`)
) ENGINE=MyISAM;


DROP TABLE `tiki_secdb`;

CREATE TABLE "tiki_secdb"(
  `md5_value` varchar(32) NOT NULL,
  `filename` varchar(250) NOT NULL,
  `tiki_version` varchar(60) NOT NULL,
  `severity` number(4) default '0' NOT NULL,
  PRIMARY KEY (`md5_value`,`filename`(100),`tiki_version`),
  KEY `sdb_fn` (filename)
) ENGINE=MyISAM;


DROP TABLE `tiki_semaphores`;

CREATE TABLE `tiki_semaphores` (
  `semName` varchar(250) default '' NOT NULL,
  `objectType` varchar(20) default 'wiki page',
  `user` varchar(200) default '' NOT NULL,
  `timestamp` number(14) default NULL,
  PRIMARY KEY (`semName`)
) ENGINE=MyISAM;


DROP TABLE `tiki_sent_newsletters`;

CREATE TABLE `tiki_sent_newsletters` (
  `editionId` number(12) NOT NULL auto_increment,
  `nlId` number(12) default '0' NOT NULL,
  `users` number(10) default NULL,
  `sent` number(14) default NULL,
  `subject` varchar(200) default NULL,
  `data` blob,
  `datatxt` blob,
  PRIMARY KEY (`editionId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_sent_newsletters_errors`;

CREATE TABLE `tiki_sent_newsletters_errors` (
  `editionId` number(12),
  `email` varchar(255),
  `login` varchar(40) default '',
  `error` char(1) default '',
  KEY (editionId)
) ENGINE=MyISAM ;


DROP TABLE `tiki_sessions`;

CREATE TABLE `tiki_sessions` (
  `sessionId` varchar(32) default '' NOT NULL,
  `user` varchar(200) default '',
  `timestamp` number(14) default NULL,
  `tikihost` varchar(200) default NULL,
  PRIMARY KEY (`sessionId`),
  KEY `user` (user),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM;


DROP TABLE `tiki_sheet_layout`;

CREATE TABLE `tiki_sheet_layout` (
  `sheetId` number(8) default '0' NOT NULL,
  `begin` number(10) default '0' NOT NULL,
  `end` number(10) default NULL,
  `headerRow` number(4) default '0' NOT NULL,
  `footerRow` number(4) default '0' NOT NULL,
  `className` varchar(64) default NULL,
  UNIQUE KEY `sheetId` (`sheetId`, `begin`)
) ENGINE=MyISAM;


DROP TABLE `tiki_sheet_values`;

CREATE TABLE `tiki_sheet_values` (
  `sheetId` number(8) default '0' NOT NULL,
  `begin` number(10) default '0' NOT NULL,
  `end` number(10) default NULL,
  `rowIndex` number(4) default '0' NOT NULL,
  `columnIndex` number(4) default '0' NOT NULL,
  `value` varchar(255) default NULL,
  `calculation` varchar(255) default NULL,
  `width` number(4) default '1' NOT NULL,
  `height` number(4) default '1' NOT NULL,
  `format` varchar(255) default NULL,
  `user` varchar(200) default '',
  UNIQUE KEY `sheetId` (sheetId,begin,rowIndex,columnIndex),
  KEY `sheetId_2` (sheetId,rowIndex,columnIndex)
) ENGINE=MyISAM;


DROP TABLE `tiki_sheets`;

CREATE TABLE `tiki_sheets` (
  `sheetId` number(8) NOT NULL auto_increment,
  `title` varchar(200) default '' NOT NULL,
  `description` clob,
  `author` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`sheetId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_shoutbox`;

CREATE TABLE `tiki_shoutbox` (
  `msgId` number(10) NOT NULL auto_increment,
  `message` varchar(255) default NULL,
  `timestamp` number(14) default NULL,
  `user` varchar(200) NULL default '',
  `hash` varchar(32) default NULL,
  PRIMARY KEY (`msgId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_shoutbox_words`;

CREATE TABLE `tiki_shoutbox_words` (
  `word` VARCHAR( 40 ) NOT NULL ,
  `qty` INT DEFAULT '0' NOT NULL ,
  PRIMARY KEY (`word`)
) ENGINE=MyISAM;


DROP TABLE `tiki_structure_versions`;

CREATE TABLE `tiki_structure_versions` (
  `structure_id` number(14) NOT NULL auto_increment,
  `version` number(14) default NULL,
  PRIMARY KEY (`structure_id`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_structures`;

CREATE TABLE `tiki_structures` (
  `page_ref_id` number(14) NOT NULL auto_increment,
  `structure_id` number(14) NOT NULL,
  `parent_id` number(14) default NULL,
  `page_id` number(14) NOT NULL,
  `page_version` number(8) default NULL,
  `page_alias` varchar(240) default '' NOT NULL,
  `pos` number(4) default NULL,
  PRIMARY KEY (`page_ref_id`),
  KEY `pidpaid` (page_id,parent_id),
  KEY `page_id` (page_id)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_submissions`;

CREATE TABLE `tiki_submissions` (
  `subId` number(8) NOT NULL auto_increment,
  `topline` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `subtitle` varchar(255) default NULL,
  `linkto` varchar(255) default NULL,
  `lang` varchar(16) default NULL,
  `authorName` varchar(60) default NULL,
  `topicId` number(14) default NULL,
  `topicName` varchar(40) default NULL,
  `size` number(12) default NULL,
  `useImage` char(1) default NULL,
  `image_name` varchar(80) default NULL,
  `image_caption` clob default NULL,
  `image_type` varchar(80) default NULL,
  `image_size` number(14) default NULL,
  `image_x` number(4) default NULL,
  `image_y` number(4) default NULL,
  `image_data` blob,
  `publishDate` number(14) default NULL,
  `expireDate` number(14) default NULL,
  `created` number(14) default NULL,
  `bibliographical_references` clob,
  `resume` clob,
  `heading` clob,
  `body` clob,
  `hash` varchar(32) default NULL,
  `author` varchar(200) default '' NOT NULL,
  `nbreads` number(14) default NULL,
  `votes` number(8) default NULL,
  `points` number(14) default NULL,
  `type` varchar(50) default NULL,
  `rating` decimal(3,2) default NULL,
  `isfloat` char(1) default NULL,
  PRIMARY KEY (`subId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_suggested_faq_questions`;

CREATE TABLE `tiki_suggested_faq_questions` (
  `sfqId` number(10) NOT NULL auto_increment,
  `faqId` number(10) default '0' NOT NULL,
  `question` clob,
  `answer` clob,
  `created` number(14) default NULL,
  `user` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`sfqId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_survey_question_options`;

CREATE TABLE `tiki_survey_question_options` (
  `optionId` number(12) NOT NULL auto_increment,
  `questionId` number(12) default '0' NOT NULL,
  `qoption` clob,
  `votes` number(10) default NULL,
  PRIMARY KEY (`optionId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_survey_questions`;

CREATE TABLE `tiki_survey_questions` (
  `questionId` number(12) NOT NULL auto_increment,
  `surveyId` number(12) default '0' NOT NULL,
  `question` clob,
  `options` clob,
  `type` char(1) default NULL,
  `position` number(5) default NULL,
  `votes` number(10) default NULL,
  `value` number(10) default NULL,
  `average` decimal(4,2) default NULL,
  `mandatory` char(1) default 'n' NOT NULL,
  `max_answers` number(5) default 0 NOT NULL,
  `min_answers` number(5) default 0 NOT NULL,
  PRIMARY KEY (`questionId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_surveys`;

CREATE TABLE `tiki_surveys` (
  `surveyId` number(12) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `description` clob,
  `taken` number(10) default NULL,
  `lastTaken` number(14) default NULL,
  `created` number(14) default NULL,
  `status` char(1) default NULL,
  PRIMARY KEY (`surveyId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_tags`;

CREATE TABLE `tiki_tags` (
  `tagName` varchar(80) default '' NOT NULL,
  `pageName` varchar(160) default '' NOT NULL,
  `hits` number(8) default NULL,
  `description` varchar(200) default NULL,
  `data` blob,
  `lastModif` number(14) default NULL,
  `comment` varchar(200) default NULL,
  `version` number(8) default '0' NOT NULL,
  `user` varchar(200) default '' NOT NULL,
  `ip` varchar(15) default NULL,
  `flag` char(1) default NULL,
  PRIMARY KEY (`tagName`,`pageName`)
) ENGINE=MyISAM;


DROP TABLE `tiki_theme_control_categs`;

CREATE TABLE `tiki_theme_control_categs` (
  `categId` number(12) default '0' NOT NULL,
  `theme` varchar(250) default '' NOT NULL,
  PRIMARY KEY (`categId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_theme_control_objects`;

CREATE TABLE `tiki_theme_control_objects` (
  `objId` varchar(250) default '' NOT NULL,
  `type` varchar(250) default '' NOT NULL,
  `name` varchar(250) default '' NOT NULL,
  `theme` varchar(250) default '' NOT NULL,
  PRIMARY KEY (`objId`(100), `type`(100))
) ENGINE=MyISAM;


DROP TABLE `tiki_theme_control_sections`;

CREATE TABLE `tiki_theme_control_sections` (
  `section` varchar(250) default '' NOT NULL,
  `theme` varchar(250) default '' NOT NULL,
  PRIMARY KEY (`section`)
) ENGINE=MyISAM;


DROP TABLE `tiki_topics`;

CREATE TABLE `tiki_topics` (
  `topicId` number(14) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `image_name` varchar(80) default NULL,
  `image_type` varchar(80) default NULL,
  `image_size` number(14) default NULL,
  `image_data` blob,
  `active` char(1) default NULL,
  `created` number(14) default NULL,
  PRIMARY KEY (`topicId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_tracker_fields`;

CREATE TABLE `tiki_tracker_fields` (
  `fieldId` number(12) NOT NULL auto_increment,
  `trackerId` number(12) default '0' NOT NULL,
  `name` varchar(255) default NULL,
  `options` clob,
  `type` varchar(15) default NULL,
  `isMain` char(1) default NULL,
  `isTblVisible` char(1) default NULL,
  `position` number(4) default NULL,
  `isSearchable` char(1) default 'y' NOT NULL,
  `isPublic` char(1) default 'n' NOT NULL,
  `isHidden` char(1) default 'n' NOT NULL,
  `isMandatory` char(1) default 'n' NOT NULL,
  `description` clob,
  `isMultilingual` char(1) default 'n',
  `itemChoices` clob,
  `errorMsg` clob,
  `visibleBy` clob,
  `editableBy` clob,
  `descriptionIsParsed` char(1) default 'n',
  PRIMARY KEY (`fieldId`),
  "INDEX" trackerId (trackerId)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_tracker_item_attachments`;

CREATE TABLE `tiki_tracker_item_attachments` (
  `attId` number(12) NOT NULL auto_increment,
  `itemId` number(12) default 0 NOT NULL,
  `filename` varchar(80) default NULL,
  `filetype` varchar(80) default NULL,
  `filesize` number(14) default NULL,
  `user` varchar(200) default NULL,
  `data` blob,
  `path` varchar(255) default NULL,
  `hits` number(10) default NULL,
  `created` number(14) default NULL,
  `comment` varchar(250) default NULL,
  `longdesc` blob,
  `version` varchar(40) default NULL,
  PRIMARY KEY (`attId`),
  "INDEX" itemId (itemId)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_tracker_item_comments`;

CREATE TABLE `tiki_tracker_item_comments` (
  `commentId` number(12) NOT NULL auto_increment,
  `itemId` number(12) default '0' NOT NULL,
  `user` varchar(200) default NULL,
  `data` clob,
  `title` varchar(200) default NULL,
  `posted` number(14) default NULL,
  PRIMARY KEY (`commentId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_tracker_item_fields`;

CREATE TABLE `tiki_tracker_item_fields` (
  `itemId` number(12) default '0' NOT NULL,
  `fieldId` number(12) default '0' NOT NULL,
  `value` clob,
  `lang` char(16) default NULL,
  PRIMARY KEY (`itemId`,`fieldId`,`lang`),
  "INDEX" fieldId (fieldId),
  "INDEX" value (value(250)),
  "INDEX" lang (lang),
  FULLTEXT KEY `ft` (value)
) ENGINE=MyISAM;


DROP TABLE `tiki_tracker_items`;

CREATE TABLE `tiki_tracker_items` (
  `itemId` number(12) NOT NULL auto_increment,
  `trackerId` number(12) default '0' NOT NULL,
  `created` number(14) default NULL,
  `status` char(1) default NULL,
  `lastModif` number(14) default NULL,
  PRIMARY KEY (`itemId`),
  "INDEX" trackerId (trackerId)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_tracker_options`;

CREATE TABLE `tiki_tracker_options` (
  `trackerId` number(12) default '0' NOT NULL,
  `name` varchar(80) default '' NOT NULL,
  `value` clob default NULL,
  PRIMARY KEY (`trackerId`,`name`(30))
) ENGINE=MyISAM ;


DROP TABLE `tiki_trackers`;

CREATE TABLE `tiki_trackers` (
  `trackerId` number(12) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` clob,
  `descriptionIsParsed` varchar(1) NULL default '0',
  `created` number(14) default NULL,
  `lastModif` number(14) default NULL,
  `showCreated` char(1) default NULL,
  `showStatus` char(1) default NULL,
  `showLastModif` char(1) default NULL,
  `useComments` char(1) default NULL,
  `useAttachments` char(1) default NULL,
  `showAttachments` char(1) default NULL,
  `items` number(10) default NULL,
  `showComments` char(1) default NULL,
  `orderAttachments` varchar(255) default 'filename,created,filesize,hits,desc' NOT NULL,
  PRIMARY KEY (`trackerId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_untranslated`;

CREATE TABLE `tiki_untranslated` (
  `id` number(14) NOT NULL auto_increment,
  `source` blob NOT NULL,
  `lang` char(16) default '' NOT NULL,
  PRIMARY KEY (`source`(255),`lang`),
  UNIQUE KEY `id` (id),
  KEY `id_2` (id)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_answers`;

CREATE TABLE `tiki_user_answers` (
  `userResultId` number(10) default '0' NOT NULL,
  `quizId` number(10) default '0' NOT NULL,
  `questionId` number(10) default '0' NOT NULL,
  `optionId` number(10) default '0' NOT NULL,
  PRIMARY KEY (`userResultId`,`quizId`,`questionId`,`optionId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_answers_uploads`;

CREATE TABLE `tiki_user_answers_uploads` (
  `answerUploadId` number(4) NOT NULL auto_increment,
  `userResultId` number(11) default '0' NOT NULL,
  `questionId` number(11) default '0' NOT NULL,
  `filename` varchar(255) default '' NOT NULL,
  `filetype` varchar(64) default '' NOT NULL,
  `filesize` varchar(255) default '' NOT NULL,
  `filecontent` blob NOT NULL,
  PRIMARY KEY (`answerUploadId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_assigned_modules`;

CREATE TABLE `tiki_user_assigned_modules` (
  `moduleId` number(8) NOT NULL,
  `name` varchar(200) default '' NOT NULL,
  `position` char(1) default NULL,
  `ord` number(4) default NULL,
  `type` char(1) default NULL,
  `user` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`name`(30),`user`,`position`, `ord`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_bookmarks_folders`;

CREATE TABLE `tiki_user_bookmarks_folders` (
  `folderId` number(12) NOT NULL auto_increment,
  `parentId` number(12) default NULL,
  `user` varchar(200) default '' NOT NULL,
  `name` varchar(30) default NULL,
  PRIMARY KEY (`user`,`folderId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_bookmarks_urls`;

CREATE TABLE `tiki_user_bookmarks_urls` (
  `urlId` number(12) NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `url` varchar(250) default NULL,
  `data` blob,
  `lastUpdated` number(14) default NULL,
  `folderId` number(12) default '0' NOT NULL,
  `user` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`urlId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_mail_accounts`;

CREATE TABLE `tiki_user_mail_accounts` (
  `accountId` number(12) NOT NULL auto_increment,
  `user` varchar(200) default '' NOT NULL,
  `account` varchar(50) default '' NOT NULL,
  `pop` varchar(255) default NULL,
  `current` char(1) default NULL,
  `port` number(4) default NULL,
  `username` varchar(100) default NULL,
  `pass` varchar(100) default NULL,
  `msgs` number(4) default NULL,
  `smtp` varchar(255) default NULL,
  `useAuth` char(1) default NULL,
  `smtpPort` number(4) default NULL,
  `flagsPublic` char(1) default 'n',				-- COMMENT 'MatWho - Shared Group Mail box if y',
  `autoRefresh` number(4) default 0,		-- COMMENT 'seconds for mail list to refresh, 0 = none' NOT NULL,
  `imap` varchar( 255 ) default NULL,
  `mbox` varchar( 255 ) default NULL,
  `maildir` varchar( 255 ) default NULL,
  `useSSL` char( 1 ) default 'n' NOT NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_menus`;

CREATE TABLE `tiki_user_menus` (
  `user` varchar(200) default '' NOT NULL,
  `menuId` number(12) NOT NULL auto_increment,
  `url` varchar(250) default NULL,
  `name` varchar(40) default NULL,
  `position` number(4) default NULL,
  `mode` char(1) default NULL,
  PRIMARY KEY (`menuId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_modules`;

CREATE TABLE `tiki_user_modules` (
  `name` varchar(200) default '' NOT NULL,
  `title` varchar(40) default NULL,
  `data` blob,
  `parse` char(1) default NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM;


INSERT INTO "tiki_user_modules" ("name","title","data","parse") VALUES ('mnu_application_menu', 'Menu', '{menu id=42}', 'n');


DROP TABLE `tiki_user_notes`;

CREATE TABLE `tiki_user_notes` (
  `user` varchar(200) default '' NOT NULL,
  `noteId` number(12) NOT NULL auto_increment,
  `created` number(14) default NULL,
  `name` varchar(255) default NULL,
  `lastModif` number(14) default NULL,
  `data` clob,
  `size` number(14) default NULL,
  `parse_mode` varchar(20) default NULL,
  PRIMARY KEY (`noteId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_postings`;

CREATE TABLE `tiki_user_postings` (
  `user` varchar(200) default '' NOT NULL,
  `posts` number(12) default NULL,
  `last` number(14) default NULL,
  `first` number(14) default NULL,
  `level` number(8) default NULL,
  PRIMARY KEY (`user`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_preferences`;

CREATE TABLE `tiki_user_preferences` (
  `user` varchar(200) default '' NOT NULL,
  `prefName` varchar(40) default '' NOT NULL,
  `value` varchar(250) default NULL,
  PRIMARY KEY (`user`,`prefName`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_quizzes`;

CREATE TABLE `tiki_user_quizzes` (
  `user` varchar(200) default '',
  `quizId` number(10) default NULL,
  `timestamp` number(14) default NULL,
  `timeTaken` number(14) default NULL,
  `points` number(12) default NULL,
  `maxPoints` number(12) default NULL,
  `resultId` number(10) default NULL,
  `userResultId` number(10) NOT NULL auto_increment,
  PRIMARY KEY (`userResultId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_taken_quizzes`;

CREATE TABLE `tiki_user_taken_quizzes` (
  `user` varchar(200) default '' NOT NULL,
  `quizId` varchar(255) default '' NOT NULL,
  PRIMARY KEY (`user`,`quizId`(50))
) ENGINE=MyISAM;


DROP TABLE `tiki_user_tasks_history`;

CREATE TABLE `tiki_user_tasks_history` (
  `belongs_to` integer(14) NOT NULL,                   -- the first task in a history it has the same id as the task id
  `task_version` integer(4) DEFAULT 0 NOT NULL,        -- version number for the history it starts with 0
  `title` varchar(250) NOT NULL,                       -- title
  `description` clob DEFAULT NULL,                     -- description
  `start` integer(14) DEFAULT NULL,                    -- date of the starting, if it is not set than there is no starting date
  `end` integer(14) DEFAULT NULL,                      -- date of the end, if it is not set than there is not dealine
  `lasteditor` varchar(200) NOT NULL,                  -- lasteditor: username of last editior
  `lastchanges` integer(14) NOT NULL,                  -- date of last changes
  `priority` integer(2) DEFAULT 3 NOT NULL,                     -- priority
  `completed` integer(14) DEFAULT NULL,                -- date of the completation if it is null it is not yet completed
  `deleted` integer(14) DEFAULT NULL,                  -- date of the deleteation it it is null it is not deleted
  `status` char(1) DEFAULT NULL,                       -- null := waiting, o := open / in progress, c := completed -> (percentage = 100)
  `percentage` number(4) DEFAULT NULL,
  `accepted_creator` char(1) DEFAULT NULL,             -- y - yes, n - no, null - waiting
  `accepted_user` char(1) DEFAULT NULL,                -- y - yes, n - no, null - waiting
  PRIMARY KEY (`belongs_to`, `task_version`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_user_tasks`;

CREATE TABLE `tiki_user_tasks` (
  `taskId` integer(14) NOT NULL auto_increment,        -- task id
  `last_version` integer(4) DEFAULT 0 NOT NULL,        -- last version of the task starting with 0
  `user` varchar(200) DEFAULT '' NOT NULL,              -- task user
  `creator` varchar(200) NOT NULL,                     -- username of creator
  `public_for_group` varchar(30) DEFAULT NULL,         -- this group can also view the task, if it is null it is not public
  `rights_by_creator` char(1) DEFAULT NULL,            -- null the user can delete the task,
  `created` integer(14) NOT NULL,                      -- date of the creation
  `status` char(1) default NULL,
  `priority` number(2) default NULL,
  `completed` number(14) default NULL,
  `percentage` number(4) default NULL,
  PRIMARY KEY (`taskId`),
  UNIQUE(creator, created)
) ENGINE=MyISAM ;


DROP TABLE `tiki_user_votings`;

CREATE TABLE `tiki_user_votings` (
  `user` varchar(200) default '',
  `ip` varchar(15) default NULL,
  `id` varchar(255) default '' NOT NULL,
  `optionId` number(10) default 0 NOT NULL,
  `time` number(14) default 0 NOT NULL,
  KEY (`user`(100),id(100)),
  KEY `ip` (`ip`),
  KEY `id` (`id`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_watches`;

CREATE TABLE `tiki_user_watches` (
  `watchId` number(12) NOT NULL auto_increment,
  `user` varchar(200) default '' NOT NULL,
  `event` varchar(40) default '' NOT NULL,
  `object` varchar(200) default '' NOT NULL,
  `title` varchar(250) default NULL,
  `type` varchar(200) default NULL,
  `url` varchar(250) default NULL,
  `email` varchar(200) default NULL,
  KEY `watchId` (watchId),
  PRIMARY KEY (`user`(50),event,object(100),email(50))
) ENGINE=MyISAM;


DROP TABLE `tiki_userfiles`;

CREATE TABLE `tiki_userfiles` (
  `user` varchar(200) default '' NOT NULL,
  `fileId` number(12) NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  `filename` varchar(200) default NULL,
  `filetype` varchar(200) default NULL,
  `filesize` varchar(200) default NULL,
  `data` blob,
  `hits` number(8) default NULL,
  `isFile` char(1) default NULL,
  `path` varchar(255) default NULL,
  `created` number(14) default NULL,
  PRIMARY KEY (`fileId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_userpoints`;

CREATE TABLE `tiki_userpoints` (
  `user` varchar(200) default '' NOT NULL,
  `points` decimal(8,2) default NULL,
  `voted` number(8) default NULL
) ENGINE=MyISAM;


DROP TABLE `tiki_users`;

CREATE TABLE `tiki_users` (
  `user` varchar(200) default '' NOT NULL,
  `password` varchar(40) default NULL,
  `email` varchar(200) default NULL,
  `lastLogin` number(14) default NULL,
  PRIMARY KEY (`user`)
) ENGINE=MyISAM;


DROP TABLE `tiki_webmail_contacts`;

CREATE TABLE `tiki_webmail_contacts` (
  `contactId` number(12) NOT NULL auto_increment,
  `firstName` varchar(80) default NULL,
  `lastName` varchar(80) default NULL,
  `email` varchar(250) default NULL,
  `nickname` varchar(200) default NULL,
  `user` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`contactId`)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_webmail_contacts_groups`;

CREATE TABLE `tiki_webmail_contacts_groups` (
  `contactId` number(12) NOT NULL,
  `groupName` varchar(255) NOT NULL,
  PRIMARY KEY (`contactId`,`groupName`(200))
) ENGINE=MyISAM ;


DROP TABLE `tiki_webmail_messages`;

CREATE TABLE `tiki_webmail_messages` (
  `accountId` number(12) default '0' NOT NULL,
  `mailId` varchar(255) default '' NOT NULL,
  `user` varchar(200) default '' NOT NULL,
  `isRead` char(1) default NULL,
  `isReplied` char(1) default NULL,
  `isFlagged` char(1) default NULL,
  `flaggedMsg` varchar(50) default '',
  PRIMARY KEY (`accountId`,`mailId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_wiki_attachments`;

CREATE TABLE `tiki_wiki_attachments` (
  `attId` number(12) NOT NULL auto_increment,
  `page` varchar(200) default '' NOT NULL,
  `filename` varchar(80) default NULL,
  `filetype` varchar(80) default NULL,
  `filesize` number(14) default NULL,
  `user` varchar(200) default '' NOT NULL,
  `data` blob,
  `path` varchar(255) default NULL,
  `hits` number(10) default NULL,
  `created` number(14) default NULL,
  `comment` varchar(250) default NULL,
  PRIMARY KEY (`attId`),
  KEY `page` (page)
) ENGINE=MyISAM  ;


DROP TABLE `tiki_zones`;

CREATE TABLE `tiki_zones` (
  `zone` varchar(40) default '' NOT NULL,
  PRIMARY KEY (`zone`)
) ENGINE=MyISAM;


DROP TABLE `tiki_download`;

CREATE TABLE `tiki_download` (
  `id` number(11) NOT NULL auto_increment,
  `object` varchar(255) default '' NOT NULL,
  `userId` number(8) default '0' NOT NULL,
  `type` varchar(20) default '' NOT NULL,
  `date` number(14) default '0' NOT NULL,
  `IP` varchar(50) default '' NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object` (object,userId,type),
  KEY `userId` (userId),
  KEY `type` (type),
  KEY `date` (date)
) ENGINE=MyISAM;


DROP TABLE `users_grouppermissions`;

CREATE TABLE `users_grouppermissions` (
  `groupName` varchar(255) default '' NOT NULL,
  `permName` varchar(40) default '' NOT NULL,
  `value` char(1) default '',
  PRIMARY KEY (`groupName`(30),`permName`)
) ENGINE=MyISAM;


INSERT INTO users_grouppermissions (groupName,permName) VALUES('Anonymous','tiki_p_view');


DROP TABLE `users_groups`;

CREATE TABLE `users_groups` (
  `id` number(11) NOT NULL auto_increment,
  `groupName` varchar(255) default '' NOT NULL,
  `groupDesc` varchar(255) default NULL,
  `groupHome` varchar(255),
  `usersTrackerId` number(11),
  `groupTrackerId` number(11),
  `usersFieldId` number(11),
  `groupFieldId` number(11),
  `registrationChoice` char(1) default NULL,
  `registrationUsersFieldIds` clob,
  `userChoice` char(1) default NULL,
  `groupDefCat` number(12) default 0,
  `groupTheme` varchar(255) default '',
  `isExternal` char(1) default 'n',
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupName` (groupName)
) ENGINE=MyISAM ;


DROP TABLE `users_objectpermissions`;

CREATE TABLE `users_objectpermissions` (
  `groupName` varchar(255) default '' NOT NULL,
  `permName` varchar(40) default '' NOT NULL,
  `objectType` varchar(20) default '' NOT NULL,
  `objectId` varchar(32) default '' NOT NULL,
  PRIMARY KEY (`objectId`, `objectType`, `groupName`(30),`permName`)
) ENGINE=MyISAM;


DROP TABLE `users_permissions`;

CREATE TABLE `users_permissions` (
  `permName` varchar(40) default '' NOT NULL,
  `permDesc` varchar(250) default NULL,
  `level` varchar(80) default NULL,
  `type` varchar(20) default NULL,
  `admin` varchar(1) default NULL,
  `feature_default NULL check` varchar(255),
  PRIMARY KEY ("`permName`")
  KEY `type` (`type`)
) ENGINE=MyISAM;


INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_calendar', 'Can create/admin calendars', 'admin', 'calendar', 'y', 'feature_calendar');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_add_events', 'Can add events in the calendar', 'registered', 'calendar', NULL, 'feature_calendar');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_change_events', 'Can change events in the calendar', 'registered', 'calendar', NULL, 'feature_calendar');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_calendar', 'Can browse the calendar', 'basic', 'calendar', NULL, 'feature_calendar');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_events', 'Can view events details', 'registered', 'calendar', NULL, 'feature_calendar');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_tiki_calendar', 'Can view Tikiwiki tools calendar', 'basic', 'calendar', NULL, 'feature_calendar');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_chat', 'Administrator, can create channels remove channels etc', 'editors', 'chat', 'y', 'feature_minichat,feature_live_support');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_chat', 'Can use the chat system', 'registered', 'chat', NULL, 'feature_minichat,feature_live_support');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_cms', 'Can admin the cms', 'editors', 'cms', 'y', 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_approve_submission', 'Can approve submissions', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_articles_admin_topics', 'Can admin article topics', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_articles_admin_types', 'Can admin article types', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_articles_read_heading', 'Can read article headings', 'basic', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_autoapprove_submission', 'Submited articles automatically approved', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_article', 'Can edit articles', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_submission', 'Can edit submissions', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_read_article', 'Can read articles', 'basic', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_remove_article', 'Can remove articles', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_remove_submission', 'Can remove submissions', 'editors', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_submit_article', 'Can submit articles', 'basic', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_topic_read', 'Can read a topic (Applies only to individual topic perms)', 'basic', 'cms', NULL, 'feature_articles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_contribution', 'Can admin contributions', 'admin', 'contribution', 'y', 'feature_contribution');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_directory', 'Can admin the directory', 'editors', 'directory', 'y', 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_directory_cats', 'Can admin directory categories', 'editors', 'directory', NULL, 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_directory_sites', 'Can admin directory sites', 'editors', 'directory', NULL, 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_autosubmit_link', 'Submited links are valid', 'editors', 'directory', NULL, 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_submit_link', 'Can submit sites to the directory', 'basic', 'directory', NULL, 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_validate_links', 'Can validate submited links', 'editors', 'directory', NULL, 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_directory', 'Can use the directory', 'basic', 'directory', NULL, 'feature_directory');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_faqs', 'Can admin faqs', 'editors', 'faqs', 'y', 'feature_faqs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_suggest_faq', 'Can suggest faq questions', 'basic', 'faqs', NULL, 'feature_faqs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_faqs', 'Can view faqs', 'basic', 'faqs', NULL, 'feature_faqs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin', 'Administrator, can manage users groups and permissions, Hotwords and all the weblog features', 'admin', 'tiki', 'y', NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_users', 'Can admin users', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_access_closed_site', 'Can access site when closed', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_banners', 'Administrator, can admin banners', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_banning', 'Can ban users or ips', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_dynamic', 'Can admin the dynamic content system', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_integrator', 'Can admin integrator repositories and rules', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_mailin', 'Can admin mail-in accounts', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_objects', 'Can edit object permissions', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_rssmodules', 'Can admin rss modules', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_clean_cache', 'Can clean cache', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_css', 'Can create new css suffixed with -user', 'registered', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_detach_translation', 'Can remove association between two pages in a translation set', 'registered', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_cookies', 'Can admin cookies', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_languages', 'Can edit translations and create new languages', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_menu', 'Can edit menu', 'admin', 'menus', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_menu_option', 'Can edit menu option', 'admin', 'menus', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_templates', 'Can edit site templates', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_search', 'Can search', 'basic', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_site_report', 'Can report a link to the webmaster', 'basic', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_subscribe_groups', 'Can subscribe to groups', 'registered', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tell_a_friend', 'Can send a link to a friend', 'Basic', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_HTML', 'Can use HTML in pages', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_actionlog', 'Can view action log', 'registered', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_actionlog_owngroups', 'Can view action log for users of his own groups', 'registered', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_integrator', 'Can view integrated repositories', 'basic', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_referer_stats', 'Can view referer stats', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_stats', 'Can view site stats', 'basic', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_templates', 'Can view site templates', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_blog_admin', 'Can admin blogs', 'editors', 'blogs', 'y', 'feature_blogs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_assign_perm_blog', 'Can assign perms to blog', 'admin', 'blogs', NULL, 'feature_blogs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_blog_post', 'Can post to a blog', 'registered', 'blogs', NULL, 'feature_blogs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_blogs', 'Can create a blog', 'editors', 'blogs', NULL, 'feature_blogs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_read_blog', 'Can read blogs', 'basic', 'blogs', NULL, 'feature_blogs');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_file_galleries', 'Can admin file galleries', 'editors', 'file galleries', 'y', 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_assign_perm_file_gallery', 'Can assign perms to file gallery', 'admin', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_batch_upload_file_dir', 'Can use Directory Batch Load', 'editors', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_batch_upload_files', 'Can upload zip files with files', 'editors', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_file_galleries', 'Can create file galleries', 'editors', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_download_files', 'Can download files', 'basic', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_gallery_file', 'Can edit a gallery file', 'editors', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_list_file_galleries', 'Can list file galleries', 'basic', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_upload_files', 'Can upload files', 'registered', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_fgal_explorer', 'Can view file galleries explorer', 'basic', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_fgal_path', 'Can view file galleries path', 'basic', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_file_gallery', 'Can view file galleries', 'basic', 'file galleries', NULL, 'feature_file_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_forum', 'Can admin forums', 'editors', 'forums', 'y', 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_attach', 'Can attach to forum posts', 'registered', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_autoapp', 'Auto approve forum posts', 'editors', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_edit_own_posts', 'Can edit own forum posts', 'registered', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_post', 'Can post in forums', 'registered', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_post_topic', 'Can start threads in forums', 'registered', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_read', 'Can read forums', 'basic', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forums_report', 'Can report msgs to moderator', 'registered', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_forum_vote', 'Can vote comments in forums', 'registered', 'forums', NULL, 'feature_forums');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_freetags', 'Can admin freetags', 'admin', 'freetags', 'y', 'feature_freetags');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_galleries', 'Can admin Image Galleries', 'editors', 'image galleries', 'y', 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_assign_perm_image_gallery', 'Can assign perms to image gallery', 'admin', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_batch_upload_image_dir', 'Can use Directory Batch Load', 'editors', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_batch_upload_images', 'Can upload zip files with images', 'editors', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_galleries', 'Can create image galleries', 'editors', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_freetags_tag', 'Can tag objects', 'registered', 'freetags', NULL, 'feature_freetags');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_list_image_galleries', 'Can list image galleries', 'basic', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_unassign_freetags', 'Can unassign tags from an object', 'basic', 'freetags', NULL, 'feature_freetags');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_upload_images', 'Can upload images', 'registered', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_freetags', 'Can browse freetags', 'basic', 'freetags', NULL, 'feature_freetags');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_image_gallery', 'Can view image galleries', 'basic', 'image galleries', NULL, 'feature_galleries');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_newsletters', 'Can admin newsletters', 'admin', 'newsletters', 'y', 'feature_newsletters');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_batch_subscribe_email', 'Can subscribe many e-mails at once (requires tiki_p_subscribe email)', 'editors', 'newsletters', NULL, 'feature_newsletters');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_send_newsletters', 'Can send newsletters', 'editors', 'newsletters', NULL, 'feature_newsletters');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_subscribe_email', 'Can subscribe any email to newsletters', 'editors', 'newsletters', NULL, 'feature_newsletters');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_subscribe_newsletters', 'Can subscribe to newsletters', 'basic', 'newsletters', NULL, 'feature_newsletters');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_list_newsletters', 'Can list newsletters', 'basic', 'newsletters', NULL, 'feature_newsletters');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_polls', 'Can admin polls', 'admin', 'polls', 'y', 'feature_polls');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_poll_results', 'Can view poll results', 'basic', 'polls', NULL, 'feature_polls');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_vote_poll', 'Can vote polls', 'basic', 'polls', NULL, 'feature_polls');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_poll_voters', 'Can view poll voters', 'basic', 'polls', NULL, 'feature_polls');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_quicktags', 'Can admin quicktags', 'admin', 'quicktags', 'y', NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_quizzes', 'Can admin quizzes', 'editors', 'quizzes', 'y', 'feature_quizzes');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_take_quiz', 'Can take quizzes', 'basic', 'quizzes', NULL, 'feature_quizzes');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_quiz_stats', 'Can view quiz stats', 'basic', 'quizzes', NULL, 'feature_quizzes');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_user_results', 'Can view user quiz results', 'editors', 'quizzes', NULL, 'feature_quizzes');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_sheet', 'Can admin sheet', 'admin', 'sheet', 'y', 'feature_sheet');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_sheet', 'Can create and edit sheets', 'editors', 'sheet', NULL, 'feature_sheet');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_sheet', 'Can view sheet', 'basic', 'sheet', NULL, 'feature_sheet');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_sheet_history', 'Can view sheet history', 'admin', 'sheet', NULL, 'feature_sheet');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_shoutbox', 'Can admin shoutbox (Edit/remove msgs)', 'editors', 'shoutbox', 'y', 'feature_shoutbox');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_post_shoutbox', 'Can post messages in shoutbox', 'basic', 'shoutbox', NULL, 'feature_shoutbox');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_shoutbox', 'Can view shoutbox', 'basic', 'shoutbox', NULL, 'feature_shoutbox');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_surveys', 'Can admin surveys', 'editors', 'surveys', 'y', 'feature_surveys');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_take_survey', 'Can take surveys', 'basic', 'surveys', NULL, 'feature_surveys');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_survey_stats', 'Can view survey stats', 'basic', 'surveys', NULL, 'feature_surveys');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_trackers', 'Can admin trackers', 'editors', 'trackers', 'y', 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_attach_trackers', 'Can attach files to tracker items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_comment_tracker_items', 'Can insert comments for tracker items', 'basic', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tracker_view_comments', 'Can view tracker items comments', 'basic', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_tracker_items', 'Can create new items for trackers', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_list_trackers', 'Can list trackers', 'basic', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_modify_tracker_items', 'Can change tracker items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_modify_tracker_items_pending', 'Can change tracker pending items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_modify_tracker_items_closed', 'Can change tracker closed items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tracker_view_ratings', 'Can view rating result for tracker items', 'basic', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tracker_vote_ratings', 'Can vote a rating for tracker items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_trackers', 'Can view trackers', 'basic', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_trackers_closed', 'Can view trackers closed items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_trackers_pending', 'Can view trackers pending items', 'editors', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_watch_trackers', 'Can watch tracker', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_export_tracker', 'Can export tracker items', 'registered', 'trackers', NULL, 'feature_trackers');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_wiki', 'Can admin the wiki', 'editors', 'wiki', 'y', 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_assign_perm_wiki_page', 'Can assign perms to wiki pages', 'admin', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit', 'Can edit pages', 'registered', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_copyrights', 'Can edit copyright notices', 'editors', 'wiki', NULL, 'wiki_feature_copyrights');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_dynvar', 'Can edit dynamic variables', 'editors', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_structures', 'Can create and edit structures', 'editors', 'wiki', NULL, 'feature_wiki_structure');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_export_wiki', 'Can export wiki pages using the export feature', 'admin', 'wiki', NULL, 'feature_wiki_export');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_lock', 'Can lock pages', 'editors', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_minor', 'Can save as minor edit', 'registered', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_remove', 'Can remove', 'editors', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_rename', 'Can rename pages', 'editors', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_rollback', 'Can rollback pages', 'editors', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_upload_picture', 'Can upload pictures to wiki pages', 'registered', 'wiki', NULL, 'feature_wiki_pictures');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_as_template', 'Can use the page as a tracker template', 'basic', 'wiki', NULL, 'feature_wiki_templates');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view', 'Can view page/pages', 'basic', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_watch_structure', 'Can watch structure', 'registered', 'wiki', NULL, 'feature_wiki_structure');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_admin_attachments', 'Can admin attachments to wiki pages', 'editors', 'wiki', NULL, 'feature_wiki_attachments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_admin_ratings', 'Can add and change ratings on wiki pages', 'admin', 'wiki', NULL, 'feature_wiki_ratings');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_attach_files', 'Can attach files to wiki pages', 'registered', 'wiki', NULL, 'feature_wiki_attachments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_view_attachments', 'Can view wiki attachments and download', 'registered', 'wiki', NULL, 'feature_wiki_attachments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_view_comments', 'Can view wiki comments', 'basic', 'wiki', NULL, 'feature_wiki_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_view_history', 'Can view wiki history', 'basic', 'wiki', NULL, 'feature_history');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_view_ratings', 'Can view rating of wiki pages', 'basic', 'wiki', NULL, 'feature_wiki_ratings');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_view_source', 'Can view source of wiki pages', 'basic', 'wiki', NULL, 'feature_source');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_vote_ratings', 'Can participate to rating of wiki pages', 'registered', 'wiki', NULL, 'feature_wiki_ratings');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_wiki_view_similar', 'Can view similar wiki pages', 'registered', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_workflow', 'Can admin workflow processes', 'admin', 'workflow', 'y', 'feature_workflow');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_abort_instance', 'Can abort a process instance', 'editors', 'workflow', NULL, 'feature_workflow');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_exception_instance', 'Can declare an instance as exception', 'registered', 'workflow', NULL, 'feature_workflow');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_send_instance', 'Can send instances after completion', 'registered', 'workflow', NULL, 'feature_workflow');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_workflow', 'Can execute workflow activities', 'registered', 'workflow', NULL, 'feature_workflow');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_received_articles', 'Can admin received articles', 'editors', 'comm', NULL, 'feature_comm');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_received_pages', 'Can admin received pages', 'editors', 'comm', NULL, 'feature_comm');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_send_articles', 'Can send articles to other sites', 'editors', 'comm', NULL, 'feature_comm');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_sendme_articles', 'Can send articles to this site', 'registered', 'comm', NULL, 'feature_comm');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_sendme_pages', 'Can send pages to this site', 'registered', 'comm', NULL, 'feature_comm');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_send_pages', 'Can send pages to other sites', 'registered', 'comm', NULL, 'feature_comm');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_tikitests', 'Can admin the TikiTests', 'admin', 'tikitests', NULL, 'feature_tikitests');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_tikitests', 'Can edit TikiTests', 'editors', 'tikitests', NULL, 'feature_tikitests');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_play_tikitests', 'Can replay the TikiTests', 'registered', 'tikitests', NULL, 'feature_tikitests');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_cache_bookmarks', 'Can cache user bookmarks', 'admin', 'user', NULL, 'feature_user_bookmarks');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_configure_modules', 'Can configure modules', 'registered', 'user', NULL, 'feature_modulecontrols');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_bookmarks', 'Can create user bookmarks', 'registered', 'user', NULL, 'feature_user_bookmarks');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_minical', 'Can use the mini event calendar', 'registered', 'user', NULL, 'feature_minical');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_notepad', 'Can use the notepad', 'registered', 'user', NULL, 'feature_notepad');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tasks_admin', 'Can admin public tasks', 'admin', 'user', NULL, 'feature_tasks');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tasks', 'Can use tasks', 'registered', 'user', NULL, 'feature_tasks');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tasks_receive', 'Can receive tasks from other users', 'registered', 'user', NULL, 'feature_tasks');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_tasks_send', 'Can send tasks to other users', 'registered', 'user', NULL, 'feature_tasks');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_userfiles', 'Can upload personal files', 'registered', 'user', NULL, 'feature_userfiles');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_usermenu', 'Can create items in personal menu', 'registered', 'user', NULL, 'feature_usermenu');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_broadcast_all', 'Can broadcast messages to all user', 'admin', 'messu', NULL, 'feature_messages');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_broadcast', 'Can broadcast messages to groups', 'admin', 'messu', NULL, 'feature_messages');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_messages', 'Can use the messaging system', 'registered', 'messu', NULL, 'feature_messages');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_comments', 'Can admin comments', 'admin', 'comments', 'y', 'feature_wiki_comments,feature_blog_comments,feature_blogposts_comments,feature_file_galleries_comments,feature_image_galleries_comments,feature_article_comments,feature_faq_comments,feature_poll_comments,map_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_comments', 'Can edit all comments', 'editors', 'comments', NULL, 'feature_wiki_comments,feature_blog_comments,feature_blogposts_comments,feature_file_galleries_comments,feature_image_galleries_comments,feature_article_comments,feature_faq_comments,feature_poll_comments,map_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_post_comments', 'Can post new comments', 'registered', 'comments', NULL, 'feature_wiki_comments,feature_blog_comments,feature_blogposts_comments,feature_file_galleries_comments,feature_image_galleries_comments,feature_article_comments,feature_faq_comments,feature_poll_comments,map_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_read_comments', 'Can read comments', 'basic', 'comments', NULL, 'feature_wiki_comments,feature_blog_comments,feature_blogposts_comments,feature_file_galleries_comments,feature_image_galleries_comments,feature_article_comments,feature_faq_comments,feature_poll_comments,map_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_remove_comments', 'Can delete comments', 'editors', 'comments', NULL, 'feature_wiki_comments,feature_blog_comments,feature_blogposts_comments,feature_file_galleries_comments,feature_image_galleries_comments,feature_article_comments,feature_faq_comments,feature_poll_comments,map_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_vote_comments', 'Can vote comments', 'registered', 'comments', NULL, 'feature_wiki_comments,feature_blog_comments,feature_blogposts_comments,feature_file_galleries_comments,feature_image_galleries_comments,feature_article_comments,feature_faq_comments,feature_poll_comments,map_comments');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_content_templates', 'Can admin content templates', 'admin', 'content templates', 'y', 'feature_wiki_templates,feature_cms_templates');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_content_templates', 'Can edit content templates', 'editors', 'content templates', NULL, 'feature_wiki_templates,feature_cms_templates');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_content_templates', 'Can use content templates', 'registered', 'content templates', NULL, 'feature_wiki_templates,feature_cms_templates');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_edit_html_pages', 'Can edit HTML pages', 'editors', 'html pages', NULL, 'feature_html_pages');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_html_pages', 'Can view HTML pages', 'basic', 'html pages', NULL, 'feature_html_pages');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_list_users', 'Can list registered users', 'registered', 'community', NULL, 'feature_friends');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_live_support_admin', 'Admin live support system', 'admin', 'support', 'y', 'feature_live_support');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_live_support', 'Can use live support system', 'basic', 'support', NULL, 'feature_live_support');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_map_create', 'Can create new mapfile', 'admin', 'maps', NULL, 'feature_maps');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_map_delete', 'Can delete mapfiles', 'admin', 'maps', NULL, 'feature_maps');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_map_edit', 'Can edit mapfiles', 'editors', 'maps', NULL, 'feature_maps');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_map_view', 'Can view mapfiles', 'basic', 'maps', NULL, 'feature_maps');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_map_view_mapfiles', 'Can view contents of mapfiles', 'registered', 'maps', NULL, 'feature_maps');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_webmail', 'Can use webmail', 'registered', 'webmail', NULL, 'feature_webmail,feature_contacts');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_group_webmail', 'Can use group webmail', 'registered', 'webmail', NULL, 'feature_webmail,feature_contacts');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_group_webmail', 'Can administrate group webmail accounts', 'registered', 'webmail', NULL, 'feature_webmail,feature_contacts');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_use_personal_webmail', 'Can use personal webmail accounts', 'registered', 'webmail', NULL, 'feature_webmail,feature_contacts');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_personal_webmail', 'Can administrate personal webmail accounts', 'registered', 'webmail', NULL, 'feature_webmail,feature_contacts');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_plugin_viewdetail', 'Can view unapproved plugin details', 'registered', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_plugin_preview', 'Can execute unapproved plugin', 'registered', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_plugin_approve', 'Can approve plugin execution', 'editors', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_trust_input', 'Trust all user inputs (no security checks)', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_backlink', 'View page backlinks', 'basic', 'wiki', NULL, 'feature_wiki');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_notifications', 'Can admin mail notifications', 'editors', 'mail notifications', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_invite', 'Can invite user in groups', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_delete_account', 'Can delete his own account', 'admin', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_importer', 'Can use the Tiki Importer', 'admin', 'tiki', 'y', NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_admin_categories', 'Can admin categories', 'editors', 'category', 'y', 'feature_categories');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_view_category', 'Can see the category in a listing', 'basic', 'category', NULL, 'feature_categories');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_modify_object_categories', 'Can change the categories on the object', 'editors', 'tiki', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_add_object', 'Can add objects in the category', 'editors', 'category', NULL, 'feature_categories');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_remove_object', 'Can remove objects from the category', 'editors', 'category', NULL, 'feature_categories');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_create_category', 'Can create new categories', 'admin', 'category', NULL, 'feature_categories');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_perspective_view', 'Can view the perspective', 'basic', 'perspective', NULL, 'feature_perspective');

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_group_view', 'Can view the group', 'basic', 'group', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_group_view_members', 'Can view the group members', 'basic', 'group', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_group_add_member', 'Can add group members', 'admin', 'group', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_group_remove_member', 'Can remove group members', 'admin', 'group', NULL, NULL);

INSERT INTO `users_permissions` (`permName`, `permDesc`, `level`, `type`, `admin`, `feature_check`) VALUES('tiki_p_group_join', 'Can join or leave the group', 'admin', 'group', NULL, NULL);


DROP TABLE `users_usergroups`;

CREATE TABLE `users_usergroups` (
  `userId` number(8) default '0' NOT NULL,
  `groupName` varchar(255) default '' NOT NULL,
  PRIMARY KEY (`userId`,`groupName`(30))
) ENGINE=MyISAM;


INSERT INTO "users_groups" ("groupName","groupDesc") VALUES ('Anonymous','Public users not logged');

INSERT INTO "users_groups" ("groupName","groupDesc") VALUES ('Registered','Users logged into the system');

INSERT INTO "users_groups" ("groupName","groupDesc") VALUES ('Admins','Administrator and accounts managers.');


DROP TABLE `users_users`;

CREATE TABLE `users_users` (
  `userId` number(8) NOT NULL auto_increment,
  `email` varchar(200) default NULL,
  `login` varchar(200) default '' NOT NULL,
  `password` varchar(30) default '',
  `provpass` varchar(30) default NULL,
  `default_group` varchar(255),
  `lastLogin` number(14) default NULL,
  `currentLogin` number(14) default NULL,
  `registrationDate` number(14) default NULL,
  `challenge` varchar(32) default NULL,
  `pass_confirm` number(14) default NULL,
  `email_confirm` number(14) default NULL,
  `hash` varchar(34) default NULL,
  `created` number(14) default NULL,
  `avatarName` varchar(80) default NULL,
  `avatarSize` number(14) default NULL,
  `avatarFileType` varchar(250) default NULL,
  `avatarData` blob,
  `avatarLibName` varchar(200) default NULL,
  `avatarType` char(1) default NULL,
  `score` number(11) default 0 NOT NULL,
  `valid` varchar(32) default NULL,
  `unsuccessful_logins` number(14) default 0,
  `openid_url` varchar(255) default NULL,
  `waiting` char(1) default NULL,
  PRIMARY KEY (`userId`),
  KEY `score` (score),
  KEY `login` (login),
  KEY `registrationDate` (registrationDate),
  KEY `openid_url` (openid_url)
) ENGINE=MyISAM  ;


-- Administrator account
INSERT INTO "users_users" ("email","login","password","hash") VALUES ('','admin','admin','f6fdffe48c908deb0f4c3bd36c032e72');

UPDATE "users_users" SET "currentLogin"="lastLogin" "registrationDate"="lastLogin";

INSERT INTO "tiki_user_preferences" ("user","prefName","value") VALUES ('admin','realName','System Administrator');

INSERT INTO users_usergroups (userId, groupName) VALUES(1,'Admins');

INSERT INTO "users_grouppermissions" ("groupName","permName") VALUES ('Admins','tiki_p_admin');


DROP TABLE `tiki_integrator_reps`;

CREATE TABLE `tiki_integrator_reps` (
  `repID` number(11) NOT NULL auto_increment,
  `name` varchar(255) default '' NOT NULL,
  `path` varchar(255) default '' NOT NULL,
  `start_page` varchar(255) default '' NOT NULL,
  `css_file` varchar(255) default '' NOT NULL,
  `visibility` char(1) default 'y' NOT NULL,
  `cacheable` char(1) default 'y' NOT NULL,
  `expiration` number(11) default '0' NOT NULL,
  `description` clob NOT NULL,
  PRIMARY KEY (`repID`)
) ENGINE=MyISAM;


INSERT INTO tiki_integrator_reps VALUES ('1','Doxygened (1.3.4) Documentation','','index.html','doxygen.css','n','y','0','Use this repository as rule source for all your repositories based on doxygened docs. To setup yours just add new repository and copy rules from this repository :)');


DROP TABLE `tiki_integrator_rules`;

CREATE TABLE `tiki_integrator_rules` (
  `ruleID` number(11) NOT NULL auto_increment,
  `repID` number(11) default '0' NOT NULL,
  `ord` number(2) default '0' NOT NULL,
  `srch` blob NOT NULL,
  `repl` blob NOT NULL,
  `type` char(1) default 'n' NOT NULL,
  `casesense` char(1) default 'y' NOT NULL,
  `rxmod` varchar(20) default '' NOT NULL,
  `enabled` char(1) default 'n' NOT NULL,
  `description` clob NOT NULL,
  PRIMARY KEY (`ruleID`),
  KEY `repID` (repID)
) ENGINE=MyISAM;


INSERT INTO tiki_integrator_rules VALUES ('1','1','1','.*<body[^>]*?>(.*?)</body.*','\1','y','n','i','y','Extract code between <body> and </body> tags');

INSERT INTO tiki_integrator_rules VALUES ('2','1','2','img src=(\"|\')(?!http://)','img src=\1{path}/','y','n','i','y','Fix image paths');

INSERT INTO tiki_integrator_rules VALUES ('3','1','3','href=(\"|\')(?!(--|(http|ftp)://))','href=\1tiki-integrator.php?repID={repID}&file=','y','n','i','y','Replace internal links to integrator. Don\'t touch an external link.');


DROP TABLE `tiki_quicktags`;

CREATE TABLE `tiki_quicktags` (
  `tagId` number(4) NOT NULL auto_increment,
  `taglabel` varchar(255) default NULL,
  `taginsert` clob,
  `tagicon` varchar(255) default NULL,
  `tagcategory` varchar(255) default NULL,
  PRIMARY KEY (`tagId`),
  KEY `tagcategory` (tagcategory),
  KEY `taglabel` (taglabel)
) ENGINE=MyISAM  ;


-- wiki
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('link, external','[http://example.com|text]','pics/icons/world_link.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('link, wiki','((text))','pics/icons/page_link.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('list bullets', '*text', 'pics/icons/text_list_bullets.png', 'wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('list numbers', '--text', 'pics/icons/text_list_numbers.png', 'wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('quote','popup_plugin_form("quote")','pics/icons/quotes.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('code','popup_plugin_form("code")','pics/icons/page_white_code.png','wiki');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('flash','popup_plugin_form("flash")','pics/icons/page_white_actionscript.png','wiki');


-- maps
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New wms Metadata','METADATA\r\n		\"wms_name\" \"myname\"\r\n 	"wms_srs" "EPSG:4326"\r\n 	"wms_server_version" " "\r\n 	"wms_layers" "mylayers"\r\n 	"wms_request" "myrequest"\r\n 	"wms_format" " "\r\n 	"wms_time" " "\r\n END', 'pics/icons/tag_blue_add.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Class', 'CLASS\r\n EXPRESSION ()\r\n SYMBOL 0\r\n OUTLINECOLOR\r\n COLOR\r\n NAME "myclass" \r\nEND --end of class', 'pics/icons/application_add.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Projection','PROJECTION\r\n "init=epsg:4326"\r\nEND','pics/icons/image_add.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Query','--\r\n-- Start of query definitions\r\n--\r\n QUERYMAP\r\n STATUS ON\r\n STYLE HILITE\r\nEND','pics/icons/database_gear.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Scalebar','--\r\n-- Start of scalebar\r\n--\r\nSCALEBAR\r\n IMAGECOLOR 255 255 255\r\n STYLE 1\r\n SIZE 400 2\r\n COLOR 0 0 0\r\n UNITS KILOMETERS\r\n INTERVALS 5\r\n STATUS ON\r\nEND','pics/icons/layout_add.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Layer','LAYER\r\n NAME\r\n TYPE\r\n STATUS ON\r\n DATA "mydata"\r\nEND --end of layer', 'pics/icons/layers.png', 'maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Label','LABEL\r\n COLOR\r\n ANGLE\r\n FONT arial\r\n TYPE TRUETYPE\r\n POSITION\r\n PARTIALS TRUE\r\n SIZE 6\r\n BUFFER 0\r\n OUTLINECOLOR \r\nEND --end of label', 'pics/icons/comment_add.png', 'maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Reference','--\r\n--start of reference\r\n--\r\n REFERENCE\r\n SIZE 120 60\r\n STATUS ON\r\n EXTENT -180 -90 182 88\r\n OUTLINECOLOR 255 0 0\r\n IMAGE "myimagedata"\r\n COLOR -1 -1 -1\r\nEND','pics/icons/picture_add.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Legend','--\r\n--start of Legend\r\n--\r\n LEGEND\r\n KEYSIZE 18 12\r\n POSTLABELCACHE TRUE\r\n STATUS ON\r\nEND','pics/icons/note_add.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Web','--\r\n-- Start of web interface definition\r\n--\r\nWEB\r\n TEMPLATE "myfile/url"\r\n MINSCALE 1000\r\n MAXSCALE 40000\r\n IMAGEPATH "myimagepath"\r\n IMAGEURL "mypath"\r\nEND', 'pics/icons/world_link.png', 'maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Outputformat','OUTPUTFORMAT\r\n NAME\r\n DRIVER " "\r\n MIMETYPE "myimagetype"\r\n IMAGEMODE RGB\r\n EXTENSION "png"\r\nEND','pics/icons/newspaper_go.png','maps');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('New Mapfile','--\r\n-- Start of mapfile\r\n--\r\nNAME MYMAPFLE\r\n STATUS ON\r\nSIZE \r\nEXTENT\r\nUNITS \r\nSHAPEPATH " "\r\nIMAGETYPE " "\r\nFONTSET " "\r\nIMAGECOLOR -1 -1 -1\r\n\r\n--remove this text and add objects here\r\n\r\nEND -- end of mapfile','pics/icons/world_add.png','maps');


-- newsletters
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text|nocache]','pics/icons/world_link.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule', '---', 'pics/icons/page.png', 'newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','newsletters');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','newsletters');


-- trackers
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text]','pics/icons/world_link.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('wiki link','((text))','pics/icons/page_link.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('quote','popup_plugin_form("quote")','pics/icons/quotes.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('code','popup_plugin_form("code")','pics/icons/page_white_code.png','trackers');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('flash','popup_plugin_form("flash")','pics/icons/page_white_actionscript.png','trackers');


-- blogs
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text]','pics/icons/world_link.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('wiki link','((text))','pics/icons/page_link.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('quote','popup_plugin_form("quote")','pics/icons/quotes.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('code','popup_plugin_form("code")','pics/icons/page_white_code.png','blogs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('flash','popup_plugin_form("flash")','pics/icons/page_white_actionscript.png','blogs');


-- calendar
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text]','pics/icons/world_link.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('wiki link','((text))','pics/icons/page_link.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','calendar');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','calendar');


-- articles
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text]','pics/icons/world_link.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('wiki link','((text))','pics/icons/page_link.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('quote','popup_plugin_form("quote")','pics/icons/quotes.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('code','popup_plugin_form("code")','pics/icons/page_white_code.png','articles');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('flash','popup_plugin_form("flash")','pics/icons/page_white_actionscript.png','articles');


-- faqs
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text]','pics/icons/world_link.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('wiki link','((text))','pics/icons/page_link.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','faqs');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','faqs');


-- forums
INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, bold','__text__','pics/icons/text_bold.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, italic','\'\'text\'\'','pics/icons/text_italic.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('  text, underline','===text===','pics/icons/text_underline.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('table new','||r1c1|r1c2|r1c3\nr2c1|r2c2|r2c3\nr3c1|r3c2|r3c3||','pics/icons/table.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('external link','[http://example.com|text]','pics/icons/world_link.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('wiki link','((text))','pics/icons/page_link.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading1','!text','pics/icons/text_heading_1.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading2','!!text','pics/icons/text_heading_2.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' heading3','!!!text','pics/icons/text_heading_3.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('title bar','-=text=-','pics/icons/text_padding_top.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('box','^text^','pics/icons/box.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' horizontal rule','---','pics/icons/page.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('center text','::text::','pics/icons/text_align_center.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' colored text','~~--FF0000:text~~','pics/icons/palette.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('dynamic variable','%text%','pics/icons/database_gear.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('image','popup_plugin_form("img")','pics/icons/picture.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES (' deleted','--text--','pics/icons/text_strikethrough.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('quote','popup_plugin_form("quote")','pics/icons/quotes.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('code','popup_plugin_form("code")','pics/icons/page_white_code.png','forums');

INSERT INTO "tiki_quicktags" ("taglabel","taginsert","tagicon","tagcategory") VALUES ('flash','popup_plugin_form("flash")','pics/icons/page_white_actionscript.png','forums');


-- Translated objects table
DROP TABLE `tiki_translated_objects`;

CREATE TABLE `tiki_translated_objects` (
  `traId` number(14) NOT NULL auto_increment,
  `type` varchar(50) NOT NULL,
  `objId` varchar(255) NOT NULL,
  `lang` varchar(16) default NULL,
  PRIMARY KEY (`type`, `objId`),
  KEY `traId` ( traId )
) ENGINE=MyISAM ;


DROP TABLE `tiki_friends`;

CREATE TABLE `tiki_friends` (
  `user` varchar(200) default '' NOT NULL,
  `friend` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`user`(120),friend(120))
) ENGINE=MyISAM;


DROP TABLE `tiki_friendship_requests`;

CREATE TABLE `tiki_friendship_requests` (
  `userFrom` varchar(200) default '' NOT NULL,
  `userTo` varchar(200) default '' NOT NULL,
  `tstamp` timestamp(3) NOT NULL,
  PRIMARY KEY (`userFrom`(120),`userTo`(120))
) ENGINE=MyISAM;


DROP TABLE `tiki_score`;

CREATE TABLE `tiki_score` (
  "event" varchar(40) default '' NOT NULL,
  "score" number(11) default '0' NOT NULL,
  "expiration" number(11) default '0' NOT NULL,
  PRIMARY KEY (`event`)
) ENGINE=MyISAM;


INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('login',1,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('login_remain',2,60);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('profile_fill',10,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('profile_see',2,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('profile_is_seen',1,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('friend_new',10,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('message_receive',1,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('message_send',2,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('article_read',2,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('article_comment',5,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('article_new',20,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('article_is_read',1,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('article_is_commented',2,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('fgallery_new',10,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('fgallery_new_file',10,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('fgallery_download',5,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('fgallery_is_downloaded',5,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('igallery_new',10,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('igallery_new_img',6,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('igallery_see_img',3,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('igallery_img_seen',1,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('blog_new',20,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('blog_post',5,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('blog_read',2,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('blog_comment',2,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('blog_is_read',3,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('blog_is_commented',3,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('wiki_new',10,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('wiki_edit',5,0);

INSERT INTO "tiki_score" ("event","score","expiration") VALUES ('wiki_attach_file',3,0);


DROP TABLE `tiki_users_score`;

CREATE TABLE `tiki_users_score` (
  `user` char(200) default '' NOT NULL,
  `event_id` char(200) default '' NOT NULL,
  `expire` number(14) default '0' NOT NULL,
  `tstamp` timestamp(3) NOT NULL,
  PRIMARY KEY (`user`(110),`event_id`(110)),
  KEY `user` (user(110),event_id(110),expire)
) ENGINE=MyISAM;


DROP TABLE `tiki_file_handlers`;

CREATE TABLE `tiki_file_handlers` (
  `mime_type` varchar(64) default NULL,
  `cmd` varchar(238) default NULL
) ENGINE=MyISAM;


DROP TABLE `tiki_stats`;

CREATE TABLE `tiki_stats` (
  `object` varchar(255) default '' NOT NULL,
  `type` varchar(20) default '' NOT NULL,
  `day` number(14) default '0' NOT NULL,
  `hits` number(14) default '0' NOT NULL,
  PRIMARY KEY (`object`(200),`type`,`day`)
) ENGINE=MyISAM;


DROP TABLE `tiki_events`;

CREATE TABLE `tiki_events` (
  `callback_type` number(1) default '3' NOT NULL,
  `order` number(2) default '50' NOT NULL,
  `event` varchar(200) default '' NOT NULL,
  `file` varchar(200) default '' NOT NULL,
  `object` varchar(200) default '' NOT NULL,
  `method` varchar(200) default '' NOT NULL,
  PRIMARY KEY (`callback_type`,`order`)
) ENGINE=MyISAM;


INSERT INTO "tiki_events" ("callback_type","`order`","event","file","object","method") VALUES ('1', '20', 'user_registers', 'lib/registration/registrationlib.php', 'registrationlib', 'callback_tikiwiki_setup_custom_fields');

INSERT INTO "tiki_events" ("event","file","object","method") VALUES ('user_registers', 'lib/registration/registrationlib.php', 'registrationlib', 'callback_tikiwiki_save_registration');

INSERT INTO "tiki_events" ("callback_type","`order`","event","file","object","method") VALUES ('5', '20', 'user_registers', 'lib/registration/registrationlib.php', 'registrationlib', 'callback_logslib_user_registers');

INSERT INTO "tiki_events" ("callback_type","`order`","event","file","object","method") VALUES ('5', '25', 'user_registers', 'lib/registration/registrationlib.php', 'registrationlib', 'callback_tikiwiki_send_email');

INSERT INTO "tiki_events" ("callback_type","`order`","event","file","object","method") VALUES ('5', '30', 'user_registers', 'lib/registration/registrationlib.php', 'registrationlib', 'callback_tikimail_user_registers');


DROP TABLE `tiki_registration_fields`;

CREATE TABLE `tiki_registration_fields` (
  `id` number(11) NOT NULL auto_increment,
  `field` varchar(255) default '' NOT NULL,
  `name` varchar(255) default NULL,
  `type` varchar(255) default 'text' NOT NULL,
  `show` number(1) default '1' NOT NULL,
  `size` varchar(10) default '10',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE `tiki_actionlog_conf`;

CREATE TABLE `tiki_actionlog_conf` (
  `id` number(11) NOT NULL auto_increment,
  `action` varchar(32) default '' NOT NULL,
  `objectType` varchar(32) default '' NOT NULL,
  `status` char(1) default '',
  PRIMARY KEY (`action`, `objectType`),
  KEY (id)
) ENGINE=MyISAM;


INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Created', 'wiki page', 'y');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Updated', 'wiki page', 'y');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed', 'wiki page', 'y');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'wiki page', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'forum', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Posted', 'forum', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Replied', 'forum', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Updated', 'forum', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'file gallery', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'image gallery', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Uploaded', 'file gallery', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Uploaded', 'image gallery', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('*', 'category', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('*', 'login', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Posted', 'message', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Replied', 'message', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'message', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed version', 'wiki page', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed last version', 'wiki page', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Rollback', 'wiki page', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed', 'forum', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Downloaded', 'file gallery', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Posted', 'comment', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Replied', 'comment', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Updated', 'comment', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed', 'comment', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Renamed', 'wiki page', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Created', 'sheet', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Updated', 'sheet', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed', 'sheet', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'sheet', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'blog', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Posted', 'blog', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Updated', 'blog', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed', 'blog', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Removed', 'file', 'n');

INSERT INTO "tiki_actionlog_conf" ("action","objectType","status") VALUES ('Viewed', 'article', 'n');


DROP TABLE `tiki_freetags`;

CREATE TABLE `tiki_freetags` (
  `tagId` number(10) NOT NULL auto_increment,
  `tag` varchar(30) default '' NOT NULL,
  `raw_tag` varchar(50) default '' NOT NULL,
  `lang` varchar(16) NULL,
  PRIMARY KEY (`tagId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_freetagged_objects`;

CREATE TABLE `tiki_freetagged_objects` (
  `tagId` number(12) NOT NULL auto_increment,
  `objectId` number(11) default 0 NOT NULL,
  `user` varchar(200) default '',
  `created` number(14) default '0' NOT NULL,
  PRIMARY KEY (`tagId`,`user`,`objectId`),
  KEY (tagId),
  KEY (user),
  KEY (objectId)
) ENGINE=MyISAM;


DROP TABLE `tiki_contributions`;

CREATE TABLE `tiki_contributions` (
  `contributionId` number(12) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `description` varchar(250) default NULL,
  PRIMARY KEY (`contributionId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_contributions_assigned`;

CREATE TABLE `tiki_contributions_assigned` (
  `contributionId` number(12) NOT NULL,
  `objectId` number(12) NOT NULL,
  PRIMARY KEY (`objectId`, `contributionId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_webmail_contacts_ext`;

CREATE TABLE `tiki_webmail_contacts_ext` (
  `contactId` number(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  `hidden` number(1) NOT NULL,
  `fieldId` number(10) NOT NULL,
  KEY `contactId` (`contactId`)
) ENGINE=MyISAM;


DROP TABLE `tiki_webmail_contacts_fields`;

CREATE TABLE `tiki_webmail_contacts_fields` (
  `user` VARCHAR( 200 ) NOT NULL ,
  `fieldname` VARCHAR( 255 ) NOT NULL ,
  `order` number(2) default '0' NOT NULL,
  `show` char(1) default 'n' NOT NULL,
  `fieldId` number(10) NOT NULL auto_increment,
  `flagsPublic` CHAR( 1 ) DEFAULT 'n' NOT NULL,
  PRIMARY KEY ( `fieldId` ),
  "INDEX" ( `user` )
) ENGINE = MyISAM ;


DROP TABLE `tiki_pages_translation_bits`;

CREATE TABLE `tiki_pages_translation_bits` (
  `translation_bit_id` number(14) NOT NULL auto_increment,
  `page_id` number(14) NOT NULL,
  `version` number(8) NOT NULL,
  `source_translation_bit` number(10) NULL,
  `original_translation_bit` number(10) NULL,
  `flags` SET('critical') NULL DEFAULT '',
  PRIMARY KEY (`translation_bit_id`),
  KEY(`page_id`),
  KEY(`original_translation_bit`),
  KEY(`source_translation_bit`)
);


DROP TABLE `tiki_pages_changes`;

CREATE TABLE `tiki_pages_changes` (
  `page_id` number(14),
  `version` number(10),
  `segments_added` number(10),
  `segments_removed` number(10),
  `segments_total` number(10),
  PRIMARY KEY(page_id, version)
);


DROP TABLE `tiki_minichat`;

CREATE TABLE `tiki_minichat` (
  `id` number(10) NOT NULL auto_increment,
  `channel` varchar(31),
  `ts` number(10) NOT NULL,
  `user` varchar(31) default NULL,
  `nick` varchar(31) default NULL,
  `msg` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`)
);


DROP TABLE `tiki_profile_symbols`;

CREATE TABLE `tiki_profile_symbols` (
  `domain` VARCHAR(50) NOT NULL,
  `profile` VARCHAR(50) NOT NULL,
  `object` VARCHAR(50) NOT NULL,
  `type` VARCHAR(20) NOT NULL,
  `value` VARCHAR(50) NOT NULL,
  `named` ENUM('y','n') NOT NULL,
  `creation_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY ( `domain`, `profile`, `object` ),
  "INDEX"(`named`)
);


DROP TABLE `tiki_feature`;

CREATE TABLE `tiki_feature` (
  `feature_id` mediumnumber(9) NOT NULL auto_increment,
  `feature_name` varchar(150) NOT NULL,
  `parent_id` mediumnumber(9) NOT NULL,
  `status` varchar(12) default 'active' NOT NULL,
  `setting_name` varchar(50) default NULL,
  `feature_type` varchar(30) default 'feature' NOT NULL,
  `template` varchar(50) default NULL,
  `permission` varchar(50) default NULL,
  `ordinal` mediumnumber(9) default '1' NOT NULL,
  `depends_on` mediumnumber(9) default NULL,
  `keyword` varchar(30) default NULL,
  `tip` clob NULL,
  `feature_count` mediumnumber(9) default '0' NOT NULL,
  `feature_path` varchar(20) default '0' NOT NULL,
  PRIMARY KEY (`feature_id`)
) ENGINE=MyISAM ;


DROP TABLE `tiki_schema`;

CREATE TABLE `tiki_schema` (
  `patch_name` VARCHAR(100) PRIMARY KEY,
  `install_date` TIMESTAMP
) ENGINE=MyISAM;


DROP TABLE `tiki_semantic_tokens`;

CREATE TABLE `tiki_semantic_tokens` (
  `token` VARCHAR(15) PRIMARY KEY,
  `label` VARCHAR(25) NOT NULL,
  `invert_token` VARCHAR(15)
) ENGINE=MyISAM ;


INSERT INTO tiki_semantic_tokens (token, label) VALUES('alias', 'Page Alias');


DROP TABLE `tiki_webservice`;

CREATE TABLE `tiki_webservice` (
  `service` VARCHAR(25) NOT NULL PRIMARY KEY,
  `url` VARCHAR(250),
  `body` TEXT,
  `schema_version` VARCHAR(5),
  `schema_documentation` VARCHAR(250)
) ENGINE=MyISAM ;


DROP TABLE `tiki_webservice_template`;

CREATE TABLE `tiki_webservice_template` (
  `service` VARCHAR(25) NOT NULL,
  `template` VARCHAR(25) NOT NULL,
  `engine` VARCHAR(15) NOT NULL,
  `output` VARCHAR(15) NOT NULL,
  `content` TEXT NOT NULL,
  `last_modif` INT,
  PRIMARY KEY( service, template )
) ENGINE=MyISAM ;


DROP TABLE `tiki_groupalert`;


CREATE TABLE `tiki_groupalert` (
  `groupName` varchar(255) default '' NOT NULL,
  `objectType` varchar( 20 ) default '' NOT NULL,
  `objectId` varchar(10) default '' NOT NULL,
  `displayEachuser` char( 1 ) default NULL ,
  PRIMARY KEY ( `objectType`, `objectId` )
) ENGINE=MyISAM ;


DROP TABLE `tiki_sent_newsletters_files`;

CREATE TABLE `tiki_sent_newsletters_files` (
  `id` number(11) NOT NULL auto_increment,
  `editionId` number(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `type` varchar(64) NOT NULL,
  `size` number(11) NOT NULL,
  `filename` varchar(256) NOT NULL,
  PRIMARY KEY ("`id`")
  KEY `editionId` (`editionId`)
);


DROP TABLE `tiki_sefurl_regex_out`;

CREATE TABLE `tiki_sefurl_regex_out` (
  `id` number(11) NOT NULL auto_increment,
  `left` varchar(256) NOT NULL,
  `right` varchar(256) NULL default NULL,
  `type` varchar(32) NULL default NULL,
  `silent` char(1) NULL default 'n',
  `feature` varchar(256) NULL default NULL,
  `comment` varchar(256),
  `order` number(11) NULL default 0,
  PRIMARY KEY(`id`),
  UNIQUE KEY `left` (`left`(128)),
  "INDEX" `idx1` (silent, type, feature(30))
);


INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-index.php\\?page=(.+)', '$1', 'wiki', 'feature_wiki');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-slideshow.php\\?page=(.+)', 'show:$1', '', 'feature_wiki');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-read_article.php\\?articleId=(\\d+)', 'article$1', 'article', 'feature_articles');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-browse_categories.php\\?parentId=(\\d+)', 'cat$1', 'category', 'feature_categories');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-view_blog.php\\?blogId=(\\d+)', 'blog$1', 'blog', 'feature_blogs');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-view_blog_post.php\\?postId=(\\d+)', 'blogpost$1', 'blogpost', 'feature_blogs');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-browse_image.php\\?imageId=(\\d+)', 'browseimage$1', 'image', 'feature_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-directory_browse.php\\?parent=(\\d+)', 'directory$1', 'directory', 'feature_directory');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-view_faq.php\\?faqId=(\\d+)', 'faq$1', 'faq', 'feature_faqs');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-list_file_gallery.php\\?galleryId=(\\d+)', 'file$1', 'file', 'feature_file_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-download_file.php\\?fileId=(\\d+)', 'dl$1', 'file', 'feature_file_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-download_file.php\\?fileId=(\\d+)&amp;thumbnail', 'thumbnail$1', 'thumbnail', 'feature_file_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-download_file.php\\?fileId=(\\d+)&amp;display', 'display$1', 'display', 'feature_file_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-download_file.php\\?fileId=(\\d+)&amp;preview', 'preview$1', 'preview', 'feature_file_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-view_forum.php\\?forumId=(\\d+)', 'forum$1', 'forum', 'feature_forums');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-browse_gallery.php\\?galleryId=(\\d+)', 'gallery$1', 'gallery', 'feature_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('show_image.php\\?id=(\\d+)', 'image$1', 'image', 'feature_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('show_image.php\\?id=(\\d+)&scalesize=(\\d+)', 'imagescale$1/$2', 'image', 'feature_galleries');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-newsletters.php\\?nlId=(\\d+)', 'newsletter$1', 'newsletter', 'feature_newsletters');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-take_quiz.php\\?quizId=(\\d+)', 'quiz$1', 'quiz', 'feature_quizzes');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-take_survey.php\\?surveyId=(\\d+)', 'survey$1', 'survey', 'feature_surveys');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-view_tracker.php\\?trackerId=(\\d+)', 'tracker$1', 'tracker', 'feature_trackers');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-integrator.php\\?repID=(\\d+)', 'int$1', '', 'feature_integrator');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-view_sheets.php\\?sheetId=(\\d+)', 'sheet$1', 'sheet', 'feature_sheet');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`) VALUES('tiki-directory_redirect.php\\?siteId=(\\d+)', 'dirlink$1', 'directory', 'feature_directory');

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)\&calIds\\[\\]=(\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)', 'cal$1,$2,$3,$4,$5,$6,$7', '7', 'calendar', 'feature_calendar', 100);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)\&calIds\\[\\]=(\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)', 'cal$1,$2,$3,$4,$5,$6', '6', 'calendar', 'feature_calendar', 101);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)\&calIds\\[\\]=(\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)', 'cal$1,$2,$3,$4,$5', '5', 'calendar', 'feature_calendar', 102);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)\&calIds\\[\\]=(\\d+)\&callIds\\[\\](\\d+)\&callIds\\[\\](\\d+)', 'cal$1,$2,$3,$4', '4', 'calendar', 'feature_calendar', 103);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)\&calIds\\[\\]=(\\d+)\&callIds\\[\\](\\d+)', 'cal$1,$2,$3', '3', 'calendar', 'feature_calendar', 104);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)&calIds\\[\\]=(\\d+)', 'cal$1,$2', '2', 'calendar', 'feature_calendar', 105);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `comment`, `type`, `feature`, `order`) VALUES('tiki-calendar.php\\?calIds\\[\\]=(\\d+)', 'cal$1', '1', 'calendar', 'feature_calendar', 106);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-calendar.php', 'calendar', 'calendar', 'feature_calendar', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-view_articles.php', 'articles', '', 'feature_articles', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-list_blogs.php', 'blogs', '', 'feature_blogs', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-browse_categories.php', 'categories', '', 'feature_categories', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-contact.php', 'contact', '', 'feature_contact', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-directory_browse.php', 'directories', '', 'feature_directory', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-list_faqs.php', 'faqs', '', 'feature_faqs', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-file_galleries.php', 'files', '', 'feature_file_galleries', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-forums.php', 'forums', '', 'feature_forums', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-galleries.php', 'galleries', '', 'feature_galleries', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-login_scr.php', 'login', '', '', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-my_tiki.php', 'my', '', '', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-newsletters.php', 'newsletters', 'newsletter', 'feature_newsletters', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-list_quizzes.php', 'quizzes', '', 'feature_quizzes', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-stats.php', 'stats', '', 'feature_stats', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-list_surveys.php', 'surveys', '', 'feature_surveys', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-list_trackers.php', 'trackers', '', 'feature_trackers', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-mobile.php', 'mobile', '', 'feature_mobile', 200);

INSERT INTO `tiki_sefurl_regex_out` (`left`, `right`, `type`, `feature`, `order`) VALUES('tiki-sheets.php', 'sheets', '', 'feature_sheet', 200);


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

UPDATE tiki_menus SET use_items_icons='y' WHERE menuId=42;


DROP TABLE `tiki_plugin_security`;

CREATE TABLE `tiki_plugin_security` (
  `fingerprint` VARCHAR(200) NOT NULL PRIMARY KEY,
  `status` VARCHAR(10) NOT NULL,
  `approval_by` VARCHAR(200) NULL,
  `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `last_objectType` VARCHAR(20) NOT NULL,
  `last_objectId` VARCHAR(200) NOT NULL,
  KEY `last_object` (last_objectType, last_objectId)
);


DROP TABLE `tiki_user_reports`;

CREATE TABLE "IF" NOT EXISTS `tiki_user_reports` (
  `id` number(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(200) NOT NULL,
  `interval` varchar(20) NOT NULL,
  `view` varchar(8) NOT NULL,
  `type` varchar(5) NOT NULL,
  `time_to_send` datetime NOT NULL,
  `always_email` number(1) NOT NULL,
  `last_report` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE `tiki_user_reports_cache`;

CREATE TABLE "IF" NOT EXISTS `tiki_user_reports_cache` (
  `id` number(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(200) NOT NULL,
  `event` varchar(200) NOT NULL,
  `data` clob NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE `tiki_perspectives`;

CREATE TABLE `tiki_perspectives` (
  `perspectiveId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY( perspectiveId )
) ENGINE=MyISAM;


DROP TABLE `tiki_perspective_preferences`;

CREATE TABLE `tiki_perspective_preferences` (
  `perspectiveId` int NOT NULL,
  `pref` varchar(40) NOT NULL,
  `value` clob,
  PRIMARY KEY( perspectiveId, pref )
) ENGINE=MyISAM;


;

