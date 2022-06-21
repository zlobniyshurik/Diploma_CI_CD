resource "local_file" "balancer" {
  content = templatefile("balancer.tftpl",
    {
      sql_dbnode_name  = "${var.db_name}",
      sql_dbnode_count = var.db_count,
      sql_domain_tld   = "${var.my_domain_tld}"
    }
  )
  filename = "balancer.conf"
}