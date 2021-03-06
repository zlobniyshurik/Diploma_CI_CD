# Создаём модифицированный конфиг для nginx'а
# c поддержкой балансировки траффика на MySQL ноды,
# главная фишка - автогенерация списка нод
resource "local_file" "balancer" {
  content = templatefile("balancer.tftpl",
    {
      sql_dbnode_name_prefix  = "${var.db_name_prefix}",
      sql_dbnode_count        = var.db_count,
      sql_domain_tld          = "${var.my_domain_tld}"
    }
  )
  filename = "autogenerated/nginx.conf"
}