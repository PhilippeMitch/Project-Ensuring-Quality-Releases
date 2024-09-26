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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCV0+oFY2GY6U9hmqXUaYmbuYdNEfBCxQgGf8PTF0+zlJMGkfmPjhj3SgJ0nsevPWwd8XAwYYJxHeTD5HiLZi6Nh/3mN1bXMA+iC9oJddmKIjKHHg4jenLdlxPfCc+1mxn4P+CdO3un31Qa/ndU+23AvuqH4j8ksyHL8P6hTwcSypyF48euTI2Uy9lRbbZpVGtdqMC72MIqC4VcktFJBXB9m0ZvCI5baiddEaeY2ccutEQwxUXvuYWCx8auUUQg8dohKd7U/HXj3C5Ysb0CQPo0icIocLrZqpCcAAz1jK6MrN0Mv+PO1flmsDteQ0aUQWJeI8OoKePj3eiaftvmKMChaCBSkGIrATUJq6zRoG6ajLWA2Z7emyjMWi5iQlV/UQNrzaSsdUxKiIimgNaJgAThztqSdwUj/etoQSUPI99wUE61Fh0qBFJMsIP6CcQqI9Q2HNi8ij5mSIj0WyBGsyejtDWuVGfyOZaAXWKG7tg1kLyrqNHjjVaWUPYJW3zi7+U= devopsagent@myLinuxVM"
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
