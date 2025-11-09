#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error

main() {
  action=${1:-}  # take the first argument as the action

  case "$action" in

    install)
      echo "Installing Aspire..."
      # Safer: download first, then execute after inspection
      curl -sSL -o /tmp/aspire-install.sh https://aspire.dev/install.sh
      bash /tmp/aspire-install.sh
      ;;

    publish)
      echo "Publishing Aspire project..."

      cmd_string="aspire publish"

      # Add optional parameters if provided
      if [[ -n "${PROJECT:-}" ]]; then
        cmd_string="$cmd_string --project \"$PROJECT\""
      fi

      if [[ -n "${OUTPUT:-}" ]]; then
        cmd_string="$cmd_string --output-path \"$OUTPUT\""
      fi

      if [[ "${DEBUG:-}" == "true" || "${DEBUG:-}" == "True" ]]; then
        cmd_string="$cmd_string --debug"
      fi

      if [[ -n "${BUILD_CONFIGURATION:-}" ]]; then
        cmd_string="$cmd_string /p:configuration=$BUILD_CONFIGURATION"
      fi

      echo -e "\nRunning command: $cmd_string\n"
      eval "$cmd_string"
      ;;

    *)
      echo "Unknown action: '$action'"
      echo "Usage: $0 {install|publish}"
      exit 1
      ;;
  esac
}

main "$@"
