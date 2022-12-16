resource "scaleway_instance_security_group" "securitygroup_defou" {
  name = "${local.team}-securitygroup_defou"
  project_id              = var.project_id
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
    ip_range     = "0.0.0.0/0"
  }

  inbound_rule {
    action = "accept"
    port = "25565"
    ip_range = "0.0.0.0/0"
  }

  inbound_rule {
    action = "accept"
    port = "25577"
    ip_range = "0.0.0.0/0"
  }
}


