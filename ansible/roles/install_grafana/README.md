# INSTALL_GRAFANA

## Выполняемые действия:
1. Устанавливает **`Grafana`**.

2. Запускает *(в зависимости от настроек)* сервис `grafana-server.service`.

3. Открывает доступ к **`Grafana`** в фаерволе для зоны `home`.

## Переменные
***defaults/main.yml***
| Имя переменной | Описание | Возможные значения/Примечания | Значение по умолчанию |
| :--- | :--- | :--- | :--- |
| **install_grafana_admin** | Имя администраторской учётки при первом входе || **admin** |
| **install_grafana_admin_initial_pass** | Первоначальный пароль администраторской учётки || **admin** |
| **install_grafana_enabled** | Включать ли автозапуск сервиса `grafana-server.service` | `true`/`false`| **true** |
| **install_grafana_external_url** | Публичное имя сайта с **`Grafana`** | *Только имя, без протокола* | **"grafana.example.com"** |
| **install_grafana_sign_key** | Секретный ключ, используемый для подписи | *Не факт, но похоже, что это 20 символов (буквы/цифры)* | **ChAnGeMe901234567890** |
| **install_grafana_state** | Состояние сервиса `grafana-server.service` после установки | `started` / `stopped` / `restarted` / `reloaded` | **started** |
