output "trust-anchor-arn" {
  value       = aws_rolesanywhere_trust_anchor.this.arn
  description = "Trust Anchor ARN"
}

output "profile-arn" {
  value       = aws_rolesanywhere_profile.this.arn
  description = "Profile ARN"
}

output "role-arn" {
  value       = aws_iam_role.this.arn
  description = "IAM Role ARN for IAM Anywhere"
}

output "credential_process" {
  value       = "aws_signing_helper credential-process --certificate ~/.ssh/iam-roles-anywhere-demo.crt --private-key ~/.ssh/iam-roles-anywhere-demo.key --trust-anchor-arn ${aws_rolesanywhere_trust_anchor.this.arn} --profile-arn ${aws_rolesanywhere_profile.this.arn} --role-arn ${aws_iam_role.this.arn}"
  description = "Credential process command for IAM Anywhere"
}
