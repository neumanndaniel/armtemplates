az login --msi
az vm show --show-details --ids $(az vm list --resource-group Compute --query "[].id" --output tsv) --output jsonc
