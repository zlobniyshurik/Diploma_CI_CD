# SETUP_GLRUNNER

## Выполняемые действия
- Пытается подключить раннер с заданными параметрами к указанному серверу `GitLab`'а

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :---: |
| **setup_glrunner_access_lvl** | Уровень доступа к раннеру || **not_protected** |
| **setup_glrunner_description** | Описание раннера в текстовом виде || **Default description** |
| **setup_glrunner_docker_img** | Образ докера по умолчанию, если в качестве `executor`'а выбран **`docker`** || **alpine:latest** |
| **setup_glrunner_executor** | Выбор `executor`'а для раннера| `SSH` / `Shell` / `VirtualBox` / `Parallels` / `docker` / `Kubernetes` / `Custom` | **docker** |
| **setup_glrunner_host_url** | URL для подключения к серверу `GitLab`'а || **https://example.com** |
| **setup_glrunner_locked** | Заблокирован ли раннер? |`true`/`false`| **false** |
| **setup_glrunner_maintenance** | Текстовая заметка об обслуживании | *до 255 символов* | **Free form notes** |
| **setup_glrunner_run_untagged** | Запускать ли задания без тэгов | `true`/`false`| **true** |
| **setup_glrunner_tags** | Тэги для раннера <br> *через запятую* || **""** |
| **setup_glrunner_token** | Токен для подключения к серверу | *Нет гарантии, но, похоже, это строка из 20 случайных символов (буквы/цифры)* | **98765432109876543210**|
