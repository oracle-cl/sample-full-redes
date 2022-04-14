data "oci_core_vcn_dns_resolver_association" "resolver" {
  vcn_id = oci_core_vcn.vcn.id
}

resource "oci_dns_resolver" "resolver" {
  attached_views {
    view_id = oci_dns_view.v.id
  }
  display_name = var.apodo
  resolver_id = data.oci_core_vcn_dns_resolver_association.resolver.dns_resolver_id
  scope = "PRIVATE"
}

resource "oci_dns_resolver_endpoint" "f" {
  endpoint_type = "VNIC"
  is_forwarding = true
  is_listening = false
  name = "forward1"
  resolver_id = oci_dns_resolver.resolver.id
  scope = "PRIVATE"
  subnet_id = oci_core_subnet.app.id
}

resource "oci_dns_resolver_endpoint" "l" {
  endpoint_type = "VNIC"
  is_forwarding = false
  is_listening = true
  name = "listen1"
  resolver_id = oci_dns_resolver.resolver.id
  scope = "PRIVATE"
  subnet_id = oci_core_subnet.app.id
}


resource "oci_dns_zone" "z" {
  compartment_id = var.compartment_ocid
  name           = var.zona
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  view_id        = oci_dns_view.v.id
}

resource "oci_dns_view" "v" {
  compartment_id = var.compartment_ocid
  scope          = "PRIVATE"
  display_name   = var.zona
}
