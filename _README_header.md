# Azure Virtual Desktop Host Pool
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE)

This module helps configuring an Azure Virtual Desktop Host pool.  

It also automate the creation of the diagnostics settings and AVD Host pool private endpoint is private connectivity is selected.  

> Note:  The module currently use the AZAPI provider to configure the publicNetworkAccess attribute as this was not supported by the azurerm provider. When supported the code will be updated.  

## Examples

[01_base_testcase](./examples/01_base_testcase/README.md)  
[02_private_endpoint_testcase](./examples/02_private_endpoint_testcase/README.md)