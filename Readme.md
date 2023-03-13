# Confluent Cloud Audit Log Dashbaord in AWS
This repo deployes the Audit Log Dashboard developed as SPLUNK Dashboard into AWS.
Please enter your stuff in `variables.tf`
and the execute
```bash
terraform init
terraform plan
terraform apply
```
The URL of the SPLUNK Dashboard will be printed out via `terraform output`

To destroy everything in AWS, just execute
```bash
terraform destory
```


The SPLUNK Dashbaord implemented is copied from [JojonnyMirza](https://github.com/JohnnyMirza/ccloudauditlogs_splunk)