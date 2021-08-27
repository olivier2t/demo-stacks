resource "azurerm_virtual_network" "nexus" {
  name                = "${var.customer}-${var.project}-${var.env}-nexus"
  location            = azurerm_resource_group.nexus.location
  resource_group_name = azurerm_resource_group.nexus.name
  address_space       = [var.cidr]
  dns_servers         = ["8.8.8.8", "8.8.4.4"]

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-nexus"
  })
}

resource "azurerm_subnet" "nexus-private" {
    name                 = "${var.customer}-${var.project}-${var.env}-nexus-private"
    resource_group_name  = azurerm_resource_group.nexus.name
    virtual_network_name = azurerm_virtual_network.nexus.name
    address_prefixes       = var.private_subnets
}

resource "azurerm_subnet" "nexus-public" {
    name                 = "${var.customer}-${var.project}-${var.env}-nexus-public"
    resource_group_name  = azurerm_resource_group.nexus.name
    virtual_network_name = azurerm_virtual_network.nexus.name
    address_prefixes       = var.public_subnets
}