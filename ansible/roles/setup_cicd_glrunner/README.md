# SETUP_CICD_GLRUNNER

## Выполняемые действия
1. Копирует указанную пару SSH-ключей и конфиг SSH в место, доступное **`GitLab`**'овскому раннеру.

2. Разрешает пользователю `gitlab-runner` пользоваться `sudo` без пароля.

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :---: |
| **setup_cicd_glrunner_key_dir_dest** | Каталог, куда выкладываются ключи и ssh-конфиг|| **/home/gitlab-runner/.ssh** |
| **setup_cicd_glrunner_key_dir_src** | Каталог, откуда берутся ключи и ssh-конфиг|| **/root/.ssh** |
| **setup_cicd_glrunner_key_name** | Имя файла приватного ssh-ключа|| **rsync.key** |
