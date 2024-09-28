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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCv4akBTas6nmt4xGEYHBWsgVJh+tY8isr65zaLtf7lgXr4QgF6+gayH3zNNPq3WWP9ludVrSwq78WlheEQMrBhsCeNgEzfaObkmc/+Oeni8F1u//8dA8bLuKcM5Y338Dlr/ZScC42D3SK4d0oVf5TBx99n9iJaR3xyJhtUo887x08zKbLpd7tqXy6If4fBuDkd3H7dIX750K1THF8i5N447TVGx847B8EMes1bZ+dTFtH2Avw3NsExSH4gZCcOQJDbFQUs5yowquqLf+Rm0/ufLLahALuH7rHpoEJZznyiMsKJDLLNfQtgfbSNMYK7DUhuemzia4ju1DIjtk8WNf5grTkE/Leqbmf7+WUCEXVN+/lEBUj5qKO+vJZNJaokQ6Bh0vq73BMv7CRZfHv+Mce6Bs5VwTT5224gd9Hq/ZZlsz/rUj1QwLwlR2zbWIxqGwEomf5Sa7wCsqrwJiDSBrwEfgH43fMaTU1BX1aUSwi8OPZf2P9DLK7gBYlsE5Cu4E0= odl_user@SandboxHost-638630802280856496"
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
