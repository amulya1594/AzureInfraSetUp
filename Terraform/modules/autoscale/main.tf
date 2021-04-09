data "azurerm_image" "image" {
  name                = "myPackerWinImage"
  resource_group_name = "packer"
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "vmscaleset"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"
  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_DS1_v2"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    id="${data.azurerm_image.image.id}"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun          = 0
    caching        = "ReadWrite"
    create_option  = "Empty"
    disk_size_gb   = 10
  }

  os_profile {
    computer_name_prefix = "vmlab"
    admin_username       = "${var.admin_name}"
    admin_password       = "${var.admin_password}"
    //custom_data          = file("${path.module}/web.conf")
  }


  network_profile {
    name    = "terraformnetworkprofile"
    primary = true
    network_security_group_id = "${var.sg_id}"

    ip_configuration {
      name                                   = "IPConfiguration"
      subnet_id                              = "${var.subnet_id}"
      load_balancer_backend_address_pool_ids = ["${var.bpepool_id}"]
    //  load_balancer_inbound_nat_rules_ids    = ["${var.natpool_id}"]
      primary = true
    }
  }
  
}





/* resource "azurerm_monitor_autoscale_setting" "example" {
  name                = "rengaconfig"
  resource_group_name = "${var.rg}"
  location            = "${var.location}"
  target_resource_id  = "${azurerm_virtual_machine_scale_set.vmss.id}"
  profile {
    name = "Profile"

    capacity {
      default = 2
      minimum = 2
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = "${azurerm_virtual_machine_scale_set.vmss.id}"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = "${azurerm_virtual_machine_scale_set.vmss.id}"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
 */