# ecms-domain-model-mysql
A "zero-baseline" database for building CMSs.

## Prerequisites:
- MySQL 8.0+

## Default Tables
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

## Installing the database
### On Windows:
- `$ zero_baseline.bat`.

### On *nix:
- `$ sh zero_baseline.sh`.

### Other ways to install the database:
- Run `mysql -h localhost -u root -p < zero_baseline.mysql_batch -vvv` ((-vvv) is verbose mode)
- Run an OS specific batch script (for windows users run `zero_baseline.bat` from cmd/powershell).
- Manually build up the database script by script (scripts are in `./scripts`) (look inside the
    `zero_baseline.mysql_batch` to get an idea of the necessary scripts
    and their executed order).

## License
BSD-3-Clause
