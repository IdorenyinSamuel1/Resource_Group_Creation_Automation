CREATED=()
FAILED=()

echo
echo "Project:      $PROJECT_NAME"
echo "Azure region: $LOCATION"
echo "Creating project environment resource groups..."
echo

for ENVIRONMENT in "${ENVIRONMENTS[@]}"; do
  RESOURCE_GROUP="${PROJECT_NAME}-${ENVIRONMENT}-RG"
  printf '[INFO] Processing %-24s ' "$RESOURCE_GROUP"

  if az group create \
      --name "$RESOURCE_GROUP" \
      --location "$LOCATION" \
      --tags Project="$PROJECT_NAME" Environment="$ENVIRONMENT" ManagedBy="Bash-AzureCLI" \
      --output none; then
    echo "SUCCESS"
    CREATED+=("$RESOURCE_GROUP")
  else
    echo "FAILED"
    FAILED+=("$RESOURCE_GROUP")
  fi
done

echo
echo "============================================================"
echo "          PROJECT RESOURCE GROUP SUMMARY"
echo "============================================================"
printf '%-34s %s\n' "RESOURCE GROUP" "RESULT"
for RESOURCE_GROUP in "${CREATED[@]}"; do
  printf '%-34s %s\n' "$RESOURCE_GROUP" "Succeeded"
done
for RESOURCE_GROUP in "${FAILED[@]}"; do
  printf '%-34s %s\n' "$RESOURCE_GROUP" "Failed"
done
echo "------------------------------------------------------------"
echo "Successful: ${#CREATED[@]} / ${#ENVIRONMENTS[@]}"
echo "Failed:     ${#FAILED[@]} / ${#ENVIRONMENTS[@]}"
echo "============================================================"

if (( ${#FAILED[@]} > 0 )); then
  exit 1
fi

echo "[INFO] All environment resource groups are ready."
