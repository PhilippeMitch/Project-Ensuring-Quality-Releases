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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFhWEFhfjd4A/nI3q12synLE0zp85YnwPmjdhhT0N31HEtSzc1mJgtACwZ8KEMD2mekBz9wuUZJEoqVjDUmBr2A3+p7bbdbHMuxd998oimbOBrxaClEgKsWtwn21JG19ZS59db0KeWyU1eUJWErGsXRXepOFn6YWdFgDtFgCLqKtJW5oI1/5ftxMTTRZBGX6CAX6z2/jZRtDtlSBRT+Gscxb0gHSq1JmAuBnw4ui7kJkebcPUheZQsog6lSOs+ec3KP2p3XY1pU0+ALnisGIK5r57rNOF+LCcXgomVvqG+BV52yq5ElIex9aPgG/tv4eUsPDBOerngcZx67CzLbnsiLMF+I3xw+emJgfggKo6n9RdNwbZm0QbK9XFeznHZbUt13v4pmtvUxmY387jJnmu4S0aCbvowlGhCzAjRHsKfomKjeeiA4seKpTrMlerKcTCPP4SngMCQ6ab422v7cu6AnWwpGfxsbD1FVGaeHrf02TbiR3D8IVWgd+ytIb/9xXc= devopsagent@myLinuxVM"
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
