resource "scaleway_instance_ip" "public_ip1" {
  project_id = var.project_id
}

resource "scaleway_instance_ip" "public_ip2" {
  project_id = var.project_id
}

resource "scaleway_instance_ip" "public_ip3" {
  project_id = var.project_id
}

resource "scaleway_instance_server" "bungee" {
  name = "${local.team}-bungee"

  project_id = var.project_id
  type       = "DEV1-L"
  image      = "ubuntu_jammy"

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
    cloud-init = file("${path.module}/init_instance_bungee.sh")
    "srvmine1-1name" = "${scaleway_instance_server.srvmine1.name}"
    "srvmine1-2ip" = "${scaleway_instance_server.srvmine1.public_ip}"
    "srvmine2-3name" = "${scaleway_instance_server.srvmine2.name}"
    "srvmine2-4ip" = "${scaleway_instance_server.srvmine2.public_ip}"
  }

  depends_on = [ scaleway_instance_server.srvmine1 ]


}

resource "scaleway_instance_server" "srvmine1" {
  name = "${local.team}-srvmine1"

  project_id = var.project_id
  type       = "DEV1-L"
  image      = "ubuntu_jammy"

  tags = ["front", "web"]

  ip_id = scaleway_instance_ip.public_ip2.id

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

resource "scaleway_instance_server" "srvmine2" {
  name = "${local.team}-srvmine2"

  project_id = var.project_id
  type       = "DEV1-L"
  image      = "ubuntu_jammy"

  tags = ["front", "web"]

  ip_id = scaleway_instance_ip.public_ip3.id

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


output "bungee-ip" {
  value = "${scaleway_instance_server.bungee.public_ip}"
}

output "srvmine1-ip" {
  value = "${scaleway_instance_server.srvmine1.public_ip}"
}

output "srvmine2-ip" {
  value = "${scaleway_instance_server.srvmine2.public_ip}"
}
