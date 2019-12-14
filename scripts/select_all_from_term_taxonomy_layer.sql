SELECT t1.*, t2.childCount, t2.assocItemCount, t2.descendants,
	t3.term_name, t3.term_group_alias
	FROM `ecms`.`term_taxonomies` as t1
    JOIN (`ecms`.`term_taxonomies_proxy` t2)
    JOIN (`ecms`.`terms` t3)
	WHERE (t2.term_taxonomy_id = t1.term_taxonomy_id) AND (t3.term_alias=t1.term_alias);
    