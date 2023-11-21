#!/bin/bash

# Configuración de la API de Porkbun
API_KEY="$DDNS_API_KEY"
SECRET_KEY="$DDNS_SECRET_KEY"
DOMAIN="$DOMAIN"

echo "API Key: $API_KEY"
echo "Secret Key: $SECRET_KEY"
echo "Domain: $DOMAIN"

# Intervalo de tiempo entre comprobaciones (en segundos)
INTERVAL=300
OLD_IP=""

while true; do
    CURRENT_IP=$(curl -s http://whatismyip.akamai.com/)

    if [ "$CURRENT_IP" != "$OLD_IP" ]; then
        # Actualizar IP si ha cambiado
        RESPONSE=$(curl -X POST "https://porkbun.com/api/json/v3/dns/edit/$DOMAIN" \
             -H "Content-Type: application/json" \
             -d '{"apikey": "'$API_KEY'", "secretapikey": "'$SECRET_KEY'", "content": "'$CURRENT_IP'"}')

        # Manejar la respuesta aquí si es necesario
        echo "$RESPONSE"
        OLD_IP=$CURRENT_IP
    fi

    sleep $INTERVAL
done
