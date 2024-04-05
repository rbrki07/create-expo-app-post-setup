#!/bin/bash

set -e
 
# Local variables
github_repo="https://raw.githubusercontent.com/rbrki07/create-expo-app-post-setup/main"
package_file="package.json"
package_tmp_file="package.json.tmp"
eslint_config_file=".eslintrc.json"
eslint_ignore_file=".eslintignore"
prettier_config_file=".prettierrc.json"
prettier_ignore_file=".prettierignore"
simple_git_hooks_config_file=".simple-git-hooks.json"
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

echo "Looking for jq..."
if ! command -v jq > /dev/null; then
	echo "Not found."
	echo ""
	echo "=============================================================================================================="
	echo " Please install jq on your system."
	echo ""
	echo " Restart after installing jq."
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

npm install --silent --save-dev eslint-config-universe
npm install --silent --save-dev eslint-plugin-react-native
npm install --silent --save-dev eslint-plugin-jest

echo "=============================================================================================================="
echo "Downloading ESLint config and ignore file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/eslint/$eslint_config_file" > "$eslint_config_file"
curl --fail --location --progress-bar "$github_repo/templates/eslint/$eslint_ignore_file" > "$eslint_ignore_file"

echo "=============================================================================================================="
echo "Add scripts 'lint' and 'lint:fix' to package.json..."
echo "=============================================================================================================="

jq '.scripts += { "lint": "eslint .", "lint:fix": "eslint --fix ." }' $package_file > $package_tmp_file && mv $package_tmp_file $package_file

echo "=============================================================================================================="
echo "Installing Prettier..."
echo "=============================================================================================================="

npm install --silent --save-dev prettier

echo "=============================================================================================================="
echo "Downloading Prettier config and ignore file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/prettier/$prettier_config_file" > "$prettier_config_file"
curl --fail --location --progress-bar "$github_repo/templates/prettier/$prettier_ignore_file" > "$prettier_ignore_file"

echo "=============================================================================================================="
echo "Add scripts 'format' and 'format:fix' to package.json..."
echo "=============================================================================================================="

jq '.scripts += { "format": "prettier --check .", "format:fix": "prettier --check ." }' $package_file > $package_tmp_file && mv $package_tmp_file $package_file

echo "=============================================================================================================="
echo "Installing simple-git-hooks..."
echo "=============================================================================================================="

npm install --silent --save-dev simple-git-hooks

echo "=============================================================================================================="
echo "Downloading simple-git-hooks config file..."
echo "=============================================================================================================="

echo "* Downloading..."
curl --fail --location --progress-bar "$github_repo/templates/simple-git-hooks/$simple_git_hooks_config_file" > "$simple_git_hooks_config_file"

echo "=============================================================================================================="
echo "Apply simple-git-hooks..."
echo "=============================================================================================================="

npx simple-git-hooks

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