
#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Uso: $0 <Nueva_IP>"
  exit 1
fi

NUEVA_IP=$1

CONFIG_FILE=~/.kube/config

if [ ! -f "$CONFIG_FILE" ]; then
  echo "El archivo $CONFIG_FILE no existe."
  exit 1
fi

sed -i '' "s#https://[^:]*:6443#https://$NUEVA_IP:6443#" "$CONFIG_FILE"

echo "La IP del servidor se ha actualizado a $NUEVA_IP en $CONFIG_FILE."

