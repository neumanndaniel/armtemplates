#Windows Server with Microsoft Antimalware, VM Agent and Microsoft Monitoring Agent extension.

The template creates the following parts:

  -Availability set with 2 fault domains and 5 update domains

  -Storage account

  -Virtual Network

  -Public IP address

  -NIC

  -Network Security Group with RDP port 3389 inbound rule from Internet to local subnet prefix

  -Bind Network Security Group to the Virtual Network subnet

  -Tags the VM, NIC, Public IP address with the key environment and the value development, staging or production

The template configures the Microsoft Monitoring Agent extension against your Azure Operational Insights workspace.
