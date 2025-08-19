#!/bin/bash

set -e

echo "--- Azure VM Lifecycle Automation ---"

# check Azure CLI

if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Install it: https://learn.microsoft.com/cli/azure/install-azure-cli"
    exit
fi

echo "✅ Azure CLI is installed"
echo "------------------------------------------------------"

# check login

if ! az account show &> /dev/null; then
    echo "Not logged in. About to login Azure..."
    az login
fi

echo "✅ Logged in as: $(az account show --query user.name -o tsv)"
echo "-------------------------------------------------------"

# resource grp setup

read -rp "Enter Resource Group name: " RG_NAME
read -rp "Enter Azure region (e.g. eastus, westus): " LOCATION

# check resource grp exists

if az group show --name "$RG_NAME" &> /dev/null; then
    echo "Resource group: '$RG_NAME' already exists."
    echo "------------------------------------------------------"

else
    echo "Creating Resource Group '$RG_NAME' --location '$LOCATION'..."
    az group create --name "$RG_NAME" --location "$LOCATION" \
        --output none
    echo "Resource Group created"
    echo "------------------------------------------------------"
fi

# check if VM exists and configured it with ssh key

read -rp "Enter VM name: " VM_NAME

if az vm show --resource-group "$RG_NAME" --name "$VM_NAME" &> /dev/null; then
    echo "✅ VM '$VM_NAME' already exists in resource group '$RG_NAME'."
    echo "------------------------------------------------------"
else
    echo "No VM named '$VM_NAME' found. Let's create it..."
    read -rp "Enter VM size (e.g. Standard_B1s, Standard_B2s): " VM_SIZE
    read -rp "Enter admin username: " ADMIN_USER
    read -rp "Enter SSH key path (without .pub, press Enter to skip): " SSH_KEY_PATH

    if [[ -n "$SSH_KEY_PATH" && -f "$SSH_KEY_PATH.pub" ]]; then
        echo "✅ Creating VM '$VM_NAME' using SSH key: $SSH_KEY_PATH"
        az vm create \
            --resource-group "$RG_NAME" \
            --name "$VM_NAME" \
            --image Ubuntu2204 \
            --size "$VM_SIZE" \
            --admin-username "$ADMIN_USER" \
            --ssh-key-values "$SSH_KEY_PATH.pub" \
            --output none
    else
        echo "No SSH key provided. Using password authentication..."
        read -rsp "Enter admin password (min 12 chars, mix of letters/numbers/symbols): " ADMIN_PASS
        echo
        az vm create \
            --resource-group "$RG_NAME" \
            --name "$VM_NAME" \
            --image Ubuntu2204 \
            --size "$VM_SIZE" \
            --admin-username "$ADMIN_USER" \
            --admin-password "$ADMIN_PASS" \
            --output none
    fi
fi

# get public IP of VM

VM_PUBLIC_IP=$(az vm show \
    --resource-group "$RG_NAME" \
    --name "$VM_NAME" \
    --show-details \
    --query publicIps -o tsv)

echo "✅ VM Public IP: $VM_PUBLIC_IP"
echo "------------------------------------------------------"

# connection hints
if [[ -n "$SSH_KEY_PATH" && -f "$SSH_KEY_PATH" ]]; then
    echo "To connect via SSH key:"
    echo "ssh -i $SSH_KEY_PATH $ADMIN_USER@$VM_PUBLIC_IP"
else
    echo "To connect via password login:"
    echo "ssh $ADMIN_USER@$VM_PUBLIC_IP"
fi

# Lifecycle Management of VM

echo "------------------------------------------------------"
echo "Lifecycle Management of VM"
echo "Choose next action for VM '$VM_NAME': "
echo "1) Start VM"
echo "2) Stop VM"
echo "3) Restart VM"
echo "4) Check VM Status"
echo "5) Delete VM"
echo "6) Deallocate VM"
echo "7) Exit"
read -rp "Enter choice [1-7]: " ACTION

case $ACTION in
  1)
    echo "Starting VM '$VM_NAME'"
    az vm start --resource-group "$RG_NAME" --name "$VM_NAME"
    ;;
  2)
    echo "Stopping VM '$VM_NAME'"
    az vm stop --resource-group "$RG_NAME" --name "$VM_NAME"
    ;;
  3)
    echo "Restarting VM '$VM_NAME'"
    az vm restart --resource-group "$RG_NAME" --name "$VM_NAME"
    ;;
  4)
    echo "Checking VM status"
    az vm get-instance-view --resource-group "$RG_NAME" --name "$VM_NAME" \
      --query "instanceView.statuses[?starts_with(code,'PowerState/')].displayStatus" -o tsv
    ;;
  5)
    echo "Deleting VM '$VM_NAME'"
    az vm delete --resource-group "$RG_NAME" --name "$VM_NAME" --yes
    ;;
  6)
    echo "Deallocating VM $VM_NAME'"
    az vm deallocate --resource-group "$RG_NAME" --name "$VM_NAME"
    ;;
  7)
    echo "Exiting lifecycle script."
    exit 0
    ;;
  *)
    echo "Invalid choice. Exiting"
    exit 1
    ;;
esac