# tfstateに鍵の情報が保存されるため、本来は使用するべきではない
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./${var.key_pair_name}.pem && chmod 600 ./${var.key_pair_name}.pem"
  }
}