resource "azurerm_virtual_machine" "main" {
    name                  = "${var.vm_name}"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group_name}"
    network_interface_ids = ["${var.nic_id}"]
    vm_size               = "${var.vm_size}"

    # Uncomment this line to delete the OS disk automatically when deleting the VM
    delete_os_disk_on_termination = true

    # Uncomment this line to delete the data disks automatically when deleting the VM
    #delete_data_disks_on_termination = true

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "myosdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = "${var.vm_hostname}"
        admin_username = "${var.vm_admin_user}"
        admin_password = "${var.vm_admin_pwd}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}