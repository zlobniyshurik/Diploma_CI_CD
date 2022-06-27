# INSTALL_APP

## Выполняемые действия

1. Устанавливает **`PHP`** заданной версии *(через роль ***install_php***)*

2. Устанавливает **`nginx`** заданной версии *(через роль ***install_nginx***)*

3. Открывает доступ через фаерволл по протоколу **`HTTP`**

4. Устанавливает **`WordPress`** заданной версии *(через роль ***install_wordpress***)*

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :---: |
| **install_app_db_host** | FQDN сервера, содержащего БД для **WordPress**| | **`db.example.com`** |
| **install_app_db_name** | Имя базы данных для **Wordpress** | | **`db_base`** |
| **install_app_db_pass** | Пароль БД для **WordPress** | | **`password`**|
| **install_app_db_user** | Имя пользователя БД для **WordPress** | | **`user`** |
| **install_app_my_domain_tld** | Имя домена  | *Пока это больше декоративная настройка* | **`example.com`** |
| **install_app_nginx_ver** | Требуемая версия **nginx** | Версии, доступные для используемой версии `CentOS`/`Fedora` | **`1.20`** |
| **install_app_php_ver** | Требуемая версия **PHP** | Версии, доступные для используемой версии `CentOS`/`Fedora` | **`8.0`** |
| **install_app_web_dir** | Имя каталога, куда будет установлен **WordPress** | | **`/var/www`** |
| **install_app_wordpress_ver** | Требуемая версия **WordPress** | | **`6.0`** |
