module "permission_boundaries" {
  count = 0
  source = "./modules/iam/permission_boundaries"
  account_id = local.account_id
}

module "roles" {
  count = 0
  source = "./modules/iam/roles"
  account_id = local.account_id
  perm_boundary_no_iam = module.permission_boundaries.no_iam
  perm_boundary_with_iam = module.permission_boundaries.with_iam
  app_owner_policies = [
    "IAMFullAccess",
    "PowerUserAccess"
  ]
  app_team_policies = [
    "IAMFullAccess",
    "PowerUserAccess"
  ]
  auditor_policies = [
    "ReadOnlyAccess",
    "AWSSupportAccess"
  ]
  admin_policies = [
    "AdministratorAccess"
  ]
}