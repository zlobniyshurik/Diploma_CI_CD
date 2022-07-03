# INSTALL_SQUID

## Выполняемые действия
1. Устанавливает прокси-сервер **`Squid`**

2. Правит конфиги **Squid**'а так, чтобы всем подключившимся был доступ ко всему через заданный порт.

3. Запускает сервис

4. Открывает порт в фаерволе для зоны **`home`**

## Переменные

***defaults/main.yml***
| Имя переменной | Описание | Возможные значения | Значение по умолчанию |
| :--- | :--------- | :--- | :--- |
| **install_squid_proxy_port** | Номер порта для подключения к прокси || **3128** |