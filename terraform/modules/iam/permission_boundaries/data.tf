
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "perm-boundary-no-iam" {
  statement {
    effect = "Allow"
    not_actions = [
      "account:*",
      "config:*",
      "iam:*",
      "organizations:*"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "account:ListRegions",
      "config:*ConfigRule*",
      "config:Describe*",
      "config:*Get*",
      "config:SelectResourceConfig",
      "config:List*",
      "iam:Generate*",
      "iam:Get*",
      "iam:List*",
      "iam:*ServerCertificate",
      "iam:*SigningCertificate",
      "iam:*InstanceProfile",
      "iam:Simulate*",
      "iam:*ServiceLinkedRole",
      "iam:UpdateRoleDescription",
      "organizations:DescribeOrganization"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Deny"
    actions = [
      "iam:CreatePolicy*",
      "iam:DeletePolicy*",
      "iam:SetDefaultPolicyVersion"
    ]
    resources = [
      "arn:aws:iam::*:policy/*Boundary"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole",
      "iam:TagRole",
      "iam:UpdateRoleAssumePolicy"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/custrole-*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:PassRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:CreateServiceLinkedRole",
      "iam:UpdateRoleDescription",
      "iam:DeleteServiceLinkedRole",
      "iam:GetServiceLinkedRoleDeletionStatus"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/service-role/*",
      "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-ec2-role",
      "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
    ]
  }
  statement {
    effect = "Deny"
    actions = [
      "iam:DeleteRolePermissionsBoundary",
      "iam:DeleteUserPermissionsBoundary",
      "ec2:AdvertiseByoipCidr",
      "ec2:ProvisionByoipCidr",
      "ec2:DeprovisionByoipCidr",
      "ec2:WithdrawByoipCidr",
      "ec2:EnableVpcClassic*",
      "ec2:DisableVpcClassic*",
      "ec2:AttachClassicLinkVpc",
      "ec2:DetachClassicLinkVpc",
      "ec2:MoveAddressToVpc",
      "ec2:Attach*Gateway*",
      "ec2:Create*Gateway*",
      "ec2:Delete*Gateway*",
      "ec2:Detach*Gateway*",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:AssociateVpc*",
      "ec2:DisassociateVpc*",
      "ec2:CreateVpcPeer*",
      "ec2:AcceptVpcPeer*",
      "ec2:RejectVpcPeer*",
      "ec2:DeleteVpcPeer*",
      "ec2:ModifyVpcPeer*",
      "ec2:CreateVpn*",
      "ec2:DeleteVpn*",
      "directconnect:Allocate*",
      "directconnect:Associate*",
      "directconnect:Confirm*",
      "directconnect:Create*",
      "directconnect:Delete*",
      "directconnect:*Loa",
      "directconnect:Disassociate*",
      "directconnect:Tag*",
      "directconnect:Untag*",
      "directconnect:Update*"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "perm-boundary-with-iam" {
  statement {
    effect = "Allow"
    not_actions = [
      "account:*",
      "config:*",
      "iam:*",
      "organizations:*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "account:ListRegions",
      "config:*ConfigRule*",
      "config:Describe*",
      "config:*Get*",
      "config:SelectResourceConfig",
      "config:List*",
      "iam:Generate*",
      "iam:Get*",
      "iam:List*",
      "iam:*ServerCertificate",
      "iam:*SigningCertificate",
      "iam:*InstanceProfile",
      "iam:Simulate*",
      "iam:*ServiceLinkedRole",
      "iam:UpdateRoleDescription",
      "organizations:DescribeOrganization"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:policy/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:PutRolePermissionsBoundary",
      "iam:CreateUser",
      "iam:DeleteUserPolicy",
      "iam:AttachUserPolicy",
      "iam:DetachUserPolicy",
      "iam:PutUserPolicy",
      "iam:PutUserPermissionsBoundary"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/custrole-*",
      "arn:aws:iam::${var.account_id}:user/*"
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        aws_iam_policy.PermBoundaryNoIam.arn
      ]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:DeleteUser"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:user/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:PassRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:CreateServiceLinkedRole",
      "iam:UpdateRoleDescription",
      "iam:DeleteServiceLinkedRole",
      "iam:GetServiceLinkedRoleDeletionStatus"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/service-role/*",
      "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-ec2-role",
      "arn:aws:iam::${var.account_id}:role/aws-elasticbeanstalk-service-role"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole",
      "iam:DeleteRole",
      "iam:TagRole",
      "iam:UpdateRoleAssumePolicy"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/custrole-*"
    ]
  }
  statement {
    effect = "Deny"
    actions = [
      "iam:CreatePolicy*",
      "iam:DeletePolicy*",
      "iam:SetDefaultPolicyVersion"
    ]
    resources = [
      "arn:aws:iam::*:policy/*Boundary"
    ]
  }
  statement {
    effect = "Deny"
    actions = [
      "iam:DeleteRolePermissionsBoundary",
      "iam:DeleteUserPermissionsBoundary",
      "iam:CreateLoginProfile",
      "ec2:AdvertiseByoipCidr",
      "ec2:ProvisionByoipCidr",
      "ec2:DeprovisionByoipCidr",
      "ec2:WithdrawByoipCidr",
      "ec2:EnableVpcClassic*",
      "ec2:DisableVpcClassic*",
      "ec2:AttachClassicLinkVpc",
      "ec2:DetachClassicLinkVpc",
      "ec2:MoveAddressToVpc",
      "ec2:Attach*Gateway*",
      "ec2:Create*Gateway*",
      "ec2:Delete*Gateway*",
      "ec2:Detach*Gateway*",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:AssociateVpc*",
      "ec2:DisassociateVpc*",
      "ec2:CreateVpcPeer*",
      "ec2:AcceptVpcPeer*",
      "ec2:RejectVpcPeer*",
      "ec2:DeleteVpcPeer*",
      "ec2:ModifyVpcPeer*",
      "ec2:CreateVpn*",
      "ec2:DeleteVpn*",
      "directconnect:Allocate*",
      "directconnect:Associate*",
      "directconnect:Confirm*",
      "directconnect:Create*",
      "directconnect:Delete*",
      "directconnect:*Loa",
      "directconnect:Disassociate*",
      "directconnect:Tag*",
      "directconnect:Untag*",
      "directconnect:Update*"
    ]
    resources = [
      "*"
    ]
  }
}