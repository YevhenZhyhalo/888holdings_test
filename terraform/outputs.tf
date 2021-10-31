output "ansible_ip" {
  description = "Ansible pub ip"
  value = "${aws_instance.Ansible.public_ip}"
}