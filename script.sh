#!/bin/bash

# Variables
pendrive_path=$(lsblk -o MOUNTPOINT,NAME | awk '$1 == "/media/username/pendrive" {print $2}')  # Detectar la ubicación del pendrive
java_tar=$(find "$pendrive_path" -name "jdk*.tar.gz" | head -n 1)    # Detectar automáticamente el archivo tar.gz de Java
maven_tar=$(find "$pendrive_path" -name "maven*.tar.gz" | head -n 1)  # Detectar automáticamente el archivo tar.gz de Maven
zip_file=$(find "$pendrive_path" -name "wso2is-6.1.0.zip" | head -n 1)     # Detectar automáticamente el archivo zip

# Verificar si el pendrive está montado
if [ -z "$pendrive_path" ]; then
    echo "Error: No se detectó el pendrive montado."
    exit 1
fi

# Instalar Java
echo "Instalando Java..."
tar -zxvf "$java_tar" -C /opt/
echo "export JAVA_HOME=/opt/jdk" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
source ~/.bashrc

# Instalar Maven
echo "Instalando Maven..."
tar -zxvf "$maven_tar" -C /opt/
echo "export MAVEN_HOME=/opt/apache-maven-x.x.x" >> ~/.bashrc
echo "export PATH=\$PATH:\$MAVEN_HOME/bin" >> ~/.bashrc
source ~/.bashrc

# Descomprimir el archivo zip en el directorio del usuario
echo "Descomprimiendo el archivo zip..."
unzip "$(find ~ -name 'wso2is-6.1.0.zip')" -d ~/


# Entrar en la carpeta descomprimida y ejecutar el script
echo "Ejecutando el script dentro de la carpeta bin..."
cd ~/wso2is-6.1.0/bin
./wso2server.sh

# Mostrar información sobre las instalaciones
echo "Java version: $(java -version)"
echo "Maven version: $(mvn -v)"

echo "Instalaciones completadas exitosamente!"
