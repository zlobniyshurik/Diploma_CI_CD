# INSTALL_WORDPRESS

## Выполняемые действия
- Устанавливает **`WordPress`** в требуемой конфигурации.

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **install_wordpress_db_host** | Имя или IP хоста, с базой данных для `WordPress` || **db.example.com** |
| **install_wordpress_db_name** | Имя базы данных `WordPress` || **wordpress** |
| **install_wordpress_db_pass** | Пароль для подключения к БД `WordPress` || **wordpress** |
| **install_wordpress_db_user** | Логин для подключения к БД `WordPress`|| **wordpress** |
| **install_wordpress_dir** | Каталог, куда будет устанавливаться `WordPress` || **/var/www**|
| **install_wordpress_my_domain_tld** | Имя сайта | *Пока ни на что не влияет* | **www.example.com** |
| **install_wordpress_url** | URL, откуда выкачивается дистрибутив сайта || **https://ru.wordpress.org/wordpress-{{ install_wordpress_ver }}-ru_RU.zip** |
| **install_wordpress_ver** | Версия устанавливаемого `WordPress`а || **6.0** |
| **install_wordpress_www_group** | Группа, под которой запущен веб-сервер || **nginx** |
| **install_wordpress_www_user** | Пользователь, под которым запущен веб-сервер || **nginx** |
