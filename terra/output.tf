output "dev_node_instance_type" {
  value = aws_instance.dev_node.instance_type
}

# output "dev_node_instance_x_type" {
#   value = aws_instance.dev_node_x.instance_type
# }


output "dev_node_instance_public_ip" {
  value = aws_instance.dev_node.public_ip
}

# output "dev_node_instance_x_public_ip" {
#   value = aws_instance.dev_node_x.public_ip
# }
