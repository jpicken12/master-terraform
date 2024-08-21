terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.114.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

# create a resource group
resource "azurerm_resource_group" "rg1" {
  name     = "learn-windows-powershell"
  location = "uk south"
}

# create a virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "learn-windows-powershell-vnet"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  address_space       = ["10.0.0.0/16"]
}

# create a subnet
resource "azurerm_subnet" "subnet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

# create a nic
resource "azurerm_network_interface" "nic1" {
  name                = "nic1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id
  }
}

# create a pip
resource "azurerm_public_ip" "pip1" {
  name                = "pip1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"
}

# create an nsg
resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location

  security_rule {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
}

# associate the nsg to the nic
resource "azurerm_network_interface_security_group_association" "nsg-asc1" {
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "pwsh1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B2s"
  admin_username      = "espadmin"
  admin_password      = "EspM4llorca!$"

  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
    #publisher = "MicrosoftWindowsServer"
    #offer     = "microsoftserveroperatingsystems-previews"
    #sku       = "windows-server-2022-azure-edition-preview"
    #version   = "latest"
  }
}

output "pip_addr" {
  value = azurerm_public_ip.pip1.ip_address
}