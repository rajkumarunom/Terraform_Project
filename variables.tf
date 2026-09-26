
variable "vms" {
  description = "List of VMs"

  type = map(object({
    vm_name = string
  }))
}

variable "region" {
  type = string
}


variable "rg_name" {
  type = string
}

