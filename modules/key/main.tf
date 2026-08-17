resource "aws_key_pair" "client_keys" {
  public_key = file("${path.module}/client_keys.pub")

  tags = {
    Name = "client_keys"
  }
}