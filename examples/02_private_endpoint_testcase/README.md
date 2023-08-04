# AVD Host Pool - Private endpoint test case

This is an example for setting-up a an Azure Virtual Desktop Hostpool with a private endpoint

This test case:
- Sets the different Azure Region representation (location, location_short, location_cli ...) --> module "regions"
- Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
- Creates the following module dependencies
    - Resource Group
    - Log Analytics workspace
- Creates two Azure Virtual Desktop Hostpool. one of type Pooled and a second of type Personal  
    - Set the default diagnostics settings (All Logs and metric) whith a the previously configured Log Analytics workspace as destination
    - Creates the private endpoint for each host pool and define two public access types ( Disabled,EnabledForClientsOnly )

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->

<!-- END_AUTOMATED_TF_DOCS_BLOCK -->