#!/bin/bash

main(){
	case $action in

  install)
    echo -n "Installing aspire";
    curl -sSL https://aspire.dev/install.sh | bash
    ;
  *)
    echo -n "unknown action"
    exit 1
    ;;
esac

}

main
