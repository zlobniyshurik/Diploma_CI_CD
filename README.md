# Диплом


## Этап 1 *(Регистрация доменного имени)*

- В **[nic.ru](https://nic.ru)** специально для диплома был зарегистрирован домен **[diplomshurika.ru](http://diplomshurika.ru)**

- В качестве бесплатного публичного DNS воспользовался сервисом от **[dns.he.net](https://dns.he.net)**  
  *из бонусов:* 
  - *возможно динамическое управление зонами с помощью GET/POST-запросов*
  - *существует плагин с поддержкой ***[dns.he.net](https://dns.he.net)*** для скрипта ***[acme.sh](https://github.com/acmesh-official/acme.sh)***, обеспечивающего автоматизированное обновление сертификатов от* ***[Let's Encrypt](https://letsencrypt.org/ru/)***

---
## Этап 2 *(Создание инфраструктуры)*
На данном этапе встретились первые подводные камни:

Жёстко прописывать в скрипты все учётки/явки/пароли, мягко говоря, недальновидно. Однако и выделить все настройки в отдельный файл с переменными не получилось - движок `Terraform`'а почему-то не понимает переменные в секции с бэкендом *(баги по этому поводу открыты уже более 5 лет)*.  
Пришлось настройки бэкенда выносить в отдельный файл `backend.conf` формата "ключ=значение", а инициализацию `Terraform`'а производить с дополнительными параметрами:
```
terraform init -backend-config=backend.conf
```
*Пример файла* ***backend.conf*** *:*
```
endpoint   = "storage.yandexcloud.net"
bucket     = "<имя бакета>"
region     = "ru-central1"
key        = "<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
access_key = "<идентификатор статического ключа>"
secret_key = "<секретный ключ>"

skip_region_validation      = true
skip_credentials_validation = true
```
*Файл с остальными ключами к ЯндексОблаку ***private.tf*** на данный момент выглядит примерно так:*
```terraform
########################################
# General settings for Yandex provider #
########################################

variable "ya_token" {
  description = "Yandex token"
  type        = string
  default     = "<Яндекс токен>"
  sensitive   = true
}

variable "ya_cloud_id" {
  description = "Yandex cloud_id"
  type        = string
  default     = "<Яндекс cloud_id>"
  sensitive   = true
}

variable "ya_folder_id" {
  description = "Yandex folder_id"
  type        = string
  default     = "<Яндекс folder_id>"
  sensitive   = true
}

variable "ya_zone" {
  description = "Yandex geozone"
  type        = string
  default     = "ru-central1-a"
}
```

В результате `Terraform` работает и сохраняет стейты в YandexCloud:  
![Стейты в S3-хранилище](./pic/diplom_2_1.png)

---
## Этап 3 *(Установка Nginx и LetsEncrypt)*

1. Установлен самописный скрипт, который автоматически прописывает в A-запись доменной зоны текущий IP-адрес нашего реверс-прокси после каждого запуска  
*(руками вбивать это каждый раз - откровенно лениво, а покупать "белый" IP нам жадность не позволяет)*.

   Сам скрипт *(фрагмент из ***proxy.tf***)*  
   ```bash
   #!/bin/bash
   curl -4 "https://"${var.my_domain_tld}":"${var.he_net_key}"@dyn.dns.he.net/nic/update?hostname="${var.my_domain_tld}
   ```
   Соответственно, сделан простенький сервис, который и запускает вышеозначенный скрипт после каждого запуска/перезагрузки виртуальной машины в облаке.
   Спасибо **[dns.he.net](https://dns.he.net)**, где предусмотрели такой несложный способ работы с динамическими IP.

---
2. Для автоматического получения и обновления сертификатов от **[Let's Encrypt](https://letsencrypt.org/)** воспользовался скриптом **[acme.sh](https://github.com/acmesh-official/acme.sh)**.

   Из плюсов данного решения:
- Не тянет за собой кучу зависимостей
- Работает без root-прав
- Автоматом по расписанию пытается обновить сертификаты.
- *(Самое главное!)* Умеет работать с **[dns.he.net](https://dns.he.net)**

***Важное примечание:*** *Не будем мелочиться и сразу же получим так называемый wildcard-сертификат. То есть один сертификат на все возможные поддомены третьего уровня для нашего домена.*

---
3. Так как впоследствии нам придётся подымать кластер из MySQL-нод, то потребуется и какой-нибудь балансировщик, через который мы будем до этих нод стучаться.  
Задействуем **nginx**, скормив ему примерно такой конфиг 
*(автоматом генерится ***Terraform***'ом по числу доступных нод)*
```
stream {
        upstream stream_backend {
            least_conn;

            server db01.example.com:3306 max_fails=2 fail_timeout=30s;

            server db02.example.com:3306 max_fails=2 fail_timeout=30s;

          }

        server {
            listen 3306;
            proxy_connect_timeout 1s;
            proxy_timeout 3s;
            proxy_pass stream_backend;
          }
}
```
---
Итого, реверс-прокси для для обращения **`HTTP`**/**`HTTPS`** работает...  

*пример обращения к* ***diplomshurika.ru***  
![https://diplomshurika.ru](./pic/diplom_3_1.png)

---
*пример обращения к* ***grafana.diplomshurika.ru***  
![https://grafana.diplomshurika.ru](./pic/diplom_3_2.png)


---
## Этап 3½ *(JumpHost и прокси)*

1. Поскольку с публичными адресами для всех виртуальных машин кроме реверс-прокси у нас проблемы, то приходится использовать нашу реверс-прокси ноду ещё и как JumpHost для трансляции ssh-запросов в глубины сети с "серыми" IP.

В принципе, ничего экстраординарного, но вот проверку SSH-ключей от новых хостов внутри реверс-прокси пришлось отключить, иначе **Ansible** подвисал при установлении соединения с нодами.

Для отключения проверки ключей воспользовался **Terraform**'ом, поправив на реверс-прокси ноде файлик ***`~/.ssh/config`***,
вписав туда
```
Host *
    StrictHostKeyChecking no
```

---
2. Ещё одним подводным камнем оказалось отсутствие интернета на тех нодах, где нет публичных IP. Соответственно, с установкой софта возникли проблемы.

В качестве решения на реверс-прокси ноду был установлен прокси **Squid** *(минимум настроек и достаточное количество возможностей)*.

На нодах, оставшихся без публичных IP, оказалось достаточным прописать прокси в настройках пакетного менеджера **dnf**. После чего возможность установки ПО из внешних репозиториев восстановилась.

По идее, можно было бы ещё и прописать ACLы с паролями для доступа к прокси для увеличения безопасности, но оставим это потомкам.

---
## Этап 4 *(Установка кластера MySQL)*

К сожалению, полученный результат назвать ***отказоустойчивым*** кластером рука не подымается:

Да, у нас целых две ноды. Да, при желании можно использовать балансер на **nginx**'е из этапа 3...

Но при репликации **Master-Slave** кластер будет отказоустойчивым ***только при чтении*** данных из базы. В этом случае всё красиво - данные берутся через балансер из любой живой ноды.

Но, как только требуется что-то записать, запись возможна исключительно в master-ноду, а единственная master-нода и отключиться может. К тому же, наш примитивный вариант балансера только помешает - им нельзя пользоваться при записи, дабы не подключиться случайно к slave-ноде.

Ах, если бы была бы репликация **Master-Master**, то у нас действительно получился бы достаточно отказоустойчивый кластер, выживающий при отключении любой из нод. В этом случае писать/читать можно было бы на любую живую ноду, а оставшиеся подтянули бы к себе изменённые данные после восстановления жизнеспособности. Но ТЗ - есть ТЗ.

Впрочем, в конце-концов, оно таки работает. Базы/юзеры создаются, данные успешно реплицируются.

---
## Этап 5 *(Установка WordPress)*

Пришлось повозиться.

Во-первых, **`SElinux`** предательски блокировал все обращения **`WordPress`**'а к базе данных. Решение - отключить **`SElinux`** для контекста `httpd_t`.

Во-вторых, **`WordPress`** пришлось настроить для работы через прокси, для чего в файл **wp-config.php** были добавлены следующие строчки:  
```php
define('WP_PROXY_HOST', 'имя-прокси');
define('WP_PROXY_PORT', 'порт-прокси');
define('WP_PROXY_USERNAME', '');
define('WP_PROXY_PASSWORD', '');
define('WP_PROXY_BYPASS_HOSTS', 'localhost');
```

В третьих, пришлось забирать HTTPS-сертификаты с прокси-сервера при каждом старте машины с `WordPress`'ом. Для чего был написан самописный сервис на основе `rsync`'а.

Для чего, в свою очередь, пришлось написать  роли для генерации и раздачи SSH-ключей по подшефным серверам для внутреннего обмена информацией.

В результате сайт **www.diplomshurika.ru** таки заработал:  

---
*Вход на сайт*  
![Вход на сайт www.diplomshurika.ru](./pic/diplom_5_2.png)  

---
*Сам сайт*  
![Сам сайт www.diplomshurika.ru](./pic/diplom_5_1.png)  

---
## Этап 6 *(Установка Gitlab CE и Gitlab Runner)*

Опять же подводный камень - Yandex Cloud по неизвестной причине рвёт соединение при закачке более гигабайта *(от способа закачки и сервера-источника данных не зависит)*.  
Пришлось дистрибутив `GitLab`'а разрезать на две части, переслать по кускам, собрать заново и только потом устанавливать.

Тем не менее, `GitLab` с раннером успешно устанавливаются, запускаются и видят друг-друга.  
![Запущенный гитлаб с раннером](./pic/diplom_6_1.png)

---
Далее полагается создать нового пользователя  
*(ибо из-под администратора работать небезопасно и просто неприлично)*.

Увы, несмотря на теоретическую возможность создания новых пользователей в консоли или через API, реально это сделать весьма сложно:  
- откровенно мало документации *(работа через ***`gitlab-rails`***)*  
- требуются грязные хаки типа парсинга страниц ради получения админского токена *(работа через ***`API`***)*.

Не будем тратить недели рабочего времени на то, что можно сделать руками за 5 минут.

---
**Создаём пользователя `cicd`**  
![Создаём пользователя](./pic/diplom_6_2.png)  

---
**Зайдя под пользователем `cicd` создаём проект `wordpress`**  
![Создаём проект](./pic/diplom_6_3.png)  

---
**На сервере приложений `app.diplomshurika.ru` выгружаем на `gitlab.diplomshurika.ru` уже подготовленный автоматикой репозиторий с содержимым каталога с ***`WordPress`***'ом, запустив немудрёный скрипт:**  
```bash
cd /var/www/diplomshurika.ru/wordpress
git remote add origin https://gitlab.diplomshurika.ru/cicd/wordpress.git
git branch -M master
git push -uf origin master
```

---
**Возвращаемся на `gitlab.diplomshurika.ru` и видим наш `WordPress`**  
![Репозиторий с WordPress'ом](./pic/diplom_6_4.png)

---


---
## Этап 7 *(Установка Prometheus, Alert Manager, Node Exporter и Grafana)*

**`Prometheus`** установлен, конфигурация опрашиваемых **`Node Exporter`**'ов добавляется автоматически при заливке ПО.

Примеры работы **`Prometheus`**:  
![Prometheus пытается рисовать график](./pic/diplom_7_1.png)

---
![Node Exporter'ы в Prometheus](./pic/diplom_7_1a.png)

---
**`Alert Manager`** в наличии:  
*(блёклый он какой-то)*  
![Alert Manager](./pic/diplom_7_4.png)

---
Комбинация из **`Prometheus`**'а и **`Alert Manager`**'а даже ругается на некоторые недостатки дипломной конфигурации:  
![Alert Manager в Prometheus](./pic/diplom_7_3.png)

---
**`Grafana`** тоже работает:  
*(Правда, указывать ей источник данных и красивый дашборд пока приходится вручную)*  
![Grafana с пачкой графиков](./pic/diplom_7_2.png)

