output "admin_vm_id" {
  value = proxmox_virtual_environment_vm.admin.vm_id
}

output "talos_vm_ids" {
  value = { for k, v in proxmox_virtual_environment_vm.talos : k => v.vm_id }
}

output "truenas_vm_id" {
  value = proxmox_virtual_environment_vm.truenas.vm_id
}
