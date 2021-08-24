resource "azurerm_public_ip" "bastion" {
  name                = "${var.project}-${var.env}-bastion"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.nexus.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.project}-${var.env}-bastion"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.nexus.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.public.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
