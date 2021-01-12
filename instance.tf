resource "aws_instance" "openvpn" {
  ami           = var.ami_id_amzn_linux_2_hvm[var.region]
  instance_type = var.instance_type
  key_name        = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.openvpn_sg.id]
  user_data = file("user_data.sh")

  tags = {
    Name = "openvpn"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.openvpn.public_ip} > ec2_openvpn_ip"
  }

  # Execute installer script
  provisioner "remote-exec" {
    script = "start_service.sh"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${var.private_key_location_prefix}/${var.region}/${var.key_pair_name}.pem")
    }
  }

}

