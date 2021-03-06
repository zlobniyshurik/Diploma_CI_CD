# INSTALL_GITLAB

## Выполняемые действия:
1. Устанавливает необходимые для **`GitLab`** зависимости

2. Открывает в фаерволе доступ по **`HTTP`** из локальной сети *(зона ***`home`***)*

3. Устанавливает, если необходимо, **`Postfix`** *(для отправки почты **`GitLab`**'ом)*

4. Настраивает репозиторий **`GitLab`**'а

5. Устанавливает **`GitLab`**

6. Задаёт первоначальные настройки *(имя сайта, пароль root-учётки, e.t.c.)*

7. Запускает конфигуратор, применяющий настройки из пункта **6**.

## Переменные
***defaults/main.yml***
| Имя переменной | Описание | Возможные значения/Примечания | Значение по умолчанию |
| :--- | :--- | :--- | :---: |
| **install_gitlab_ca_cert** | Путь к CA-сертификату || **/opt/LEscript/certs/example.com/ca.cer** |
| **install_gitlab_cert_key** | Путь к ключу сертификата | | **opt/LEscript/certs/example.com/example.com.key** |
| **install_gitlab_external_url** | Внешний URL `GitLab`'а, по которому на него можно войти.||**http://gitlab.example.com**|
| **install_gitlab_fullchain_cert** | Путь к fullchain сертификату || **opt/LEscript/certs/example.com/fullchain.cer** |
| **install_gitlab_le_enabled** | Включать ли встроенный клиент `Let's Encrypt` | `"true"`/`"false"` <br> **!!!Важно!!!** <br> Значение переменной - **строка в нижнем регистре**, а не булевый тип. | **"false"** |
| **install_gitlab_postfix_enabled** | Включать ли автозапуск **`Postfix`**'а после его установки | `true`/`false`| **`true`**|
| **install_gitlab_postfix_install** | Устанавливать ли **`Postfix`** перед установкой **`GitLab`**'а| `true`/`false` |**`true`**|
| **install_gitlab_postfix_state**| Требуемое состояние сервиса **postfix** после установки| `started`/`stopped`/`restarted`/`reloaded` |**started**|
| **install_gitlab_proxy_ip** | IP внешнего реверс-прокси, если таковой используется || **""** |
| **install_gitlab_proxy_port** | Порт внешнего реверс-прокси, если таковой используется || **""** |
| **install_gitlab_root_pass** | Устанавливаемый пароль для `root`-учётки|*В пароле вместо буквы **O** нолики*|**GitLab#r00tPa$$**|
| **install_gitlab_runner_token** | Начальный токен для раннеров | *Нет гарантии, но, похоже, это строка из 20 случайных символов (буквы/цифры)*| **98765432109876543210**|
