-- File: terms_and_term_taxonomies-data.sql
-- Created: 10/13/2013
-- Author: Ely De La Cruz 
-- Email: elycruz@elycruz.com
-- Description: Resets terms and term_taxonomies to their expected baselines 
-- and sets all our default facts.
-- ** Note ** Run file after running './sql/triggers/term_taxonomies.triggers'.
-- ** Note ** Both terms and term_taxonomies zero baselines are in this one
--   file (makes editing it easier).
-- 

-- ----------------------------------------------------------------------------
-- Set database.
-- ----------------------------------------------------------------------------
USE `ecms`;

-- Clear term taxonomies
DELETE FROM term_taxonomies;

-- Clear terms
DELETE FROM terms;

# #############################################################################
# BEGIN DATA INSERTS BELOW 
# #############################################################################

-- ----------------------------------------------------------------------------
-- Base Taxonomy terms
-- ----------------------------------------------------------------------------
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('address-type', 'Address Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('comment-status', 'Comment Status');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('commenting-status', 'Commenting Status');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('contact-type', 'Contact Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('helper-type', 'Helper Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('extender-table', 'Extender table');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('mixed-term-type', 'Mixed Term Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('not-allowed-as-extender-table', 'Not allowed as Extender table');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('page-type', 'Page Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('phone-type', 'Phone Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('post-category', 'Post Category');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('post-status', 'Post Status');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('post-type', 'Post Type');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('security-question', 'Security Question');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('tag', 'Tag');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('taxonomy', 'Taxonomy');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('ui-position', 'Ui Position');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('uncategorized', 'Uncategorized');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('user-group', 'User Group');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('user-status', 'User Status');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('view-module-type', 'View Module Type');

-- ----------------------------------------------------------------------------
-- Base User Groups terms
-- ----------------------------------------------------------------------------
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('guest', 'Guest');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('user', 'User');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-guest', 'Cms Guest');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-user', 'Cms User');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-author', 'Cms Author');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-editor', 'Cms Editor');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-publisher', 'Cms Publisher');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-manager', 'Cms Manager');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('cms-super-admin', 'Cms Super Admin');

-- ----------------------------------------------------------------------------
-- Base Contact Type terms
-- ----------------------------------------------------------------------------
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('created-by-user', 'Created by User');
INSERT INTO `terms` (`term_alias`, `term_name`) VALUES ('created-by-system', 'Created by System');

-- ----------------------------------------------------------------------------
-- Other Base terms
-- ----------------------------------------------------------------------------
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('action','Action Helper','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('activated','Activated','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('approved','Approved','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('archived','Archived','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('blog','Blog','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('business','Business','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('commercial','Commercial','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('deactivated','Deactivated','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('disabled','Disabled','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('disapproved','Disapproved','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('draft','Draft','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('enabled','Enabled','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('gallery','Gallery','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('home','Home','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('html','Html','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('media','Media','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('menu','Menu','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('mvc','Mvc','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('none','None','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('page','Page','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('personal','Personal','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('pending-activation','Pending activation','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('post','Post','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('published','Published','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('spam','Spam','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('unpublished','Unpublished','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('uri','Uri','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('view','View Helper','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('view-module','View Module','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('what-is-the-make-and-color-of-your-first-car-','What is the make and color of your first car?','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('what-is-the-name-of-your-elementary-school-','What is the name of your elementary school?','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('what-is-your-mother-s-maiden-name-','What is your mothers maiden name?','');
INSERT INTO `terms` (`term_alias`,`term_name`,`term_group_alias`) VALUES ('work','Work','');

# #############################################################################
# TAXONOMIES AND THEIR CONSTITUENTS BELOW 
# #############################################################################

-- ----------------------------------------------------------------------------
-- Base Taxonomies
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('taxonomy','taxonomy','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('user-group','taxonomy','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('address-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('comment-status','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('commenting-status','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('contact-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('extender-table','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('page-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('helper-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('not-allowed-as-extender-table','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('phone-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('post-category','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('post-status','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('post-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('security-question','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('tag','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('ui-position','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('uncategorized','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('user-status','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('view-module-type','taxonomy','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('mixed-term-type','taxonomy','','cms-manager');

-- ----------------------------------------------------------------------------
-- Base User Group Taxonomies
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('guest','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('user','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-guest','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-user','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-author','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-editor','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-publisher','user-group','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-manager','user-group','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('cms-super-admin','user-group','','cms-super-admin');

-- ----------------------------------------------------------------------------
-- Base Contact Type taxonomies
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('created-by-user','contact-type','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('created-by-system','contact-type','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('user','contact-type','','cms-super-admin');

-- ----------------------------------------------------------------------------
-- Address Type taxonomies
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('business','address-type','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('commercial','address-type','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('home','address-type','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('personal','address-type','','cms-super-admin');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('work','address-type','','cms-super-admin');

# #############################################################################
-- OTHER BASE TAXONOMIES BELOW ------------------------------------------------
# #############################################################################

-- ----------------------------------------------------------------------------
-- Comment Statuses
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('approved','comment-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('disapproved','comment-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('spam','comment-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('disabled','commenting-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('enabled','commenting-status','','cms-manager');

-- ----------------------------------------------------------------------------
-- Helper Types
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('action','helper-type','Action Helper Type.','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('view','helper-type','View Helper Type.','cms-manager');

-- ----------------------------------------------------------------------------
-- Page Types
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('uri','page-type','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('mvc','page-type','','cms-manager');

-- ----------------------------------------------------------------------------
-- Ui Positions
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('uncategorized','ui-position','','cms-manager');

-- ----------------------------------------------------------------------------
-- Post Categories
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('blog','post-category','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('uncategorized','post-category','','cms-manager');

-- ----------------------------------------------------------------------------
-- Post Statuses
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('archived','post-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('draft','post-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('published','post-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('unpublished','post-status','','cms-manager');

-- ----------------------------------------------------------------------------
-- Mixed Term Types
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('view-module','mixed-term-type','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('page','mixed-term-type','','cms-manager');

-- ----------------------------------------------------------------------------
-- Post Types
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('gallery','post-type','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('media','post-type','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('post','post-type','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('page','post-type','','cms-manager');

-- ----------------------------------------------------------------------------
-- Security Questions
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('what-is-your-mother-s-maiden-name-','security-question','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('what-is-the-make-and-color-of-your-first-car-','security-question','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('what-is-the-name-of-your-elementary-school-','security-question','','cms-manager');

-- ----------------------------------------------------------------------------
-- Uncategorized item
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('none','uncategorized','','cms-manager');

-- ----------------------------------------------------------------------------
-- User Statuses
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('activated','user-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('deactivated','user-status','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('pending-activation','user-status','','cms-manager');

-- ----------------------------------------------------------------------------
-- View Module Types
-- ----------------------------------------------------------------------------
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('menu','view-module-type','','cms-manager');
INSERT INTO `term_taxonomies` (`term_alias`,`taxonomy`,`description`,`accessGroup`) VALUES ('html','view-module-type','','cms-manager');
