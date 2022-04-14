resource "oci_core_security_list" "sldmz" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.apodo}-sldmz"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    source = var.dmz
    protocol    = "all"
  }

 dynamic ingress_security_rules {
    for_each = local.puertosdmz
    iterator = i
    content {
             protocol  = "6"         // tcp
             source    = "0.0.0.0/0"
             stateless = false
             tcp_options {
               min = i.value
               max = i.value
               }
            }
    }
}
resource "oci_core_security_list" "slapp" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.apodo}-slapp"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    source = var.vcn
    protocol    = "all"
  }

 dynamic ingress_security_rules {
    for_each = local.puertosapp
    iterator = i
    content {
             protocol  = "6"         // tcp
             source    = var.dmz
             stateless = false
             tcp_options {
               min = i.value
               max = i.value
               }
            }
    }
}
resource "oci_core_security_list" "sldata" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.apodo}-sldata"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  ingress_security_rules {
    source = var.data
    protocol    = "all"
  }

 dynamic ingress_security_rules {
    for_each = local.puertosdata
    iterator = i
    content {
             protocol  = "6"         // tcp
             source    = var.app
             stateless = false
             tcp_options {
               min = i.value
               max = i.value
               }
            }
    }
}
