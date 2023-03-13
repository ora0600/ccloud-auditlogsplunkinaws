###########################################
################# Outputs #################
###########################################

output "SSH" {
  value = tonumber(var.instance_count) >= 1 ? "SSH  Access: ssh -i ~/keys/audit-secemea.pem ec2-user@${join(",",formatlist("%s", aws_instance.SECEMEAAUDITLOG.*.public_ip),)} " : "Confluent Cloud Platform on AWS is disabled" 
}

output "SPLUNK" {
  value = tonumber(var.instance_count) >= 1 ? "SPLUNK Access: http://${join(",",formatlist("%s", aws_instance.SECEMEAAUDITLOG.*.public_ip),)}:8000 " : "Confluent Cloud Platform on AWS is disabled" 
}
