variable "region" {}
variable "compartment_ocid" {}

#########################################
variable "apodo" {}
variable "vcn" {}
variable "app" {}
variable "dmz" {}
variable "data" {}
variable "puertosapp" {}
variable "puertosdmz" {}
variable "puertosdata" {}
variable "zona" {}

#########################################
locals {
  puertosapp = [ for i in split(",", var.puertosapp) : trimspace(i) ]
  puertosdmz = [ for i in split(",", var.puertosdmz) : trimspace(i) ]
  puertosdata = [ for i in split(",", var.puertosdata) : trimspace(i) ]
}
