locals {
  customer_data = csvdecode(file("disk_info.csv"))

  timestamp = timestamp()
  timeadd   = timeadd(local.timestamp, "336h")
  Cday    = formatdate("DD", local.timestamp)
  Cmonth  = formatdate("MM", local.timestamp)
  Cyear   = formatdate("YYYY", local.timestamp)
  Dday    = formatdate("DD", local.timeadd)
  Dmonth  = formatdate("MM", local.timeadd)
  Dyear   = formatdate("YYYY", local.timeadd)
  Chour   = formatdate("hh", local.timestamp)
  Cminute = formatdate("mm", local.timestamp)
  Csecond = formatdate("ss", local.timestamp)

  vmName = "${local.Cmonth}-${local.Cday}-${local.Cyear}${local.Chour}-${local.Cminute}-${local.Csecond}_To_${local.Dmonth}-${local.Dday}-${local.Dyear}"
}

data "azurerm_resource_group" "getrglocation" {
  count = length(local.customer_data)
  name  = local.customer_data[count.index].diskrg
}

data "azurerm_managed_disk" "getexistingdisk" {
  count               = length(local.customer_data)
  name                = local.customer_data[count.index].diskname
  resource_group_name = local.customer_data[count.index].diskrg
}
