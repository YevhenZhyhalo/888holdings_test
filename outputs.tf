output "ansible_ip" {
  description = "Ansible pub ip"
  value = "${aws_instance.Ansible.public_ip}"
}

output "ubuntu_ip" {
  description = "Ubuntu pub ip"
  value = "${aws_instance.Ubuntu.public_ip}"
}
output "centos_ip" {
  description = "Centos pub ip"
  value = "${aws_instance.Centos.public_ip}"
}