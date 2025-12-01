output "name_servers" {
  value = aws_route53_zone.primary.name_servers
  description = "List of Route 53 NS values to enter"
}
