-- Created: 08/26/208
-- Author: Ely De La Cruz
-- Description: Removes term_taxonomies triggers.
-- @Note triggers are only used when hydrating the database with it's
--   default values.  The same trigger logic here is left up to library
--   implementers to implement.
--

-- ----------------------------------------------------------------------------
-- Set database.
-- ----------------------------------------------------------------------------
USE `edm`;

-- Drop `term_taxonomies` triggers
DROP TRIGGER IF EXISTS `edm`.`bi_term_taxonomies`;
DROP TRIGGER IF EXISTS `edm`.`ai_term_taxonomies`;
DROP TRIGGER IF EXISTS `edm`.`bu_term_taxonomies`;
DROP TRIGGER IF EXISTS `edm`.`au_term_taxonomies`;
DROP TRIGGER IF EXISTS `edm`.`bd_term_taxonomies`;
DROP TRIGGER IF EXISTS `edm`.`ad_term_taxonomies`;
