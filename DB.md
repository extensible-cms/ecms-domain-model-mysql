# ecms

## Db:

### Features
----
- Domain modeled using MySql Workbench (6.0+) (to make it easily extendable).
- MySQL batch scripts for building and testing the db `./*.mysql_batch`.
- Taxonomy based facts;  I.e., categories, statuses, tags, types, etc (see tables ->
    `terms`, `term_taxonomies`, `term_taxonomies_proxy` or mysql workbench
    model -> `./models/edm-no-cascade-no-triggers.mwb`).
- Salt storing for password hashing (see `users` table)
- Easily extendable post and view_module system (see the `posts` and `media`
tables for an extended post example -- and see the `view_modules` and `menu` tables for
an exetnded view_module example)
- and more...

### Default Tables
----
```
+---------------------------------------+
| addresses                             |
| comments                              |
| contact_address_relationships         |
| contact_created_by_user_relationships |
| contact_phone_relationships           |
| contacts                              |
| date_info                             |
| flags                                 |
| galleries                             |
| media                                 |
| menus                                 |
| mixed_term_relationships              |
| page_menu_relationships               |
| pages                                 |
| phone_numbers                         |
| post_category_relationships           |
| posts                                 |
| security_question_user_relationships  |
| sessions                              |
| term_taxonomies                       |
| term_taxonomies_proxy                 |
| terms                                 |
| user_contact_relationships            |
| users                                 |
| view_modules                          |
+---------------------------------------+
```

### Installing the Edm database
To install the edm database with the available scripts do one of the following:

#### Easy way:
##### Windows users:
Run `sql/zero_baseline.bat`.

##### Linux users:
Run `sh sql/zero_baseline.sh`.

#### Other ways to install the database (do one of the following):
1. Run `mysql -h localhost -u root -p < zero_baseline.mysql_batch -vvv` ((-vvv) is verbose mode)
2. Run an OS specific batch script (for windows users run `zero_baseline.bat` from cmd/powershell).
3. Manually build up the database script by script (scripts are in `./sql`) (look inside the
    `zero_baseline.mysql_batch` to get an idea of the necessary scripts
    and their suggested* order) ("suggested" meaning for each ordered item
    in the batch script the "previous item" appeases requirements of the "next item". (foreign
    key requirements and foreign key access requirements from within triggers of "next item"
    are in some cases taken care of by the "previous item", etc.).
