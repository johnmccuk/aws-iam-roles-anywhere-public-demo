# AWS IAM Roles Anywhere Demo
Demo usage of AWS IAM Roles Anywhere

Blog posts used to figure all of this out:

- [Create a CA for use with AWS IAM Roles Anywhere](https://medium.com/cyberark-engineering/calling-aws-services-from-your-on-premises-servers-using-iam-roles-anywhere-3e335ed648be)

- [IAM Roles Anywhere with an external certificate authority](https://aws.amazon.com/blogs/security/iam-roles-anywhere-with-an-external-certificate-authority/)

- [Extend AWS IAM roles to workloads outside of AWS with IAM Roles Anywhere](https://aws.amazon.com/blogs/security/extend-aws-iam-roles-to-workloads-outside-of-aws-with-iam-roles-anywhere/)

- [Get temporary security credentials from IAM Roles Anywhere](https://docs.aws.amazon.com/rolesanywhere/latest/userguide/credential-helper.html#credential-helper-credential-process)

> [!NOTE]
> download the [aws_signing_helper](https://docs.aws.amazon.com/rolesanywhere/latest/userguide/credential-helper.html)

# Example Request 

## Get auth

```
aws_signing_helper credential-process \
--certificate client.crt \
--private-key client.key \
--trust-anchor-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:trust-anchor/demo19d1-e16e-4ada-bf12-a08ba6e5b55e \
--profile-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:profile/demo772c-00d6-4f74-a2a7-5401e146ea94 \
--role-arn arn:aws:iam::ACCOUNTID:role/demo-iam-anywhere
```

## serve the permission

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

## Add to aws config

```
[profile iam-anywhere]
credential_process = ~/.aws/aws_signing_helper credential-process --certificate ~/.ssh/iam-anywhere.crt --private-key ~/.ssh/iam-anywhere.key --trust-anchor-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:trust-anchor/demo19d1-e16e-4ada-bf12-a08ba6e5b55e --profile-arn arn:aws:rolesanywhere:eu-west-1:ACCOUNTID:profile/demo772c-00d6-4f74-a2a7-5401e146ea94 --role-arn arn:aws:iam::ACCOUNTID:role/demo-iam-anywhere 
region = eu-west-1
```

then `aws sts get-caller-identity --profile iam-anywhere`

## python test
folder `python-iam-anywhere-test` then `poetry run python test.py`

> [!NOTE]
> if you get python error, try running `pyenv global 3.13.5`