## output.tf file
output "key_name" {
  value = aws_key_pair.client_keys.key_name
}