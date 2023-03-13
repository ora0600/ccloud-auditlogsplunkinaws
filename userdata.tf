###########################################
######## Confluent 5.3 Dev Instance ##########
###########################################

data "template_file" "AUDITLOG_instance" {
  template = file("utils/instance.sh")

  vars = {
    auditlogccloudsplunkdemo = var.auditlogccloudsplunkdemo
    BOOTSTRAP_SERVERS = var.bootstrap_servers
    CONNECTOR_OWNER = var.connector_owner
    CONNECTOR_NAME = var.connector_name
    CONNECTOR_VERSION = var.connector_version
    SASL_JAAS_CONFIG = var.sasl_jaas_config
    confluent_home_value  = var.confluent_home_value
  }
}
