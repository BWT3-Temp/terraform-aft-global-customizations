output "app_owner" {
  value = aws_iam_role.appOwner.name
}
output "app_team" {
  value = aws_iam_role.appTeam.name
}
output "auditor" {
  value = aws_iam_role.auditor.name
}