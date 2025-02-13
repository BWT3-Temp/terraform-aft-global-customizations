

resource "aws_iam_policy" "PermBoundaryNoIam" {
  name        = "Permission_Boundary_No_IAM"
  description = "Permission Boundary Without IAM Capabilities"

  policy = data.aws_iam_policy_document.perm-boundary-no-iam.json

  lifecycle {
    ignore_changes = [
      description
    ]
  }
}

resource "aws_iam_policy" "PermBoundaryWithIam" {
  name        = "Permission_Boundary_With_IAM_v1_5"
  description = "Permission Boundary For The Application Owner Role"

  policy = data.aws_iam_policy_document.perm-boundary-with-iam.json
  lifecycle {
    ignore_changes = [
      description
    ]
  }
}
