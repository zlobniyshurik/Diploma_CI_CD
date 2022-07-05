# INSTALL_PROMETHEUS

## Выполняемые действия
1. Создаёт заданного пользователя под запуск **`prometheus`**

2. Выкачивает архив с бинарниками

3. Распаковывает архив и раскидывает файлы по своим местам

4. Создаёт и запускает сервис `prometheus.service`

5. Открывает на фаерволе порт `9090/tcp` для зоны `home`

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **install_prometheus_group** | Группа для запуска `prometheus.service` || **prometheus** |
| **install_prometheus_enable** | Включать ли автозапуск сервиса `prometheus.service`| `true`/`false`| **true** |
| **install_prometheus_state** | Сосотояние сервиса `prometheus.service` после установки | `started` / `stopped` / `restarted` / `reloaded` | **started** |
| **install_prometheus_url** | URL архива с бинарниками || **https://github.com/prometheus/prometheus/releases/download/v2.36.2/prometheus-2.36.2.linux-amd64.tar.gz** |
| **install_prometheus_user** | Пользователь для запуска `prometheus.service` || **prometheus** |
