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
