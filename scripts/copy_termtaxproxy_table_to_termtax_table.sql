-- Add count columns to `term_taxonomies` table
ALTER TABLE `term_taxonomies` ADD COLUMN `childCount` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE `term_taxonomies` ADD COLUMN `assocItemCount` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE `term_taxonomies` ADD COLUMN `descendantCount` BIGINT(20) NOT NULL DEFAULT 0;

-- Copy all 'count' values from `term_taxonomies_proxy` table
UPDATE
  `term_taxonomies` as t1,
  `term_taxonomies_proxy` as t2
  SET
    t1.childCount=t2.childCount,
    t1.assocItemCount=t2.assocItemCount,
    t1.descendantCount=t2.descendants
  WHERE
    t1.term_taxonomy_id= t2.term_taxonomy_id
;



