#!/bin/bash
project_directory="5-3-1-helper"
project_name="5-3-1-helper"

# Check prerequisites and install them
echo "Updating package list and installing curl..."
sudo apt update
sudo apt install -y curl

# Install Node 18
echo "Adding Node.js PPA and installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js and npm installation
node_version=$(node -v)
npm_version=$(npm -v)

# Install Vue CLI globally
echo "Installing Vue CLI globally..."
sudo npm install -g @vue/cli

# Verify Vue CLI installation
vue_version=$(vue --version)

# Navigate to the project directory
echo "Navigating to $project_directory..."
mkdir -p "$project_directory"
cd "$project_directory" || { echo "Directory not found"; exit 1; }

# Create a new Vue.js project
echo "Creating a new Vue.js project '$project_name'..."
vue create "$project_name" -n
cd "$project_name" || { echo "Failed to enter project directory"; exit 1; }

# Install Tailwind CSS
echo "Installing Tailwind CSS..."
npm install -D tailwindcss

# Initialize Tailwind CSS configuration
echo "Initializing Tailwind CSS configuration..."
npx tailwindcss init

# Modify tailwind.config.js content section
echo "Modifying tailwind.config.js to include Vue files..."
sed -i "s/content: \[\]/content: \['\.\/src\/\*\*\/\*\.\{html,js,vue\}'\]/g" tailwind.config.js

# Create assets folder and Tailwind CSS entry file
mkdir -p src/assets
cat <<EOL > src/assets/tailwind.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Import Tailwind CSS in main.js
echo "Importing Tailwind CSS in main.js..."
sed -i "1i import './assets/tailwind.css';" src/main.js

# Install jsPDF
echo "Installing jsPDF..."
npm install jspdf

# Success message
echo "------------------------------------------------------------"
echo "Setup Complete!"
echo "Node.js version: $node_version"
echo "npm version: $npm_version"
echo "Vue CLI version: $vue_version"
echo "Your Vue.js project '$project_name' has been created at $project_directory."
echo "Tailwind CSS and jsPDF have been installed."
echo "To start your project, navigate to the project directory and run 'npm run serve'."
echo "------------------------------------------------------------"

