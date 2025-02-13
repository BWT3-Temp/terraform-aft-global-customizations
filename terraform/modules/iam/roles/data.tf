data "aws_iam_policy_document" "auditor" {
  statement {
    effect = "Deny"
    actions = [ 
        "athena:GetQueryResults",
              "cloudformation:GetTemplate",
              "dax:GetItem",
              "dax:BatchGetItem",
              "dax:Query",
              "dax:Scan",
              "dynamodb:GetItem",
              "dynamodb:BatchGetItem",
              "dynamodb:Query",
              "dynamodb:Scan",
              "ec2:GetConsoleOutput",
              "kinesis:Get*",
              "kinesisvideo:Get*",
              "s3:GetObject",
              "sdb:Select*",
              "secretsmanager:GetSecretValue",
              "sqs:ReceiveMessage"
     ]
     resources = [ 
        "*"
      ]
  }
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [ 
      "sts:AssumeRoleWithSAML"
     ]
     principals {
       type = "Federated"
       identifiers = [ 
        "arn:aws:iam::${var.account_id}:saml-provider/NBCU"
        ]
     }
     condition {
       test = "StringEquals"
       variable = "SAML:aud"
       values = [ 
        "https://signin.aws.amazon.com/saml"
        ]
     }
  }
}