resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = var.vcn
  display_name   = "${var.apodo}-vcn"
  dns_label      = "${var.apodo}vcn"
}
resource "oci_core_subnet" "dmz" {
  cidr_block          = var.dmz
  display_name        = "${var.apodo}-dmz"
  dns_label           = "${var.apodo}dmz"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn.id
  security_list_ids   = [oci_core_security_list.sldmz.id]
  route_table_id      = oci_core_route_table.rtdmz.id
  dhcp_options_id     = oci_core_vcn.vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = false
}
resource "oci_core_subnet" "app" {
  cidr_block          = var.app
  display_name        = "${var.apodo}-app"
  dns_label           = "${var.apodo}app"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn.id
  security_list_ids   = [oci_core_security_list.slapp.id]
  route_table_id      = oci_core_route_table.rtapp.id
  dhcp_options_id     = oci_core_vcn.vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}
resource "oci_core_subnet" "data" {
  cidr_block          = var.data
  display_name        = "${var.apodo}-data"
  dns_label           = "${var.apodo}data"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn.id
  security_list_ids   = [oci_core_security_list.sldata.id]
  route_table_id      = oci_core_route_table.rtdata.id
  dhcp_options_id     = oci_core_vcn.vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}
