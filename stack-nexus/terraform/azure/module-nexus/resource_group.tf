resource "azurerm_resource_group" "nexus" {
  name     = "${var.project}-${var.env}-nexus"
  location = var.azure_location

  tags = merge(local.merged_tags, {
    Name = "${var.customer}-${var.env}-nexus"
  })
}