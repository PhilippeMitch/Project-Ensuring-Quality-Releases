resource "azurerm_network_interface" "" {
  name                = "${var.application_type}-${var.resource_type}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                = "${var.application_type}-${var.resource_type}-internal"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoaLKOs0qe52jyvvaEVa71nvDzgyzDzgJqmeqx6xI4YagpjmKdpT0oTqiYOOnSm+8H0dr6LFvAtBe4hux2troSJJqGsCvSedNqIcJibCkhfymE9C69O/9UayXdFS7N/8O1GxF+rkWcqJhHQeIkDxcSRTSUbZKTgC0isTym+wF+96Ul4O9VeylNhSJJzQRktvy0W6EudDzktOGJwEhdPqtp0Po5lwg/AJntGF0Wxt1DIiZGiGVBkOj0N431XmYADlcDvGaL+IPr/i7HHPYz7Qr8DosMSE23DJfA2unuXmuneW4aKyps0ZnuwrQfVa9nenFw1toq75lU089DbZc5qjFM9bWD3MlAEyiddb0kKJNAp5dE1ONutdqYzkqyuCM6LFVFvv3OiMNw9Ny1MVjqNXQ4q1WP+9hrMJOfyiFMDdQEeDJjl1WviAQ+40tIaVDMEZuq5ry6fqMrEwfJsRdv6o7y6N3J2EWXPFatC6d+gvCLoeFYCjG7p8IvZZ8xBNLfOPc= devopsagent@myLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
