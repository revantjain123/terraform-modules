data "template_file" "efs" {
  template = "${file("${path.module}/user_data/mount_efs.sh")}"
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo 'efs_mount_path="${var.efs_mount_path}"' > /opt/efs
    echo 'mount_target_DNS="${var.dns_name}"' >> /opt/efs
    echo 'efs_id="${var.efs_id}"' >> /opt/efs
    EOF
  }
  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.efs.rendered
  }
}
