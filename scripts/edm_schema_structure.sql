-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- -----------------------------------------------------
-- Schema edm
-- -----------------------------------------------------
-- The Extensible Data Manager Database.  A database for data management with features for displaying that data in a web site/application.
-- 
-- ** Note: From here on out the default schema name for the edm db is `edm`.
DROP SCHEMA IF EXISTS `edm` ;

-- -----------------------------------------------------
-- Schema edm
--
-- The Extensible Data Manager Database.  A database for data management with features for displaying that data in a web site/application.
-- 
-- ** Note: From here on out the default schema name for the edm db is `edm`.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `edm` DEFAULT CHARACTER SET UTF8MB4 ;
SHOW WARNINGS;
USE `edm` ;

-- -----------------------------------------------------
-- Table `edm`.`terms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`terms` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`terms` (
  `term_alias` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Term alias.',
  `term_name` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Term or term value.',
  `term_group_alias` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Terms group alias.  Used for grouping terms.',
  PRIMARY KEY (`term_alias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`term_taxonomies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`term_taxonomies` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`term_taxonomies` (
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_alias` VARCHAR(55) NOT NULL DEFAULT '',
  `taxonomy` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Taxonomies category.',
  `description` TEXT NOT NULL,
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'cms-manager' COMMENT 'Access group of who can edit/access this term term taxonomy.  For admin side of things (useful for CMSs (Content Management Systems) and the like).',
  `listOrder` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE INDEX `term_alias_taxonomy_idx` (`term_alias` ASC, `taxonomy` ASC),
  INDEX `term_taxonomies_fk1_idx` (`term_alias` ASC),
  INDEX `term_taxonomies_fk3_idx` (`accessGroup` ASC),
  INDEX `term_taxonomies_fk2_idx` (`taxonomy` ASC),
  CONSTRAINT `term_taxonomies_fk1`
    FOREIGN KEY (`term_alias`)
    REFERENCES `edm`.`terms` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `term_taxonomies_fk2`
    FOREIGN KEY (`taxonomy`)
    REFERENCES `edm`.`terms` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `term_taxonomies_fk3`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `edm`.`terms` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 92;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`addresses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`addresses` (
  `address_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(55) NOT NULL DEFAULT '',
  `address` VARCHAR(1024) NOT NULL DEFAULT '',
  `zipcode` TINYINT(9) UNSIGNED NOT NULL DEFAULT '0',
  `city` VARCHAR(55) NOT NULL DEFAULT '',
  `state` VARCHAR(55) NOT NULL DEFAULT '',
  `country` VARCHAR(55) NOT NULL DEFAULT '',
  `type` VARCHAR(55) NOT NULL DEFAULT '',
  `userParams` LONGTEXT NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `addresses_name_uidx` (`name` ASC),
  INDEX `addresses_fk_1_idx` (`type` ASC),
  CONSTRAINT `addresses_fk_1`
    FOREIGN KEY (`type`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`date_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`date_info` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`date_info` (
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `createdDate` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `createdById` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `lastUpdated` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `lastUpdatedById` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `checkedOutDate` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `checkedOutById` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `checkedInDate` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `checkedInById` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`date_info_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`posts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`posts` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `type` VARCHAR(55) NOT NULL DEFAULT 'post',
  `status` VARCHAR(55) NOT NULL DEFAULT 'unpublished',
  `title` VARCHAR(255) NOT NULL DEFAULT '',
  `alias` VARCHAR(200) NOT NULL DEFAULT '',
  `content` LONGTEXT NOT NULL,
  `excerpt` VARCHAR(2048) NOT NULL DEFAULT '',
  `hits` BIGINT(20) NOT NULL DEFAULT '0',
  `listOrder` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `commenting` VARCHAR(55) NOT NULL DEFAULT 'disabled',
  `commentCount` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'guest',
  `userParams` LONGTEXT NOT NULL,
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`post_id`),
  UNIQUE INDEX `posts_alias_uidx` (`alias` ASC),
  INDEX `posts_fk5_idx` (`date_info_id` ASC),
  INDEX `posts_fk1_idx` (`commenting` ASC),
  INDEX `posts_fk2_idx` (`type` ASC),
  INDEX `posts_fk3_idx` (`status` ASC),
  INDEX `posts_fk4_idx` (`accessGroup` ASC),
  CONSTRAINT `posts_fk1`
    FOREIGN KEY (`commenting`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk2`
    FOREIGN KEY (`type`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk3`
    FOREIGN KEY (`status`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk4`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk5`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `edm`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 52;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`comments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`comments` (
  `comment_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `authorName` VARCHAR(128) NOT NULL DEFAULT '',
  `authorEmail` VARCHAR(128) NOT NULL DEFAULT '',
  `notifyOnReply` TINYINT(1) NOT NULL DEFAULT '0',
  `authorIp` VARCHAR(128) NOT NULL DEFAULT '',
  `comment` TEXT NOT NULL,
  `status` VARCHAR(55) NOT NULL DEFAULT 'pending-approval',
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  INDEX `comments_fk1_idx` (`post_id` ASC),
  INDEX `comments_fk3_idx` (`date_info_id` ASC),
  INDEX `comments_fk2_idx` (`status` ASC),
  CONSTRAINT `comments_fk2`
    FOREIGN KEY (`status`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `comments_fk3`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `edm`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comments_f4`
    FOREIGN KEY (`post_id`)
    REFERENCES `edm`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`contacts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`contacts` (
  `contact_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `altEmail` VARCHAR(255) NOT NULL DEFAULT '',
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `type` VARCHAR(55) NOT NULL DEFAULT 'user',
  `firstName` VARCHAR(55) NOT NULL DEFAULT '',
  `middleName` VARCHAR(55) NOT NULL DEFAULT '',
  `lastName` VARCHAR(55) NOT NULL DEFAULT '',
  `userParams` LONGTEXT NOT NULL,
  PRIMARY KEY (`contact_id`),
  UNIQUE INDEX `contacts_email1_uidx` (`email` ASC),
  INDEX `contacts_fk_3_idx` (`type` ASC),
  CONSTRAINT `contacts_fk_3`
    FOREIGN KEY (`type`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`contact_address_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`contact_address_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`contact_address_relationships` (
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `address_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`contact_id`, `address_id`),
  INDEX `contact_address_rels_fk1_idx` (`contact_id` ASC),
  INDEX `contact_address_rels_fk2_idx` (`address_id` ASC),
  CONSTRAINT `contact_address_rels_fk1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `edm`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_address_rels_fk2`
    FOREIGN KEY (`address_id`)
    REFERENCES `edm`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`users` (
  `user_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `screenName` VARCHAR(55) NOT NULL DEFAULT '',
  `password` VARCHAR(96) NOT NULL DEFAULT '',
  `role` VARCHAR(55) NOT NULL DEFAULT 'user',
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'cms-manager',
  `status` VARCHAR(55) NOT NULL DEFAULT 'pending-activation',
  `lastLogin` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `activationKey` VARCHAR(96) NOT NULL DEFAULT '',
  `activationKeyCreatedDate` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `users_screenName_uidx` (`screenName` ASC),
  INDEX `users_fk_1_idx` (`role` ASC),
  INDEX `users_fk_5_idx` (`date_info_id` ASC),
  INDEX `users_fk_4_idx` (`status` ASC),
  INDEX `users_fk_3_idx` (`accessGroup` ASC),
  INDEX `users_fk_6_idx` (`contact_id` ASC),
  CONSTRAINT `users_fk_3`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `users_fk_4`
    FOREIGN KEY (`status`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `users_fk_5`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `edm`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `users_fk_1`
    FOREIGN KEY (`role`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `users_fk_6`
    FOREIGN KEY (`contact_id`)
    REFERENCES `edm`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`contact_created_by_user_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`contact_created_by_user_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`contact_created_by_user_relationships` (
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  INDEX `ccby_fk_1_idx` (`user_id` ASC),
  INDEX `ccby_fk_2_idx` (`contact_id` ASC),
  CONSTRAINT `ccby_fk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `edm`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ccby_fk_2`
    FOREIGN KEY (`contact_id`)
    REFERENCES `edm`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`flags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`flags` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`flags` (
  `object_id` BIGINT(20) NOT NULL DEFAULT '0',
  `objectType` VARCHAR(55) NOT NULL DEFAULT '',
  `flag` VARCHAR(55) NOT NULL DEFAULT '',
  `flaggerIp` VARCHAR(128) NOT NULL DEFAULT '',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  INDEX `flags_fk_3_idx` (`date_info_id` ASC),
  PRIMARY KEY (`object_id`, `objectType`, `flaggerIp`),
  INDEX `flags_fk_2_idx` (`flag` ASC),
  INDEX `flags_fk_1_idx` (`objectType` ASC),
  CONSTRAINT `flags_fk_1`
    FOREIGN KEY (`objectType`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `flags_fk_2`
    FOREIGN KEY (`flag`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `flags_fk_3`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `edm`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`galleries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`galleries` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`galleries` (
  `gallery_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `objectRelId` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectRelType` VARCHAR(55) NOT NULL DEFAULT '',
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`gallery_id`),
  INDEX `gallery_fk1_idx` (`post_id` ASC),
  INDEX `gallery_fk2_idx` (`objectRelType` ASC),
  CONSTRAINT `gallery_fk2`
    FOREIGN KEY (`objectRelType`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `gallery_fk1`
    FOREIGN KEY (`post_id`)
    REFERENCES `edm`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`view_modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`view_modules` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`view_modules` (
  `view_module_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL DEFAULT '',
  `alias` VARCHAR(200) NOT NULL DEFAULT '',
  `content` LONGTEXT NOT NULL,
  `type` VARCHAR(55) NOT NULL DEFAULT 'html',
  `helperName` VARCHAR(55) NOT NULL DEFAULT 'Html',
  `helperType` VARCHAR(55) NOT NULL DEFAULT 'view',
  `partialScript` VARCHAR(255) NOT NULL DEFAULT '',
  `allowedOnPages` LONGTEXT NOT NULL,
  `userParams` LONGTEXT NOT NULL,
  PRIMARY KEY (`view_module_id`),
  UNIQUE INDEX `view_modules_alias_UNIQUE` (`alias` ASC),
  INDEX `view_modules_fk_1_idx` (`type` ASC),
  INDEX `view_modules_fk_2_idx` (`helperType` ASC),
  CONSTRAINT `view_modules_fk_1`
    FOREIGN KEY (`type`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `view_modules_fk_2`
    FOREIGN KEY (`helperType`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
COMMENT = '@todo should drop html_id and html_class for htmlAttribs';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`menus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`menus` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`menus` (
  `menu_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `view_module_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `minDepth` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0',
  `maxDepth` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0',
  `onlyActiveBranch` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `renderParents` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `isMainMenu` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `useModuleHelper` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `ulClass` VARCHAR(255) NOT NULL DEFAULT '',
  `menuPartialScript` VARCHAR(1024) NOT NULL DEFAULT '',
  `menuHelperName` VARCHAR(55) NOT NULL DEFAULT 'EdmMenu',
  PRIMARY KEY (`menu_id`),
  INDEX `menu_fk1` (`view_module_id` ASC),
  CONSTRAINT `menus_fk1`
    FOREIGN KEY (`view_module_id`)
    REFERENCES `edm`.`view_modules` (`view_module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`pages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`pages` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`pages` (
  `page_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(55) NOT NULL DEFAULT '',
  `label` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '@todo The following attribs should be added as serialized json column (composite serialized column): \nhtml_id\nhtml_class\nhtml_title\nhtml_rel\nhtml_target',
  `alias` VARCHAR(200) NOT NULL DEFAULT '',
  `visible` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `htmlAttribs` LONGTEXT NOT NULL COMMENT 'The following attribs should alwas be serialized (json, or other serialize type) within this column: \nhtml_id\nhtml_class\nhtml_title\nhtml_rel\nhtml_target\nfragment',
  `description` VARCHAR(255) NOT NULL DEFAULT '',
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `uri` VARCHAR(255) NOT NULL DEFAULT '',
  `acl_resource` VARCHAR(255) NOT NULL DEFAULT '',
  `acl_privilege` VARCHAR(255) NOT NULL DEFAULT '',
  `mvc_action` VARCHAR(55) NOT NULL DEFAULT '',
  `mvc_controller` VARCHAR(55) NOT NULL DEFAULT '',
  `mvc_module` VARCHAR(55) NOT NULL DEFAULT '',
  `mvc_route` VARCHAR(55) NOT NULL DEFAULT '',
  `mvc_resetParamsOnRender` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1',
  `mvc_params` TEXT NOT NULL,
  `userParams` LONGTEXT NOT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE INDEX `pages_alias_uidx` (`alias` ASC),
  INDEX `pages_fk1_idx` (`type` ASC),
  CONSTRAINT `pages_fk1`
    FOREIGN KEY (`type`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`page_menu_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`page_menu_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`page_menu_relationships` (
  `menu_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `page_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`menu_id`, `page_id`),
  INDEX `page_menu_rel_fk1` (`menu_id` ASC),
  INDEX `page_menu_rel_fk2` (`page_id` ASC),
  CONSTRAINT `page_menu_rel_fk1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `edm`.`menus` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `page_menu_rel_fk2`
    FOREIGN KEY (`page_id`)
    REFERENCES `edm`.`pages` (`page_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`media` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`media` (
  `media_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `mimeType` VARCHAR(55) NOT NULL DEFAULT '',
  `filePath` VARCHAR(255) NOT NULL DEFAULT '',
  `listOrder` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectRelId` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectRelType` VARCHAR(55) NOT NULL DEFAULT 'post',
  PRIMARY KEY (`media_id`),
  INDEX `media_fk_1_idx` (`post_id` ASC),
  INDEX `media_objectRelId_idx` (`objectRelId` ASC),
  INDEX `media_fk_2_idx` (`objectRelType` ASC),
  CONSTRAINT `media_fk_2`
    FOREIGN KEY (`objectRelType`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `media_fk_1`
    FOREIGN KEY (`post_id`)
    REFERENCES `edm`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`post_category_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`post_category_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`post_category_relationships` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`, `term_taxonomy_id`),
  INDEX `term_rel_fk_1_idx` (`term_taxonomy_id` ASC),
  INDEX `term_rel_fk_5_idx` (`post_id` ASC),
  CONSTRAINT `term_rel_fk_1`
    FOREIGN KEY (`term_taxonomy_id`)
    REFERENCES `edm`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `term_rel_fk_5`
    FOREIGN KEY (`post_id`)
    REFERENCES `edm`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`security_question_user_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`security_question_user_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`security_question_user_relationships` (
  `security_question_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `answer` VARCHAR(45) NULL DEFAULT '',
  INDEX `user_q_and_a_rels_fk1_idx` (`security_question_id` ASC),
  INDEX `user_q_and_a_rels_fk2_idx` (`user_id` ASC),
  CONSTRAINT `user_q_and_a_rels_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `edm`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_q_and_a_rels_fk1`
    FOREIGN KEY (`security_question_id`)
    REFERENCES `edm`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`sessions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`sessions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`sessions` (
  `id` VARCHAR(32) NOT NULL DEFAULT '',
  `savePath` VARCHAR(32) NOT NULL DEFAULT '',
  `name` VARCHAR(32) NOT NULL DEFAULT '',
  `modified` BIGINT(20) NOT NULL DEFAULT '0',
  `lifetime` BIGINT(20) NOT NULL DEFAULT '0',
  `data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `savePath`, `name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`term_taxonomies_proxy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`term_taxonomies_proxy` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`term_taxonomies_proxy` (
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `childCount` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `assocItemCount` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `descendants` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`term_taxonomy_id`),
  INDEX `term_taxonomy_proxy_fk1_idx` (`term_taxonomy_id` ASC),
  CONSTRAINT `term_taxonomies_proxy_fk1`
    FOREIGN KEY (`term_taxonomy_id`)
    REFERENCES `edm`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`mixed_term_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`mixed_term_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`mixed_term_relationships` (
  `object_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectType` VARCHAR(55) NOT NULL DEFAULT 'view-module',
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `status` VARCHAR(55) NOT NULL DEFAULT 'unpublished',
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'guest',
  `listOrder` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`, `objectType`, `term_taxonomy_id`),
  INDEX `mixed_term_rels_fk1_idx1` (`term_taxonomy_id` ASC),
  INDEX `mixed_term_rels_fk3_idx` (`accessGroup` ASC),
  INDEX `mixed_term_rels_fk2_idx` (`status` ASC),
  CONSTRAINT `mixed_term_rels_fk2`
    FOREIGN KEY (`status`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `mixed_term_rels_fk3`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `edm`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `mixed_term_rels_fk1`
    FOREIGN KEY (`term_taxonomy_id`)
    REFERENCES `edm`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`user_activation_keys`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`user_activation_keys` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`user_activation_keys` (
  `user_activation_key` VARCHAR(32) NOT NULL DEFAULT '',
  `createdDate` BIGINT(20) NOT NULL DEFAULT '0',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_activation_key`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  CONSTRAINT `user_activation_keys_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `edm`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`user_contact_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`user_contact_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`user_contact_relationships` (
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `screenName` VARCHAR(55) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`, `screenName`),
  UNIQUE INDEX `user_rels_email_uidx` (`email` ASC),
  UNIQUE INDEX `user_rels_screenName_uidx` (`screenName` ASC),
  INDEX `user_rels_fk_1_idx` (`screenName` ASC),
  INDEX `user_rels_fk_2_idx` (`email` ASC),
  CONSTRAINT `user_rels_fk_1`
    FOREIGN KEY (`screenName`)
    REFERENCES `edm`.`users` (`screenName`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `user_rels_fk_2`
    FOREIGN KEY (`email`)
    REFERENCES `edm`.`contacts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`phone_numbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`phone_numbers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`phone_numbers` (
  `phone_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL DEFAULT '',
  `country_code` VARCHAR(10) NOT NULL DEFAULT '',
  `area_code` VARCHAR(10) NOT NULL DEFAULT '',
  `state_code` VARCHAR(10) NOT NULL DEFAULT '',
  `number` VARCHAR(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`phone_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `edm`.`contact_phone_relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `edm`.`contact_phone_relationships` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `edm`.`contact_phone_relationships` (
  `phone_id` BIGINT(20) UNSIGNED NOT NULL,
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`phone_id`),
  INDEX `contact_phone_rels_fk1` (`phone_id` ASC),
  INDEX `contact_phone_rels_fk2` (`contact_id` ASC),
  CONSTRAINT `contact_phone_relationships_fk1`
    FOREIGN KEY (`phone_id`)
    REFERENCES `edm`.`phone_numbers` (`phone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_phone_relationships_fk2`
    FOREIGN KEY (`contact_id`)
    REFERENCES `edm`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
USE `edm` ;

-- -----------------------------------------------------
-- Placeholder table for view `edm`.`term_taxonomies_lookup`
-- -----------------------------------------------------
-- CREATE TABLE IF NOT EXISTS `edm`.`term_taxonomies_lookup` (`id` INT);
-- SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure getTermTaxIdByAlias
-- -----------------------------------------------------

USE `edm`;
DROP procedure IF EXISTS `edm`.`getTermTaxIdByAlias`;
SHOW WARNINGS;

DELIMITER $$
USE `edm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTermTaxIdByAlias`(alias VARCHAR(55), taxonomy VARCHAR(55), OUT ttId BIGINT(20))
BEGIN
    SET ttId = (
        SELECT t2.term_taxonomy_id 
        FROM term_taxonomies AS t2 
        WHERE t2.term_alias = alias AND t2.taxonomy = taxonomy);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure getTermTaxProxyCountById
-- -----------------------------------------------------

USE `edm`;
DROP procedure IF EXISTS `edm`.`getTermTaxProxyCountById`;
SHOW WARNINGS;

DELIMITER $$
USE `edm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTermTaxProxyCountById`(
    ttId BIGINT(20), fieldName VARCHAR(255), OUT countVar BIGINT(20))
BEGIN
    IF fieldName = "assocItemCount" THEN
        SET countVar = (SELECT assocItemCount 
            FROM term_taxonomies_proxy WHERE term_taxonomy_id = ttId);
    ELSEIF fieldName = "childCount" THEN
        SET countVar = (SELECT childCount
            FROM term_taxonomies_proxy WHERE term_taxonomy_id = ttId);
    ELSE
        SET countVar = (SELECT descendants
            FROM term_taxonomies_proxy WHERE term_taxonomy_id = ttId);
    END IF;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure getTermTaxTaxonomyById
-- -----------------------------------------------------

USE `edm`;
DROP procedure IF EXISTS `edm`.`getTermTaxTaxonomyById`;
SHOW WARNINGS;

DELIMITER $$
USE `edm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTermTaxTaxonomyById`(
    ttId BIGINT(20), 
    OUT outTaxonomy VARCHAR(55))
BEGIN
    SET outTaxonomy = (
        SELECT taxonomy 
            FROM term_taxonomies 
            WHERE term_taxonomy_id = ttId);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure getTermTaxTopLevelIdById
-- -----------------------------------------------------

USE `edm`;
DROP procedure IF EXISTS `edm`.`getTermTaxTopLevelIdById`;
SHOW WARNINGS;

DELIMITER $$
USE `edm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTermTaxTopLevelIdById`(
    ttId BIGINT(20), OUT topLevelTaxonomy VARCHAR(55))
BEGIN
    DECLARE taxonomy VARCHAR(55) DEFAULT '';
    DECLARE foundTTID BIGINT(20);
    WHILE taxonomy <> 'taxonomy' DO
        CALL getTermTaxTaxonomyById (ttId, taxonomy);
    END WHILE;
    SET topLevelTaxonomy = taxonomy;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure offsetTermTaxProxyByAlias
-- -----------------------------------------------------

USE `edm`;
DROP procedure IF EXISTS `edm`.`offsetTermTaxProxyByAlias`;
SHOW WARNINGS;

DELIMITER $$
USE `edm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `offsetTermTaxProxyByAlias`(alias VARCHAR(55), taxonomy VARCHAR(55), offsetVal INT SIGNED, fieldName VARCHAR(55))
BEGIN
	DECLARE ttId                BIGINT(20);
	CALL getTermTaxIdByAlias(alias, taxonomy, ttId);
        CALL offsetTermTaxProxyById(ttId, offsetVal, fieldName);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure offsetTermTaxProxyById
-- -----------------------------------------------------

USE `edm`;
DROP procedure IF EXISTS `edm`.`offsetTermTaxProxyById`;
SHOW WARNINGS;

DELIMITER $$
USE `edm`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `offsetTermTaxProxyById`(ttId BIGINT(20), offsetVal INT SIGNED, fieldName VARCHAR(55))
BEGIN
        IF fieldName = "assocItemCount" THEN
            UPDATE term_taxonomies_proxy AS t2 
                SET t2.assocItemCount = If (CAST(t2.assocItemCount AS SIGNED INT) + offsetVal < 0, 0, CAST(t2.assocItemCount AS SIGNED INT) + offsetVal)
                WHERE t2.term_taxonomy_id = ttId;
        ELSEIF fieldName = "childCount" THEN
            UPDATE term_taxonomies_proxy AS t2
                SET t2.childCount = If (CAST(t2.childCount AS SIGNED INT) + offsetVal < 0, 0, CAST(t2.childCount AS SIGNED INT) + offsetVal)
                WHERE t2.term_taxonomy_id = ttId;
        ELSEIF fieldName = "descendants" THEN
            UPDATE term_taxonomies_proxy AS t2
                SET t2.descendants = If (CAST(t2.descendants AS SIGNED INT) + offsetVal < 0, 0, CAST(t2.descendants AS SIGNED INT) + offsetVal)
                WHERE t2.term_taxonomy_id = ttId;
        END IF;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `edm`.`term_taxonomies_lookup`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `edm`.`term_taxonomies_lookup` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `edm`.`term_taxonomies_lookup`;
SHOW WARNINGS;
USE `edm`;
CREATE VIEW `edm`.`term_taxonomies_lookup` AS (
	SELECT 
		t1.*, 
		t2.childCount, 
		t2.assocItemCount, 
		t2.descendants 
	FROM 
		term_taxonomies AS t1 
	RIGHT JOIN
		term_taxonomies_proxy AS t2
		ON t1.term_taxonomy_id = t2.term_taxonomy_id
); 
;
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `edm`;

DELIMITER $$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`bi_term_taxonomies` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`bi_term_taxonomies`
BEFORE INSERT ON `edm`.`term_taxonomies`
FOR EACH ROW
BEGIN
    DECLARE ttId BIGINT(20);
    DECLARE descendantCount BIGINT(20);
    IF NEW.term_alias <> 'taxonomy' THEN
        IF NEW.parent_id = 0 THEN
            CALL getTermTaxIdByAlias(NEW.taxonomy, 'taxonomy', ttId);
        ELSEIF NEW.parent_id <> 0 THEN
            CALL getTermTaxTopLevelIdById(NEW.parent_id, ttId);
        END IF;
        CALL getTermTaxProxyCountById(ttId, 'descendants', descendantCount );
        SET NEW.listOrder = descendantCount  + 1;

    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`ai_term_taxonomies` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`ai_term_taxonomies`
AFTER INSERT ON `edm`.`term_taxonomies`
FOR EACH ROW
BEGIN
    
    INSERT INTO term_taxonomies_proxy (term_taxonomy_id) 
        VALUES (NEW.term_taxonomy_id);

    
    IF NEW.parent_id > 0 THEN
        CALL offsetTermTaxProxyById(NEW.parent_id, 1, 'childCount'); 
    ELSEIF NEW.parent_id = 0 THEN
        CALL offsetTermTaxProxyByAlias(NEW.taxonomy, 'taxonomy', 1, 'childCount');
    END IF;

    
    CALL offsetTermTaxProxyByAlias(NEW.taxonomy, 'taxonomy', 1, 'descendants');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`au_term_taxonomies` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`au_term_taxonomies`
AFTER UPDATE ON `edm`.`term_taxonomies`
FOR EACH ROW
BEGIN
    
    DECLARE taxonomy VARCHAR(55);

    
    IF NEW.parent_id <> OLD.parent_id THEN
            IF NEW.parent_id <> 0 THEN
                CALL offsetTermTaxProxyById(NEW.parent_id, 1, 'childCount'); 
            END IF;
            IF OLD.parent_id <> 0 THEN
                CALL offsetTermTaxProxyById(NEW.parent_id, -1, 'childCount'); 
            END IF;
    END IF;

    
    IF NEW.taxonomy <> OLD.taxonomy THEN
        
        
        IF NEW.parent_id = 0 THEN
            CALL offsetTermTaxProxyByAlias(NEW.taxonomy, 'taxonomy', 1, 'childCount');
        END IF;

        
        CALL offsetTermTaxProxyByAlias(NEW.taxonomy, 'taxonomy', 1, 'descendants');

        
        IF OLD.parent_id = 0 THEN
            CALL offsetTermTaxProxyByAlias(OLD.taxonomy, 'taxonomy', -1, 'childCount');
        END IF;

        
        CALL offsetTermTaxProxyByAlias(OLD.taxonomy, 'taxonomy', -1, 'descendants');

    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`ad_term_taxonomies` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`ad_term_taxonomies`
AFTER DELETE ON `edm`.`term_taxonomies`
FOR EACH ROW
BEGIN
    
    IF OLD.parent_id <> 0 THEN
        CALL offsetTermTaxProxyById(OLD.parent_id, -1, 'childCount'); 
    ELSE 
        CALL offsetTermTaxProxyByAlias(OLD.taxonomy, 'taxonomy', -1, 'childCount');
    END IF;

    
    CALL offsetTermTaxProxyByAlias(OLD.taxonomy, 'taxonomy', -1, 'descendants');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_addresses` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_addresses`
AFTER INSERT ON `edm`.`addresses`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.type, 'address-type', 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_addresses` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_addresses`
AFTER UPDATE ON `edm`.`addresses`
FOR EACH ROW
BEGIN
    
    IF NEW.type <> OLD.type THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.type, 'address-type', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.type, 'address-type', 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_addresses` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_addresses`
AFTER DELETE ON `edm`.`addresses`
FOR EACH ROW
BEGIN
    CALL offsetTermTaxProxyByAlias(OLD.type, 'address-type', -1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_posts` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_posts`
AFTER INSERT ON `edm`.`posts`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.type, 'post-type', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(NEW.accessGroup, 'user-group', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(NEW.status, 'post-status', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(NEW.commenting, 'commenting-status', 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_posts` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_posts`
AFTER UPDATE ON `edm`.`posts`
FOR EACH ROW
BEGIN
    
    IF NEW.type <> OLD.type THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.type, 'post-type', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.type, 'post-type', 1, 'assocItemCount');
    END IF;

    
    IF NEW.accessGroup <> OLD.accessGroup THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.accessGroup, 'user-group', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.accessGroup, 'user-group', 1, 'assocItemCount');

    END IF;

    
    IF NEW.status <> OLD.status THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.status, 'post-status', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.status, 'post-status', 1, 'assocItemCount');
    END IF;

    
    IF NEW.commenting <> OLD.commenting THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.commenting, 'commenting-status', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.commenting, 'commenting-status', 1, 'assocItemCount');
    END IF;

    
    UPDATE `date_info` 
        SET lastUpdated = UNIX_TIMESTAMP(),
            lastUpdatedById = NEW.post_id
        WHERE date_info_id=NEW.date_info_id;

END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_posts` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_posts`
AFTER DELETE ON `edm`.`posts`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(OLD.type, 'post-type', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(OLD.accessGroup, 'user-group', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(OLD.status, 'post-status', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(OLD.commenting, 'commenting-status', -1, 'assocItemCount');

END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_comments` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_comments`
AFTER INSERT ON `edm`.`comments`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.status, 'comment-status', 1, 'assocItemCount');
    
    UPDATE posts SET commentCount = commentCount + 1 WHERE post_id = NEW.post_id;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_comments` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_comments`
AFTER UPDATE ON `edm`.`comments`
FOR EACH ROW
BEGIN
    
    IF NEW.status <> OLD.status THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.status, 'comment-status', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.status, 'comment-status', 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_comments` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_comments`
AFTER DELETE ON `edm`.`comments`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(OLD.status, 'comment-status', -1, 'assocItemCount');
    
    UPDATE posts SET commentCount = commentCount - 1 WHERE post_id = OLD.post_id;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_contacts` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_contacts`
AFTER INSERT ON `edm`.`contacts`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.type, 'contact-type', 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_contacts` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_contacts`
AFTER UPDATE ON `edm`.`contacts`
FOR EACH ROW
BEGIN
    
    IF NEW.type <> OLD.type THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.type, 'contact-type', -1, 'assocItemCount');
        
        CALL offsetTermTaxProxyByAlias(NEW.type, 'contact-type', 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_contacts` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_contacts`
AFTER DELETE ON `edm`.`contacts`
FOR EACH ROW
BEGIN
	CALL offsetTermTaxProxyByAlias(OLD.type, 'contact-type', -1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_users` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_users`
AFTER INSERT ON `edm`.`users`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.role, 'user-group', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(NEW.accessGroup, 'user-group', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(NEW.status, 'user-status', 1, 'assocItemCount');

END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_users` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_users`
AFTER UPDATE ON `edm`.`users`
FOR EACH ROW
BEGIN
    
    IF NEW.role <> OLD.role THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.role, 'user-group', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.role, 'user-group', 1, 'assocItemCount');
    END IF;

    
    IF NEW.accessGroup <> OLD.accessGroup THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.accessGroup, 'user-group', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.accessGroup, 'user-group', 1, 'assocItemCount');

    END IF;

    
    IF NEW.status <> OLD.status THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.status, 'user-status', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.status, 'user-status', 1, 'assocItemCount');
    END IF;

    
    UPDATE `date_info` 
        SET lastUpdated = UNIX_TIMESTAMP(),
            lastUpdatedById = NEW.user_id
        WHERE date_info_id=NEW.date_info_id;

END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_users` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_users`
AFTER DELETE ON `edm`.`users`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(OLD.role, 'user-group', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(OLD.accessGroup, 'user-group', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias(OLD.status, 'user-status', -1, 'assocItemCount');

END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_flags` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_flags`
AFTER INSERT ON `edm`.`flags`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.objectType, 'flag-type', 1, 'assocItemCount');
    
    CALL offsetTermTaxProxyByAlias(NEW.flag, 'flag', 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_flags` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_flags`
AFTER UPDATE ON `edm`.`flags`
FOR EACH ROW
BEGIN
    
    IF NEW.objectType <> OLD.objectType THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.objectType, 'flag-type', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.objectType, 'flag-type', 1, 'assocItemCount');
    END IF;

    
    IF NEW.flag <> OLD.flag THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.flag, 'flag', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.flag, 'flag', 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_flags` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_flags`
AFTER DELETE ON `edm`.`flags`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(OLD.objectType, 'flag-type', -1, 'assocItemCount');
    
    CALL offsetTermTaxProxyByAlias(OLD.flag, 'flag', -1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_view_modules` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_view_modules`
AFTER INSERT ON `edm`.`view_modules`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.type, 'view-module-type', 1, 'assocItemCount');
    
    CALL offsetTermTaxProxyByAlias(NEW.helperType, 'helper-type', 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_view_modules` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_view_modules`
AFTER UPDATE ON `edm`.`view_modules`
FOR EACH ROW
BEGIN
    
    IF NEW.type <> OLD.type THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.type, 'view-module-type', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.type, 'view-module-type', 1, 'assocItemCount');
    END IF;

    
    IF NEW.helperType <> OLD.helperType THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.helperType, 'helper-type', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.helperType, 'helper-type', 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_view_modules` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_view_modules`
AFTER DELETE ON `edm`.`view_modules`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(OLD.type, 'view-module-type', -1, 'assocItemCount');
    
    CALL offsetTermTaxProxyByAlias(OLD.helperType, 'helper-type', -1, 'assocItemCount');

END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_pages` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_pages`
AFTER INSERT ON `edm`.`pages`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias(NEW.type, 'page-type', 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_pages` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_pages`
AFTER UPDATE ON `edm`.`pages`
FOR EACH ROW
BEGIN
    
    IF NEW.type <> OLD.type THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.type, 'page-type', -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyByAlias(NEW.type, 'page-type', 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_pages` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_pages`
AFTER DELETE ON `edm`.`pages`
FOR EACH ROW
BEGIN    
    CALL offsetTermTaxProxyByAlias(OLD.type, 'page-type', -1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_postCategoryRels` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_postCategoryRels`
AFTER INSERT ON `edm`.`post_category_relationships`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyById(NEW.term_taxonomy_id, 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_postCategoryRels` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_postCategoryRels`
AFTER UPDATE ON `edm`.`post_category_relationships`
FOR EACH ROW
BEGIN
    
    IF NEW.term_taxonomy_id <> OLD.term_taxonomy_id THEN
        
        CALL offsetTermTaxProxyById(OLD.term_taxonomy_id, -1, 'assocItemCount');

        
        CALL offsetTermTaxProxyById(NEW.term_taxonomy_id, 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_postCategoryRels` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_postCategoryRels`
AFTER DELETE ON `edm`.`post_category_relationships`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyById(OLD.term_taxonomy_id, -1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_insert_on_mixedTermRels` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_insert_on_mixedTermRels`
AFTER INSERT ON `edm`.`mixed_term_relationships`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias (NEW.objectType, 'mixed-term-type', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias (NEW.status, 'post-status', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias (NEW.accessGroup, 'user-group', 1, 'assocItemCount');

    
    CALL offsetTermTaxProxyById (NEW.term_taxonomy_id, 1, 'assocItemCount');
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_update_on_mixedTermRels` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_update_on_mixedTermRels`
AFTER UPDATE ON `edm`.`mixed_term_relationships`
FOR EACH ROW
BEGIN
    
    IF NEW.objectType <> OLD.objectType THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.objectType, 'mixed-term-type', -1, 'assocItemCount');
        
        CALL offsetTermTaxProxyByAlias(NEW.objectType, 'mixed-term-type', 1, 'assocItemCount');
    END IF;

    
    IF NEW.status <> OLD.status THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.status, 'post-status', -1, 'assocItemCount');
        
        CALL offsetTermTaxProxyByAlias(NEW.status, 'post-status', 1, 'assocItemCount');
    END IF;

    
    IF NEW.accessGroup <> OLD.accessGroup THEN
        
        CALL offsetTermTaxProxyByAlias(OLD.accessGroup, 'user-group', -1, 'assocItemCount');
        
        CALL offsetTermTaxProxyByAlias(NEW.accessGroup, 'user-group', 1, 'assocItemCount');
    END IF;

    
    IF NEW.term_taxonomy_id <> OLD.term_taxonomy_id THEN
        
        CALL offsetTermTaxProxyById(OLD.term_taxonomy_id, -1, 'assocItemCount');
        
        CALL offsetTermTaxProxyById(NEW.term_taxonomy_id, 1, 'assocItemCount');
    END IF;
END$$

SHOW WARNINGS$$

USE `edm`$$
DROP TRIGGER IF EXISTS `edm`.`after_delete_on_mixedTermRels` $$
SHOW WARNINGS$$
USE `edm`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `edm`.`after_delete_on_mixedTermRels`
AFTER DELETE ON `edm`.`mixed_term_relationships`
FOR EACH ROW
BEGIN
    
    CALL offsetTermTaxProxyByAlias (OLD.objectType, 'mixed-term-type', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias (OLD.status, 'post-status', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyByAlias (OLD.accessGroup, 'user-group', -1, 'assocItemCount');

    
    CALL offsetTermTaxProxyById (OLD.term_taxonomy_id, -1, 'assocItemCount');
END$$

SHOW WARNINGS$$

DELIMITER ;
