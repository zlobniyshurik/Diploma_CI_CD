# INSTALL_NODE_EXPORTER

## Выполняемые действия
1. Выкачивает архив с бинарникамми **`node exporter`**'а.

2. Распаковывает его и раскидывает бинарники по местам постоянной дислокации

3. Устанавливает и запускает *(в зависимости от настроек)* сервис `node_exporter.service`

4. Открывает на фаерволе порт `9100/tcp` в зоне `home`


## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **install_node_exporter_enable** | Включать ли автозапуск сервиса `node_exporter.service` | `true`/`false` | **true** |
| **install_node_exporter_state** | Состояние сервиса `node_exporter.service` после установки | `started` / `stopped` / `restarted` / `reloaded` | **started** |
| **install_node_exporter_url** | URL архива с бинарниками **node exporter** || **https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz** |
