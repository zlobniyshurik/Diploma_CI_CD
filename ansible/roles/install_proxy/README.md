# INSTALL_PROXY

## Выполняемые действия
1. Устанавливается **`nginx`**

2. Устанавливается скрипт **`acme.sh`**, обеспечивающий получение `HTTPS`-сертификатов с **Let's Encrypt**

3. Открывает доступ на фаерволе к `HTTP/HTTPS` и к `MySQL`-сервисам *(на случай, если используется MySQL-балансер)*.

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **proxy_my_domain_tld** | Имя домена, в котором живёт реверс-прокси|| **example.com** |
| **proxy_settings** | Параметры апстримов для разных сайтов в домене| *Описание дано ниже*||

Структура **proxy_settings**  
```
proxy_settings:  
     site1:  
         server_string: Имена для site1 (через пробел)  
         server_log_dir: Имя подкаталога логов для site1  
         proxy_pass: Апстрим-сервер для site1  
     site2:  
         server_string: "site2.{{ proxy_my_domain_tld }}"  
         server_log_dir: "site2"  
         proxy_pass: "site2-upstream.{{ proxy_my_domain_tld }}"  
     ...
```
