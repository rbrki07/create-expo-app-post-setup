#!/bin/bash

set -e
 
# Local variables
github_repo="https://raw.githubusercontent.com/rbrki07/create-expo-app-post-setup/main"
eslint_config_file=".eslintrc.json"
prettier_config_file=".prettierrc.json"
vscode_extensions_config_file="extensions.json"
vscode_settings_config_file="settings.json"

echo "=============================================================================================================="
echo "Checking prerequisites..."
echo "=============================================================================================================="

echo "Looking for npm..."
if ! command -v npm > /dev/null; then
	echo "Not found."
	echo "=============================================================================================================="
	echo " Please install npm on your system."
	echo ""
	echo " Restart after installing npm."
	echo "=============================================================================================================="
	echo ""
	exit 1
fi

echo "Looking for curl..."
if ! command -v curl > /dev/null; then
	echo "Not found."
	echo ""
	echo "=============================================================================================================="
	echo " Please install curl on your system."
	echo ""
	echo " Restart after installing curl."
	echo "=============================================================================================================="
	echo ""
	exit 1
fi

echo "=============================================================================================================="
echo "Installing ESLint..."
echo "=============================================================================================================="

npm install --silent --save-dev eslint

echo "=============================================================================================================="
echo "Installing ESLint plugins..."
echo "=============================================================================================================="

npm install --silent --save-dev eslint-plugin-react-native
npm install --silent --save-dev eslint-plugin-react-hooks
npm install --silent --save-dev eslint-plugin-jest


echo "=============================================================================================================="
echo "Downloading ESLint config-file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/eslint/$eslint_config_file" > "$eslint_config_file"

echo "=============================================================================================================="
echo "Installing Prettier..."
echo "=============================================================================================================="

npm install --silent --save-dev prettier

echo "=============================================================================================================="
echo "Downloading Prettier config-file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/prettier/$prettier_config_file" > "$prettier_config_file"

echo "=============================================================================================================="
echo "Creating local directory '.vscode'..."
echo "=============================================================================================================="

mkdir -p .vscode

echo "=============================================================================================================="
echo "Downloading VS Code Extensions config-file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/vscode/$vscode_extensions_config_file" > ".vscode/$vscode_extensions_config_file"

echo "=============================================================================================================="
echo "Downloading VS Code Settings config-file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/vscode/$vscode_settings_config_file" > ".vscode/$vscode_settings_config_file"

echo ""
echo "Post setup successful."
echo "Please install VS Code Extensions 'ESLint' (esbenp.prettier-vscode) and 'Prettier' (dbaeumer.vscode-eslint)."
echo ""

# Open VS Code with current directory, if 'code' command is available
if command -v code > /dev/null; then
	code .
fi