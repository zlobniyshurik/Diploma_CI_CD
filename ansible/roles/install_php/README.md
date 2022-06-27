# INSTALL_PHP

## Выполняемые действия

- Установка заданной версии **PHP** *(Состав устанавливаемых пакетов задаётся в ***defaults/main.yml***)*

- Возможен запуск/перезапуск/остановка сервиса **php-fpm** и включение/выключение его автозапуска *(зависит от настроек)*



## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **install_php_enabled** | Запускать ли сервис **php-fpm** после установки. | `true`/`false` | **`true`** |
| **install_php_packages** | Список устанавливаемых пакетов PHP | Имя пакета **php** задаётся в виде<br> `"@php:{{ install_php_ver }}/common"`  | <ul><li>php</li><li>php-fpm</li><li>php-gd</li><li>php-mysqlnd</li><li>php-json</li><li>php-mbstring</li><li>php-pdo</li><li>php-pecl-zip</li><li>php-xml</li></ul>|
| **install_php_state** | Состояние сервиса **php-fpm** после установки | `started`/`reloaded`/`restarted`/`stopped` | **`started`** |
| **install_php_ver** | Требуемая версия **PHP** | | **`8.0`** |


  
