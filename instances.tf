resource "scaleway_instance_ip" "public_ip1" {
  project_id = var.project_id
}

resource "scaleway_instance_server" "srvmine1" {
  name = "${local.team}-srvmine1"

  project_id = var.project_id
  type       = "DEV1-L"
  image      = "debian_bullseye"

  tags = ["front", "web"]

  ip_id = scaleway_instance_ip.public_ip1.id

  #additional_volume_ids = [scaleway_instance_volume.data.id]

  root_volume {
    # The local storage of a DEV1-L instance is 80 GB, subtract 30 GB from the additional l_ssd volume, then the root volume needs to be 50 GB.
    size_in_gb = 50
  }

  security_group_id = scaleway_instance_security_group.securitygroup_defou.id

  #user_data                   = file("../Scripts/instance_init1.sh")

  user_data = {
    name        = "initscript"
    cloud-init = file("${path.module}/init_instance.sh")
    #cloud-init = file("${path.module}/deploy-wp")
  }


}


output "srvmine1" {
  value = "${scaleway_instance_server.srvmine1.public_ip}"
}
