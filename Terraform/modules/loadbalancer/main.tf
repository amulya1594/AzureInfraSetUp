resource "azurerm_lb" "demo" {
  name                = "TestLoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${var.public_id}"
  }
}
resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = "${var.rg}"
  loadbalancer_id     = "${azurerm_lb.demo.id}"
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "example" {
  resource_group_name = "${var.rg}"
  loadbalancer_id     = "${azurerm_lb.demo.id}"
  name                = "http-probe"
 // protocol          = "Http"
  //request_path      = "/"
  port                = 3389
}
resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = "${var.rg}"
  name                           = "ssh"
  loadbalancer_id                = "${azurerm_lb.demo.id}"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50005
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_rule" "demo-rule" {
  count                          ="${length(var.ports)}"
  resource_group_name            = "${var.rg}"
  loadbalancer_id                = "${azurerm_lb.demo.id}"
  probe_id                       = "${azurerm_lb_probe.example.id}"
  name                           = "LBRule-${count.index+1}"
  protocol                       = "Tcp"
  frontend_port                  = "${var.ports[count.index]}"
  backend_port                   = "${var.ports[count.index]}"
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.bpepool.id}"
}


