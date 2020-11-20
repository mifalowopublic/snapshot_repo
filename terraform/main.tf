resource "azurerm_snapshot" "test" {
  count               = length(local.customer_data)
  name                = "${local.vmName}-${local.customer_data[count.index].vmname}"
  location            = "${element(data.azurerm_resource_group.getrglocation.*.location, count.index)}"
  resource_group_name = local.customer_data[count.index].diskrg
  create_option       = "Copy"
  source_uri          = "${element(data.azurerm_managed_disk.getexistingdisk.*.id, count.index)}"
}
