resource "aws_iam_role" "appOwner" {
  name                 = "ApplicationOwner"
  description          = "The Eleveated Permission Role That Is Given To The Owner Of The Application"
  max_session_duration = "14400"
  permissions_boundary = var.perm_boundary_with_iam
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "app_owner" {
  for_each = toset(var.app_owner_policies)
  role = aws_iam_role.appOwner.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}

resource "aws_iam_role" "appTeam" {
  name                 = "ApplicationTeam"
  description          = "The Standard Role That Is Given To Users Onboardoing To The Cloud"
  max_session_duration = "14400"
  permissions_boundary = var.perm_boundary_no_iam

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "app_team" {
  for_each = toset(var.app_team_policies)
  role = aws_iam_role.appTeam.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}

resource "aws_iam_policy" "auditor" {
  name        = "Auditor_Boundary"
  description = "Policy To Govern Auditor's Role's Permissions"
  policy = data.aws_iam_policy_document.auditor.json
  lifecycle {
    ignore_changes = [
      description
    ]
  }
}

resource "aws_iam_role" "auditor" {
    name                 = "ApplicationTeam"
  description          = "The Standard Role That Is Given To Users Onboardoing To The Cloud"
  max_session_duration = "14400"
  permissions_boundary = var.perm_boundary_no_iam

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "auditor" {
  for_each = toset(var.auditor_policies)
  role = aws_iam_role.auditor.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}

resource "aws_iam_role" "admin" {
  name                 = "CloudAdmin"
  description          = "The Role That The Cloud Team(Humans) Will Use To Adminisitrate This Account"
  max_session_duration = "14400"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "auditor" {
  for_each = toset(var.admin_policies)
  role = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}