-- MySQL Script generated by MySQL Workbench
-- Fri Dec 13 20:29:22 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecms
-- -----------------------------------------------------
-- The Extensible Content Management database - A database for extensible cms like applications.
DROP SCHEMA IF EXISTS `ecms` ;

-- -----------------------------------------------------
-- Schema ecms
--
-- The Extensible Content Management database - A database for extensible cms like applications.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecms` ;
USE `ecms` ;

-- -----------------------------------------------------
-- Table `ecms`.`terms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`terms` (
  `term_alias` VARCHAR(55) NOT NULL DEFAULT '',
  `term_name` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Term or term value.',
  `term_group_alias` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Terms group alias.  Used for grouping terms.',
  PRIMARY KEY (`term_alias`))
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ecms`.`term_taxonomies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`term_taxonomies` (
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_alias` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Term alias.',
  `taxonomy` VARCHAR(55) NOT NULL DEFAULT '' COMMENT 'Taxonomies category.',
  `description` TEXT NOT NULL,
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'cms-manager' COMMENT 'Access group of who can edit/access this term term taxonomy.  For admin side of things (useful for CMSs (Content Management Systems) and the like).',
  `order` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Ordering.',
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Parent term taxonomy (if any).',
  `access_group_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Access control list access group (should reference `term_taxonomies.term_taxonomy_id` or `0`).',
  `locale_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Locale id (should reference `term_taxonomies.term_taxonomy_id` or `0`).',
  PRIMARY KEY (`term_taxonomy_id`),
  INDEX `tt_term_alias_idx` (`term_alias` ASC) VISIBLE,
  INDEX `tt_accessGroup_idx` (`accessGroup` ASC) VISIBLE,
  INDEX `tt_taxonomy_idx` (`taxonomy` ASC) VISIBLE,
  CONSTRAINT `tt_term_alias_fk`
    FOREIGN KEY (`term_alias`)
    REFERENCES `ecms`.`terms` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `tt_taxonomy_fk`
    FOREIGN KEY (`taxonomy`)
    REFERENCES `ecms`.`terms` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `tt_accessGroup_fk`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `ecms`.`terms` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `ecms`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`addresses` (
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
  UNIQUE INDEX `addresses_name_uidx` (`name` ASC) VISIBLE,
  INDEX `addresses_fk_1_idx` (`type` ASC) VISIBLE,
  CONSTRAINT `addresses_fk_1`
    FOREIGN KEY (`type`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`date_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`date_info` (
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


-- -----------------------------------------------------
-- Table `ecms`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`posts` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `type` VARCHAR(55) NOT NULL DEFAULT 'post',
  `status` VARCHAR(55) NOT NULL DEFAULT 'unpublished',
  `title` VARCHAR(255) NOT NULL DEFAULT '',
  `alias` VARCHAR(200) NOT NULL DEFAULT '',
  `content` LONGTEXT NOT NULL,
  `excerpt` VARCHAR(2048) NOT NULL DEFAULT '',
  `hits` BIGINT(20) NOT NULL DEFAULT '0',
  `order` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `commenting` VARCHAR(55) NOT NULL DEFAULT 'disabled',
  `commentCount` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'guest',
  `userParams` LONGTEXT NOT NULL,
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`post_id`),
  UNIQUE INDEX `posts_alias_uidx` (`alias` ASC) VISIBLE,
  INDEX `posts_fk5_idx` (`date_info_id` ASC) VISIBLE,
  INDEX `posts_fk1_idx` (`commenting` ASC) VISIBLE,
  INDEX `posts_fk2_idx` (`type` ASC) VISIBLE,
  INDEX `posts_fk3_idx` (`status` ASC) VISIBLE,
  INDEX `posts_fk4_idx` (`accessGroup` ASC) VISIBLE,
  CONSTRAINT `posts_fk1`
    FOREIGN KEY (`commenting`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk2`
    FOREIGN KEY (`type`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk3`
    FOREIGN KEY (`status`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk4`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `posts_fk5`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `ecms`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `ecms`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`comments` (
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
  INDEX `comments_fk1_idx` (`post_id` ASC) VISIBLE,
  INDEX `comments_fk3_idx` (`date_info_id` ASC) VISIBLE,
  INDEX `comments_fk2_idx` (`status` ASC) VISIBLE,
  CONSTRAINT `comments_fk2`
    FOREIGN KEY (`status`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `comments_fk3`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `ecms`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comments_f4`
    FOREIGN KEY (`post_id`)
    REFERENCES `ecms`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`contacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`contacts` (
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
  UNIQUE INDEX `contacts_email1_uidx` (`email` ASC) VISIBLE,
  INDEX `contacts_fk_3_idx` (`type` ASC) VISIBLE,
  CONSTRAINT `contacts_fk_3`
    FOREIGN KEY (`type`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `ecms`.`contact_address_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`contact_address_relationships` (
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `address_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`contact_id`, `address_id`),
  INDEX `contact_address_rels_fk1_idx` (`contact_id` ASC) VISIBLE,
  INDEX `contact_address_rels_fk2_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `contact_address_rels_fk1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `ecms`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_address_rels_fk2`
    FOREIGN KEY (`address_id`)
    REFERENCES `ecms`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ecms`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`users` (
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
  UNIQUE INDEX `users_screenName_uidx` (`screenName` ASC) VISIBLE,
  INDEX `users_fk_1_idx` (`role` ASC) VISIBLE,
  INDEX `users_fk_5_idx` (`date_info_id` ASC) VISIBLE,
  INDEX `users_fk_4_idx` (`status` ASC) VISIBLE,
  INDEX `users_fk_3_idx` (`accessGroup` ASC) VISIBLE,
  INDEX `users_fk_6_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `users_fk_3`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `users_fk_4`
    FOREIGN KEY (`status`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `users_fk_5`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `ecms`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `users_fk_1`
    FOREIGN KEY (`role`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `users_fk_6`
    FOREIGN KEY (`contact_id`)
    REFERENCES `ecms`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `ecms`.`contact_created_by_user_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`contact_created_by_user_relationships` (
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  INDEX `ccby_fk_1_idx` (`user_id` ASC) VISIBLE,
  INDEX `ccby_fk_2_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `ccby_fk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecms`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ccby_fk_2`
    FOREIGN KEY (`contact_id`)
    REFERENCES `ecms`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ecms`.`flags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`flags` (
  `object_id` BIGINT(20) NOT NULL DEFAULT '0',
  `objectType` VARCHAR(55) NOT NULL DEFAULT '',
  `flag` VARCHAR(55) NOT NULL DEFAULT '',
  `flaggerIp` VARCHAR(128) NOT NULL DEFAULT '',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `date_info_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  INDEX `flags_fk_3_idx` (`date_info_id` ASC) VISIBLE,
  PRIMARY KEY (`object_id`, `objectType`, `flaggerIp`),
  INDEX `flags_fk_2_idx` (`flag` ASC) VISIBLE,
  INDEX `flags_fk_1_idx` (`objectType` ASC) VISIBLE,
  CONSTRAINT `flags_fk_1`
    FOREIGN KEY (`objectType`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `flags_fk_2`
    FOREIGN KEY (`flag`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `flags_fk_3`
    FOREIGN KEY (`date_info_id`)
    REFERENCES `ecms`.`date_info` (`date_info_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`galleries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`galleries` (
  `gallery_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `objectRelId` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectRelType` VARCHAR(55) NOT NULL DEFAULT '',
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`gallery_id`),
  INDEX `gallery_fk1_idx` (`post_id` ASC) VISIBLE,
  INDEX `gallery_fk2_idx` (`objectRelType` ASC) VISIBLE,
  CONSTRAINT `gallery_fk2`
    FOREIGN KEY (`objectRelType`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `gallery_fk1`
    FOREIGN KEY (`post_id`)
    REFERENCES `ecms`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`view_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`view_modules` (
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
  UNIQUE INDEX `view_modules_alias_UNIQUE` (`alias` ASC) VISIBLE,
  INDEX `view_modules_fk_1_idx` (`type` ASC) VISIBLE,
  INDEX `view_modules_fk_2_idx` (`helperType` ASC) VISIBLE,
  CONSTRAINT `view_modules_fk_1`
    FOREIGN KEY (`type`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `view_modules_fk_2`
    FOREIGN KEY (`helperType`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
COMMENT = '@todo should drop html_id and html_class for htmlAttribs';


-- -----------------------------------------------------
-- Table `ecms`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`menus` (
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
  `menuHelperName` VARCHAR(55) NOT NULL DEFAULT 'EcmsMenu',
  PRIMARY KEY (`menu_id`),
  INDEX `menu_fk1` (`view_module_id` ASC) VISIBLE,
  CONSTRAINT `menus_fk1`
    FOREIGN KEY (`view_module_id`)
    REFERENCES `ecms`.`view_modules` (`view_module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
;


-- -----------------------------------------------------
-- Table `ecms`.`pages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`pages` (
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
  UNIQUE INDEX `pages_alias_uidx` (`alias` ASC) VISIBLE,
  INDEX `pages_fk1_idx` (`type` ASC) VISIBLE,
  CONSTRAINT `pages_fk1`
    FOREIGN KEY (`type`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table `ecms`.`page_menu_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`page_menu_relationships` (
  `menu_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `page_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`menu_id`, `page_id`),
  INDEX `page_menu_rel_fk1` (`menu_id` ASC) VISIBLE,
  INDEX `page_menu_rel_fk2` (`page_id` ASC) VISIBLE,
  CONSTRAINT `page_menu_rel_fk1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `ecms`.`menus` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `page_menu_rel_fk2`
    FOREIGN KEY (`page_id`)
    REFERENCES `ecms`.`pages` (`page_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`media` (
  `media_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `mimeType` VARCHAR(55) NOT NULL DEFAULT '',
  `filePath` VARCHAR(255) NOT NULL DEFAULT '',
  `order` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectRelId` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectRelType` VARCHAR(55) NOT NULL DEFAULT 'post',
  PRIMARY KEY (`media_id`),
  INDEX `media_fk_1_idx` (`post_id` ASC) VISIBLE,
  INDEX `media_objectRelId_idx` (`objectRelId` ASC) VISIBLE,
  INDEX `media_fk_2_idx` (`objectRelType` ASC) VISIBLE,
  CONSTRAINT `media_fk_2`
    FOREIGN KEY (`objectRelType`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `media_fk_1`
    FOREIGN KEY (`post_id`)
    REFERENCES `ecms`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`post_category_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`post_category_relationships` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`, `term_taxonomy_id`),
  INDEX `term_rel_fk_1_idx` (`term_taxonomy_id` ASC) VISIBLE,
  INDEX `term_rel_fk_5_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `term_rel_fk_1`
    FOREIGN KEY (`term_taxonomy_id`)
    REFERENCES `ecms`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `term_rel_fk_5`
    FOREIGN KEY (`post_id`)
    REFERENCES `ecms`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ecms`.`security_question_user_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`security_question_user_relationships` (
  `security_question_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `answer` VARCHAR(45) NULL DEFAULT '',
  INDEX `user_q_and_a_rels_fk1_idx` (`security_question_id` ASC) VISIBLE,
  INDEX `user_q_and_a_rels_fk2_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_q_and_a_rels_fk2`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecms`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_q_and_a_rels_fk1`
    FOREIGN KEY (`security_question_id`)
    REFERENCES `ecms`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`sessions` (
  `id` VARCHAR(32) NOT NULL DEFAULT '',
  `savePath` VARCHAR(32) NOT NULL DEFAULT '',
  `name` VARCHAR(32) NOT NULL DEFAULT '',
  `modified` BIGINT(20) NOT NULL DEFAULT '0',
  `lifetime` BIGINT(20) NOT NULL DEFAULT '0',
  `data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `savePath`, `name`))
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ecms`.`mixed_term_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`mixed_term_relationships` (
  `object_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `objectType` VARCHAR(55) NOT NULL DEFAULT 'view-module',
  `term_taxonomy_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `status` VARCHAR(55) NOT NULL DEFAULT 'unpublished',
  `accessGroup` VARCHAR(55) NOT NULL DEFAULT 'guest',
  `order` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`, `objectType`, `term_taxonomy_id`),
  INDEX `mixed_term_rels_fk1_idx1` (`term_taxonomy_id` ASC) VISIBLE,
  INDEX `mixed_term_rels_fk3_idx` (`accessGroup` ASC) VISIBLE,
  INDEX `mixed_term_rels_fk2_idx` (`status` ASC) VISIBLE,
  CONSTRAINT `mixed_term_rels_fk2`
    FOREIGN KEY (`status`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `mixed_term_rels_fk3`
    FOREIGN KEY (`accessGroup`)
    REFERENCES `ecms`.`term_taxonomies` (`term_alias`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `mixed_term_rels_fk1`
    FOREIGN KEY (`term_taxonomy_id`)
    REFERENCES `ecms`.`term_taxonomies` (`term_taxonomy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`user_activation_keys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`user_activation_keys` (
  `user_activation_key` VARCHAR(32) NOT NULL DEFAULT '',
  `createdDate` BIGINT(20) NOT NULL DEFAULT '0',
  `user_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_activation_key`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_activation_keys_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ecms`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;


-- -----------------------------------------------------
-- Table `ecms`.`user_contact_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`user_contact_relationships` (
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `screenName` VARCHAR(55) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`, `screenName`),
  UNIQUE INDEX `user_rels_email_uidx` (`email` ASC) VISIBLE,
  UNIQUE INDEX `user_rels_screenName_uidx` (`screenName` ASC) VISIBLE,
  INDEX `user_rels_fk_1_idx` (`screenName` ASC) VISIBLE,
  INDEX `user_rels_fk_2_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `user_rels_fk_1`
    FOREIGN KEY (`screenName`)
    REFERENCES `ecms`.`users` (`screenName`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `user_rels_fk_2`
    FOREIGN KEY (`email`)
    REFERENCES `ecms`.`contacts` (`email`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`phone_numbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`phone_numbers` (
  `phone_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL DEFAULT '',
  `country_code` VARCHAR(10) NOT NULL DEFAULT '',
  `area_code` VARCHAR(10) NOT NULL DEFAULT '',
  `state_code` VARCHAR(10) NOT NULL DEFAULT '',
  `number` VARCHAR(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`phone_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecms`.`contact_phone_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecms`.`contact_phone_relationships` (
  `phone_id` BIGINT(20) UNSIGNED NOT NULL,
  `contact_id` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`phone_id`),
  INDEX `contact_phone_rels_fk1` (`phone_id` ASC) VISIBLE,
  INDEX `contact_phone_rels_fk2` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `contact_phone_relationships_fk1`
    FOREIGN KEY (`phone_id`)
    REFERENCES `ecms`.`phone_numbers` (`phone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_phone_relationships_fk2`
    FOREIGN KEY (`contact_id`)
    REFERENCES `ecms`.`contacts` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
