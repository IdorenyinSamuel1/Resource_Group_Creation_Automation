# Resource_Group_Creation_Automation
A Bash and Azure CLI automation project that simplifies Azure resource management by automatically creating separate Development, Testing, UAT, and Production resource groups based on a project name.


Resource Group Creation Automation
A Bash + Azure CLI script that automates the creation of separate Azure resource groups for a project's development lifecycle.
Objective
Reduce repetitive manual setup by accepting a project name as a command-line argument and creating four isolated environment resource groups:
- Development (Dev)
- Testing (Test)
- User Acceptance Testing (UAT)
- Production (Production)
Naming convention
For a project named StockWiseAfrica, the script creates:
StockWiseAfrica-Dev-RG
StockWiseAfrica-Test-RG
StockWiseAfrica-UAT-RG
StockWiseAfrica-Production-RG
Each resource group is tagged with its project name, environment, and management method.
Prerequisites
- An active Azure subscription
- Azure CLI installed
- Bash (Linux, macOS, WSL, or Git Bash)
- Permissions to create Azure resource groups
Run
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
chmod +x create-resource-groups.sh
./create-resource-groups.sh StockWiseAfrica
Optionally specify an Azure region:
./create-resource-groups.sh StockWiseAfrica southafricanorth
The default region is eastus. You can also set AZURE_LOCATION before running the script.
Output
The script prints each resource group's result and a final summary showing the number of successful and failed operations. It exits with a non-zero status if any creation fails.
Cleanup
Delete an individual resource group:
az group delete --name StockWiseAfrica-Dev-RG --yes --no-wait
Repeat for the other environments when they are no longer required. Deleting a resource group also deletes the resources contained in it.
Repository structure
resource-group-creation-automation/
├── create-resource-groups.sh
└── README.md
Skills demonstrated
- Bash scripting and argument validation
- Azure CLI
- Environment separation and resource naming conventions
- Azure resource tagging
- Error handling and execution summaries
