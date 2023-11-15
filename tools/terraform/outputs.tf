output "master_ip" {
  value = aws_instance.k8s_master.public_ip
}

output "worker_ip1" {
  value = aws_instance.k8s_worker1.public_ip
}

output "worker_ip2" {
  value = aws_instance.k8s_worker2.public_ip
}
