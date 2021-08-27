# Create Network Security Group
resource "azurerm_network_security_group" "bastion" {
  name                = "${var.customer}-${var.project}-${var.env}-bastion"
  resource_group_name = azurerm_resource_group.nexus.name
  location            = azurerm_resource_group.nexus.location

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

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-bastion"
  })
}

# Get a Static Public IP
resource "azurerm_public_ip" "bastion" {
  name                = "${var.customer}-${var.project}-${var.env}-bastion"
  resource_group_name = azurerm_resource_group.nexus.name
  location            = azurerm_resource_group.nexus.location
  allocation_method   = "Dynamic"

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-bastion"
  })
}

# Create Network Card for the VM
resource "azurerm_network_interface" "bastion" {
  name                = "${var.customer}-${var.project}-${var.env}-bastion"
  resource_group_name = azurerm_resource_group.nexus.name
  location            = azurerm_resource_group.nexus.location

  ip_configuration {
      name                          = "${var.customer}-${var.project}-${var.env}-bastion"
      subnet_id                     = azurerm_subnet.nexus-public.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.bastion.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-bastion"
  })
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.bastion.id
    network_security_group_id = azurerm_network_security_group.bastion.id
}

# Create bastion VM
resource "azurerm_linux_virtual_machine" "bastion" {
  name                  = "${var.customer}-${var.project}-${var.env}-bastion"
  resource_group_name   = azurerm_resource_group.nexus.name
  location              = azurerm_resource_group.nexus.location
  network_interface_ids = [azurerm_network_interface.bastion.id]
  size                  = var.bastion_instance_type
  admin_username        = var.bastion_os_user

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
      username       = var.bastion_os_user
      public_key     = var.keypair_public
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.project}-${var.env}-bastion"
    role = "bastion"
  })
}