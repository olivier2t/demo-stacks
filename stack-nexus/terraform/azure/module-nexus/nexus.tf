# Create Network Security Group
resource "azurerm_network_security_group" "nexus" {
  name                = "${var.customer}-${var.project}-${var.env}-nexus"
  resource_group_name = azurerm_resource_group.bastion.name
  location            = azurerm_resource_group.bastion.location

  security_rule {
    name                       = "inbound-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    source_address_prefixes    = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "inbound-nexus"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.nexus_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-nexus"
  })
}

# Get a Static Public IP
resource "azurerm_public_ip" "nexus" {
  name                = "${var.customer}-${var.project}-${var.env}-nexus"
  resource_group_name = azurerm_resource_group.nexus.name
  location            = azurerm_resource_group.nexus.location
  allocation_method   = "Dynamic"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-nexus"
  })
}

# Create Network Card for the VM
resource "azurerm_network_interface" "nexus" {
  name                = "${var.customer}-${var.project}-${var.env}-nexus"
  resource_group_name = azurerm_resource_group.nexus.name
  location            = azurerm_resource_group.nexus.location

  ip_configuration {
      name                          = "${var.customer}-${var.project}-${var.env}-nexus"
      subnet_id                     = azurerm_subnet.nexus-public.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.nexus.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-nexus"
  })
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.nexus.id
    network_security_group_id = azurerm_network_security_group.nexus.id
}

# Create Nexus VM
resource "azurerm_linux_virtual_machine" "nexus" {
  name                  = "${var.customer}-${var.project}-${var.env}-nexus"
  resource_group_name   = azurerm_resource_group.nexus.name
  location              = azurerm_resource_group.nexus.location
  network_interface_ids = [azurerm_network_interface.nexus.id]
  size                  = var.nexus_instance_type
  admin_username        = var.nexus_os_user

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
      publisher = "credativ"
      offer     = "Debian"
      sku       = "8"
      version   = "latest"
  }

  disable_password_authentication = true

  admin_ssh_key {
      username       = var.nexus_os_user
      public_key     = var.keypair_public
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-nexus"
    role = "nexus"
  })
}