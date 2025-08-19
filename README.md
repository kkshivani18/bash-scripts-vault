# Bash Scripts Collection

This repository contains two main directories of bash scripts:

## 1. Azure Bash Scripts (`az-bash-scripts/`)

Collection of production-ready scripts for Azure cloud automation and management.

### Scripts:

#### azure-vm-lifecycle.sh
A comprehensive Azure VM management script that provides:
- Azure CLI installation check
- Authentication handling
- Resource Group management
- VM creation with SSH/Password authentication
- VM lifecycle operations:
  - Start/Stop VM
  - Restart VM
  - Check VM Status
  - Delete VM
  - Deallocate VM

Usage:
```bash
./azure-vm-lifecycle.sh
```

## 2. Bash Practice (`bash prac/`)

This directory contains various bash scripts created during the learning and development process. These scripts are small practicing projects of bash scripting concepts.

## Prerequisites

- Azure CLI (for Azure scripts)
- Bash shell environment
- Active Azure subscription (for Azure scripts)

## Getting Started

1. Clone this repository
2. Ensure you have required prerequisites installed
3. For Azure scripts:
   ```bash
   cd az-bash-scripts
   chmod +x *.sh
   ./script-name.sh
   ```

## Note

- Azure scripts require authentication with Azure CLI
- Make sure to review and understand scripts before execution
- Practice scripts are for learning purposes and may not be production-ready

## License

This project is licensed under the [MIT License](LICENSE)