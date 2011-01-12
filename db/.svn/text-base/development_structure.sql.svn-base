CREATE TABLE `responses` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `guid` varchar(32) NOT NULL,
  `version_id` int(11) NOT NULL,
  `answers` text NOT NULL,
  `remote_ip` varchar(40) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `surveys` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `url_name` varchar(255) NOT NULL,
  `user_id` int(11) default NULL,
  `responses_count` int(11) default '0',
  `status` varchar(20) default 'never published',
  `embedding_id` varchar(32) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `rss_id` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `password_salt` varchar(255) default NULL,
  `password_hash` varchar(255) default NULL,
  `credits` int(11) NOT NULL default '0',
  `has_accepted_terms` int(11) NOT NULL default '0',
  `wishes_to_receive_news` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL auto_increment,
  `survey_id` int(11) NOT NULL,
  `position` int(11) default NULL,
  `state` int(11) default '1',
  `design` text,
  `responses_count` int(11) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20081013133531');

INSERT INTO schema_migrations (version) VALUES ('20081013133624');

INSERT INTO schema_migrations (version) VALUES ('20081013133637');

INSERT INTO schema_migrations (version) VALUES ('20081013133648');

INSERT INTO schema_migrations (version) VALUES ('20081020163840');

INSERT INTO schema_migrations (version) VALUES ('20081021093723');