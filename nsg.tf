resource "oci_core_network_security_group" "nsg" {
	compartment_id = var.compartment_ocid
	vcn_id = oci_core_vcn.vcn.id
	display_name = "${var.apodo}-NSG-DATA"
}
resource "oci_core_network_security_group_security_rule" "nsgr" {
    network_security_group_id = oci_core_network_security_group.nsg.id
    direction = "INGRESS"
    protocol = "6"
    source_type = "CIDR_BLOCK"
    source = var.vcn
    tcp_options {
        destination_port_range {
            min = 1521
            max = 1522
        }
    }
}
resource "oci_core_network_security_group" "nsg2" {
	compartment_id = var.compartment_ocid
	vcn_id = oci_core_vcn.vcn.id
	display_name = "${var.apodo}-NSG-WINDOWS"
}
resource "oci_core_network_security_group_security_rule" "nsgr2" {
    network_security_group_id = oci_core_network_security_group.nsg2.id
    direction = "INGRESS"
    protocol = "6"
    source_type = "CIDR_BLOCK"
    source = "0.0.0.0/0"
    tcp_options {
        destination_port_range {
            min = 3389
            max = 3389
        }
    }
}
resource "oci_core_network_security_group" "nsg3" {
	compartment_id = var.compartment_ocid
	vcn_id = oci_core_vcn.vcn.id
	display_name = "${var.apodo}-NSG-HTTP80"
}
resource "oci_core_network_security_group_security_rule" "nsgr3" {
    network_security_group_id = oci_core_network_security_group.nsg3.id
    direction = "INGRESS"
    protocol = "6"
    source_type = "CIDR_BLOCK"
    source = "0.0.0.0/0"
    tcp_options {
        destination_port_range {
            min = 80
            max = 80
        }
    }
}
