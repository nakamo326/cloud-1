# tfstateに鍵の情報が保存されるため、本来は使用するべきではない
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = "cloud-1-key-pair"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./${aws_key_pair.key.key_name}.pem && chmod 600 ./${aws_key_pair.key.key_name}.pem"
  }
}
