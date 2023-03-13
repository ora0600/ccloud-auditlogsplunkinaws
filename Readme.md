# Confluent Cloud Audit Log Dashbaord in AWS
This repo deployed the Audit Log Dashboard developed as SPLUBK Dashboard into AWS.
Please enter your stuff in variables.tf
and the execute
```bash
terraform init
terraform plan
terraform apply
```
To destroy everything in AWS, just execute
```bash
terraform destory
```

The SPLUNK Dashbaord is used from [JojonnyMirza](https://github.com/JohnnyMirza/ccloudauditlogs_splunk)