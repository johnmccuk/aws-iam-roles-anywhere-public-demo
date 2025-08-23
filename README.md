# AWS IAM Roles Anywhere Demo

## Description

This repo is for use with the blog post [Demo usage of AWS IAM Roles Anywhere](https://dev.to/johnmccuk/aws-iam-roles-anywhere-demo-15hj-temp-slug-8920603?preview=04a3ca7a8d6c776ec3aa7a2979ad23405ed4c6b96382dc569040faafe085536b10029f8b8eeb97b657df721dd7d6808b9b7960a7357cb1233602ca8e).

## File Layout
TODO

## Further Reading
Blog posts used to figure all of this out:

- [Create a CA for use with AWS IAM Roles Anywhere](https://medium.com/cyberark-engineering/calling-aws-services-from-your-on-premises-servers-using-iam-roles-anywhere-3e335ed648be)

- [IAM Roles Anywhere with an external certificate authority](https://aws.amazon.com/blogs/security/iam-roles-anywhere-with-an-external-certificate-authority/)

- [Extend AWS IAM roles to workloads outside of AWS with IAM Roles Anywhere](https://aws.amazon.com/blogs/security/extend-aws-iam-roles-to-workloads-outside-of-aws-with-iam-roles-anywhere/)

- [Get temporary security credentials from IAM Roles Anywhere](https://docs.aws.amazon.com/rolesanywhere/latest/userguide/credential-helper.html#credential-helper-credential-process)

- [Examples derived from Ivans Ristic's Github](https://github.com/ivanr/bulletproof-tls/tree/master/private-ca)


> [!NOTE]
> download the 

## Example Usage of [aws_signing_helper](https://docs.aws.amazon.com/rolesanywhere/latest/userguide/credential-helper.html)

### Get auth

```
aws_signing_helper credential-process \
--certificate client.crt \
--private-key client.key \
--trust-anchor-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:trust-anchor/demo19d1-e16e-4ada-bf12-a08ba6e5b55e \
--profile-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:profile/demo772c-00d6-4f74-a2a7-5401e146ea94 \
--role-arn arn:aws:iam::ACCOUNTID:role/demo-iam-anywhere
```

### serve the permission

```
./aws_signing_helper serve \
--certificate client.crt \
--private-key client.key \
--trust-anchor-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:trust-anchor/demo19d1-e16e-4ada-bf12-a08ba6e5b55e \
--profile-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:profile/demo772c-00d6-4f74-a2a7-5401e146ea94 \
--role-arn arn:aws:iam::ACCOUNTID:role/demo-iam-anywhere \
```

```
[profile developer]
    credential_process = aws_signing_helper credential-process --certificate client.crt --private-key client.key --trust-anchor-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:trust-anchor/demo19d1-e16e-4ada-bf12-a08ba6e5b55e --profile-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:profile/demo772c-00d6-4f74-a2a7-5401e146ea94 --role-arn arn:aws:iam::ACCOUNTID:role/demo-iam-anywhere 
    region = eu-west-1
```

### Add to aws config

```
[profile iam-anywhere]
credential_process = ~/.aws/aws_signing_helper credential-process --certificate ~/.ssh/iam-anywhere.crt --private-key ~/.ssh/iam-anywhere.key --trust-anchor-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:trust-anchor/demo19d1-e16e-4ada-bf12-a08ba6e5b55e --profile-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:profile/demo772c-00d6-4f74-a2a7-5401e146ea94 --role-arn arn:aws:iam::ACCOUNTID:role/demo-iam-anywhere 
region = eu-west-1
```

then `aws sts get-caller-identity --profile iam-anywhere`
