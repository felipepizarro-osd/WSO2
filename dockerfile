# Usa una imagen base con AdoptOpenJDK 11 preinstalado
FROM adoptopenjdk:11-jre-hotspot

# Instala unzip (necesario para descomprimir archivos)
RUN apt-get update \
    && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /opt

# Copia el archivo ZIP de WSO2 Identity Server al contenedor
COPY wso2is-6.1.0.zip .

# Descomprime el archivo ZIP
RUN unzip wso2is-6.1.0.zip \
    && rm wso2is-6.1.0.zip

# Establece el directorio de trabajo en el servidor WSO2
WORKDIR /opt/wso2is-6.1.0

# Exponer puertos según las necesidades de WSO2 Identity Server
EXPOSE 9443 9763

# Comando de inicio del servidor
CMD ["bin/wso2server.sh"]
