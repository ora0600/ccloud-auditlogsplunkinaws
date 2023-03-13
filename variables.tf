# AWS Config
variable "aws_access_key" {
  default = "SET YOUR AWS KEY"
}
variable "aws_secret_key" {
  default = "SET YOUR AWS SECRET"
}
variable "aws_region" {
  default = "eu-central-1"
}
variable "ssh_key_name" {
  default = "audit-secemea"
}
variable "instance_type_resource" {
  default = "t2.large"
}
variable "instance_count" {
    default = "1"
  }
variable "auditlogccloudsplunkdemo" {
  default = "https://github.com/JohnnyMirza/ccloudauditlogs_splunk/archive/refs/heads/main.zip"
}
variable "confluent_home_value" {
  default = "/home/ec2-user/software"
}
variable "bootstrap_servers" {
  default = "GET YOUR BOOTSTRAPSERVER FOR YOUR AUDITLOG CLUSTER"
}
variable "sasl_jaas_config" {
  default = "\"org.apache.kafka.common.security.plain.PlainLoginModule required username=\"YOUR AUDITLOG KEY\" password=\"YOUR AUDITLOG SECRET\";\""
}
variable "connector_owner" {
  default = "splunk"
}
variable "connector_name" {
  default = "kafka-connect-splunk"
}
variable "connector_version" {
  default = "2.0.2"
}
# set your local IP Adress before executing terraform extaddr=$(curl -s ifconfig.me)
variable "local_public_ip" {
  default = "YOURPUBLIC IP/32"
}
