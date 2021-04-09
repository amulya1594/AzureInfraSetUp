
provider "azurerm" {
  features {}
}
 
module "rg1" {
    source = "./modules/resourcegroup"
    rg = "${var.rg1}"
    location= "${var.location1}"
}
 
 
module "vnet" {
    source = "./modules/vnet"
    rg = "${module.rg1.rg}"
    location ="${module.rg1.location}"
    cidr = "${var.cidr1}"
}

module "subnets" {
    source = "./modules/subnet"
    rg = "${module.rg1.rg}"
    location ="${module.rg1.location}"
    vnet ="${module.vnet.vnet_name}"
    subnet  = "${var.subnet1}"
    
}

module "sg" {
    source ="./modules/sg"
    rg = "${module.rg1.rg}"
    location ="${module.rg1.location}"
}

module "publicip" {
    source = "./modules/publicip"
    rg = "${module.rg1.rg}"
    location ="${module.rg1.location}"
    
}
module "loadbalancer" {
    source = "./modules/loadbalancer"
    rg = "${module.rg1.rg}"
    location ="${module.rg1.location}"
    public_id ="${module.publicip.public_id}"
}

 
 
module "scaleset" {
    source = "./modules/autoscale"
    rg = "${module.rg1.rg}"
    location ="${module.rg1.location}"
    admin_name = "${var.admin_user1}"
    admin_password = "${var.admin_password1}"
    bpepool_id ="${module.loadbalancer.address_pool_ids}"
    subnet_id = "${module.subnets.subnet_id}"
    natpool_id = "${module.loadbalancer.nat_pool_ids}"
    sg_id ="${module.sg.sg_id}"
}

 



/* module "log" {
  source ="./modules/log"
  rg = "${module.rg1.rg}"
  location ="${module.rg1.location}"

}
module "monitor" {
    source ="./modules/monitor"
    storage_id = "${module.log.storage_id}"
    target_id= "${module.scaleset.scale_id}"
}
module "cus" {
    source ="./modules/cloudinit"
    scale_id  = "${module.scaleset.scale_id}"
    workspace_id ="${module.log.workspace_id}"
    workspace_key = "${module.log.workspace_key}"

}

module "database" {
    source = "./modules/database"
    rg     = "${module.rg1.rg}"
    location = "${module.rg1.location}"
    sql_server_name = "${var.sql_server_name1}"
    sql_admin_login = "${var.sql_admin_login1}"
    sql_admin_password = "${var.sql_admin_password1}"
    database_name      = "${var.database_name1}"
    internal1          = "${var.internal_subnet}"
    vnet_name          ="${module.vnet.vnet_name}"

    
}
 */
