# INSTALL_ALERTMANAGER

## Выполняемые действия
1. Устанавливает **`alertmanager`** для **`prometheus`**'а.

2. Запускает *(в зависимости от настроек)* сервис `prometheus-alertmanager.service`

3. Открывает на фаерволе порт `9093/tcp` для зоны `home`

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **install_alertmanager_enable** | Включать ли автозапуск сервиса `prometheus.service`| `true`/`false`| **true** |
| **install_alertmanager_state** | Сосотояние сервиса `prometheus.service` после установки | `started` / `stopped` / `restarted` / `reloaded` | **started** |

