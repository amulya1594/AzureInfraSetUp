terraform {
  backend "azurerm" {
    resource_group_name  = "tfaccesskeys"
    storage_account_name = "ackeys"
    container_name       = "terraform-backend-files"
    access_key           = ""
  }
}