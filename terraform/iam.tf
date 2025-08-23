resource "aws_rolesanywhere_trust_anchor" "this" {
  name    = "iam-roles-anywhere-demo"
  enabled = true

  source {
    source_type = "CERTIFICATE_BUNDLE"
    source_data {
      x509_certificate_data = file("../root-ca/certs/root-ca.pem")
    }
  }

    tags = {
      Name     = "IAM Roles Anywhere Demo"
    }
}

resource "aws_iam_role" "this" {
  name        = "iam-roles-anywhere-demo"
  description = "Role for IAM Roles Anywhere"
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
            "aws:PrincipalTag/x509Subject/CN" : "IAM Anywhere Demo"
          },
          "ArnEquals" : {
            "aws:SourceArn" : aws_rolesanywhere_trust_anchor.this.arn
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_rolesanywhere_profile" "this" {
  name      = "iam-roles-anywhere-demo"
  role_arns = [aws_iam_role.this.arn]
  enabled   = true
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
  ]
}
