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

1. Установлен самописный скрипт, который автоматически прописывает в A-запись доменной зоны текущий IP-адрес нашего реверс-прокси после каждого запуска *(руками вбивать это каждый раз - откровенно лениво, а покупать "белый" IP нам жадность не позволяет)*.

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
