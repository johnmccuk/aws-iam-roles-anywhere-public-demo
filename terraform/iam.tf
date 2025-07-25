##########################################
#DEMO ONLY - run TF in the aws infra repo
##########################################

resource "aws_rolesanywhere_trust_anchor" "iam-anywhere-demo" {
  name    = "iam-anywhere-demo-local"
  enabled = true

  source {
    source_type = "CERTIFICATE_BUNDLE"
    source_data {
      x509_certificate_data = file("../root-ca/root-ca-pem-only")
    }
  }

  #   tags = {
  #     Name     = "example-trust-anchor"
  #     yor_name = "trust-anchor"
  #     yor_trace = "d4f1c8b2-3e5f-4a6b-9c7e-8f1c2d3e4f5g"
  #   }
}

resource "aws_iam_role" "iam-anywhere-demo" {
  name        = "iam-anywhere-demo-local-iam-anywhere"
  description = "Role for IAM Anywhere"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "rolesanywhere.amazonaws.com"
        },
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession",
          "sts:SetSourceIdentity"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:PrincipalTag/x509Subject/CN" : "IAM Anywhere Demo",
            "aws:PrincipalTag/x509Subject/OU" : "Local"
          },
          "ArnEquals" : {
            "aws:SourceArn" : aws_rolesanywhere_trust_anchor.iam-anywhere-demo.arn
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam-anywhere-demo_s3_full_access" {
  role       = aws_iam_role.iam-anywhere-demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_rolesanywhere_profile" "iam-anywhere-demo" {
  name      = "iam-anywhere-demo-local"
  role_arns = [aws_iam_role.iam-anywhere-demo.arn]
  enabled   = true
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
  ]
}
