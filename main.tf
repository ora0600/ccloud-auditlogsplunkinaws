resource "aws_security_group" "secemeaauditlog" {
  name        = "secemeaauditlogSecGroup"
  description = "SE CEMEA Audit Log Sec. Group"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.local_public_ip}"]
  }

  # HTTP SPLUNK access
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${var.local_public_ip}"]
  }
  
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "SECEMEAAUDITLOG" {
  ami           = "${data.aws_ami.ami.id}"
  count         = var.instance_count
  instance_type = var.instance_type_resource
  key_name      = var.ssh_key_name
  vpc_security_group_ids = ["${aws_security_group.secemeaauditlog.id}"]
  user_data = data.template_file.AUDITLOG_instance.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  tags = {
    Name = "ccloud audit log with Splunk",
    owner = "YOUREMAIL@confluent.io"

  }
}
