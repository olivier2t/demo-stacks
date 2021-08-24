resource "azurerm_network_security_group" "nexus" {
  name     = "${var.project}-${var.env}-nexus"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.nexus.name

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
    name                       = "inbound-service"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.env}-nexus"
  })
}

resource "azurerm_public_ip" "nexus" {
  name                = "${var.project}-${var.env}-nexus"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.nexus.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# resource "azurerm_bastion_host" "bastion" {
#   name                = "${var.project}-${var.env}-nexus"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.nexus.name

#   ip_configuration {
#     name                 = "configuration"
#     subnet_id            = azurerm_subnet.public.id
#     public_ip_address_id = azurerm_public_ip.bastion.id
#   }
# }

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { 
    value = tls_private_key.example_ssh.private_key_pem 
    sensitive = true
}

resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "myVM"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "admin"
        public_key     = file("~/.ssh/id_rsa.pub")
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}