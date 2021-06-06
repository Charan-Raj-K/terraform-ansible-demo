provider "aws" {
  profile = "default"
  region  = "us-east-1"

}



resource "aws_instance" "myec2vm" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t3.micro"
  key_name      = "May"
  # vpc_security_group_ids = [aws_security_group.vps_ssh.id, aws_security_group.vps_web.id]
  tags = {
    Name = "My Linux EC2"
  }
  # This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
    
    #command = "sh sudo chmod 600 /opt/May.pem"
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key /opt/May.pem -i '${aws_instance.myec2vm.public_ip},' playbook.yml"
  }

}
