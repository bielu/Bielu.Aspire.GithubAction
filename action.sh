#!/bin/bash

main(){
	case $action in

  install)
    echo -n "Installing aspire";
    curl -sSL https://aspire.dev/install.sh | bash;

    ;;
  install)
    echo -n "publishing aspire project";
    cmd_string="aspire publish"
    if [[ -n $PROJECT ]]; then
      cmd_string += " --project $PROJECT"
    fi
    if [[ -n $output ]]; then
      cmd_string += " --output-pat $output"
    fi
    if [[ "$DEBUG" == "true" ]]; then
      cmd_string += " --debug"
    fi
    result=$($cmd_string)
    echo $result
    ;;
  *)
    echo -n "unknown action"
    exit 1
    ;;
esac

}

main