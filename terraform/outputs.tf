output "trust-anchor-arn" {
  value       = aws_rolesanywhere_trust_anchor.iam-anywhere-demo.arnarn
  description = "Trust Anchor ARN"
}

output "profile-arn" {
  value       = aws_rolesanywhere_profile.iam-anywhere-demo.arn
  description = "Profile ARN"
}

output "role-arn" {
  value       = aws_iam_role.iam-anywhere-demo.arn
  description = "IAM Role ARN for IAM Anywhere"
}

output "credential_process" {
  value       = "~/.aws/aws_signing_helper credential-process --certificate ~/.ssh/iam-anywhere.crt --private-key ~/.ssh/iam-anywhere.key --trust-anchor-arn ${aws_rolesanywhere_trust_anchor.iam-anywhere-demo.arn} --profile-arn ${aws_rolesanywhere_profile.iam-anywhere-demo.arn} --role-arn ${aws_iam_role.iam-anywhere-demo.arn}"
  description = "Credential process command for IAM Anywhere"
}

output "demo_message" {
  value       = "***** DEMO ONLY - run TF in the aws infra repo *****"
}