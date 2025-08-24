output "aws_profile" {
  value       = <<EOT
[profile iam-roles-anywhere-demo]
credential_process = sh -c 'aws_signing_helper credential-process --certificate ~/.ssh/iam-roles-anywhere-demo.crt --private-key ~/.ssh/iam-roles-anywhere-demo.key --trust-anchor-arn ${aws_rolesanywhere_trust_anchor.this.arn} --profile-arn ${aws_rolesanywhere_profile.this.arn} --role-arn ${aws_iam_role.this.arn}'
profile-arn = "${aws_rolesanywhere_profile.this.arn}"
role-arn = "${aws_iam_role.this.arn}"
trust-anchor-arn = "${aws_rolesanywhere_trust_anchor.this.arn}"
EOT
}
