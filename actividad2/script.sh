# Leer la variable GITHUB_USER
read -p "Ingrese su nombre de usuario de GitHub: " GITHUB_USER

# Consultar la URL y obtener la información
URL="https://api.github.com/users/$GITHUB_USER"
RESPONSE=$(curl -s "$URL")
ID=$(echo "$RESPONSE" | jq -r '.id')
CREATED_AT=$(echo "$RESPONSE" | jq -r '.created_at')

# Imprimir el mensaje
MESSAGE="Hola $GITHUB_USER. User ID: $ID. Cuenta fue creada el: $CREATED_AT."
echo "$MESSAGE"

# Crear el directorio de log y el archivo de log
LOG_DIR="/tmp/$(date +'%Y%m%d')"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/saludos.log"

# Escribir el mensaje en el archivo de log
echo "$MESSAGE" >> "$LOG_FILE"

echo "Mensaje registrado en $LOG_FILE"

# Agregar el cronjob para ejecutar el script cada 5 minutos
CRON_ENTRY="*/5 * * * * $(realpath $0)"
(crontab -l; echo "$CRON_ENTRY") | crontab -

echo "Cronjob agregado para ejecutar el script cada 5 minutos"
