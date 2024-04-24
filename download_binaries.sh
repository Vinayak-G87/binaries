#!/bin/bash

set -e

# Check if kubernetes version is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <KUBERNETES_VERSION>"
  exit 1
fi

KUBERNETES_VERSION="$1"

# Define the URL of the private GitLab repository
GITLAB_REPO_URL="https://gitlab.com"

# Define your GitLab personal access token
GITLAB_TOKEN="your_personal_access_token"

# Define the project path (namespace/project)
PROJECT_PATH="your_namespace/your_project"

# Define the branch name
BRANCH_NAME="your-branch-name"

# Function to download kubectl binary
download_kubectl() {
  local version="$1"
  echo "Downloading kubectl version $version"
  curl -sSL --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "$GITLAB_REPO_URL/api/v4/projects/$PROJECT_PATH/repository/files/bin%2Fkubectl%2F$version%2Fkubectl/raw?ref=$BRANCH_NAME" -o /usr/local/bin/kubectl
  chmod +x /usr/local/bin/kubectl
}

# Function to download kubelogin binary
download_kubelogin() {
  local version="$1"
  echo "Downloading kubelogin version $version"
  curl -sSL --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "$GITLAB_REPO_URL/api/v4/projects/$PROJECT_PATH/repository/files/bin%2Fkubelogin%2F$version%2Fkubelogin/raw?ref=$BRANCH_NAME" -o /usr/local/bin/kubelogin
  chmod +x /usr/local/bin/kubelogin
}

# Main function to download binaries
main() {
  download_kubectl "$KUBERNETES_VERSION"
  download_kubelogin "$KUBERNETES_VERSION"
}

main
