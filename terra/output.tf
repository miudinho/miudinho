output "dev_node_instance_type" {
<<<<<<< HEAD
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
=======
    value = aws_instance.dev_node.instance_type
}

output "dev_node_instance_public_ip" {
    value = aws_instance.dev_node.public_ip
}

#output "dev_node_instance_root_block_device" {
#    value = aws_instance.dev_node.root_block_device[*]
#}

output "dev_node_x_instance_type" {
    value = aws_instance.dev_node.instance_type
}

output "dev_node_x_instance_public_ip" {
    value = aws_instance.dev_node_x.public_ip
}
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
