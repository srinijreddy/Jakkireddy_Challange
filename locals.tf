# locals
locals {
  user_data_internal = <<-EOF
                    #!/bin/bash
                    yum -y install httpd
                    echo "${file("index.html")}" > /var/www/html/index.html
                    sudo systemctl restart httpd
                    EOF
  az1                  = "${var.region}a"
  az2                  = "${var.region}b"
  az3                  = "${var.region}c"
}