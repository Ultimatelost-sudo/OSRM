# Base image with OSRM
FROM osrm/osrm-backend:latest

# Set the working directory
WORKDIR /data

# Descargar el archivo de mapas de México desde Geofabrik
ADD https://download.geofabrik.de/north-america/mexico-latest.osm.pbf /data/mexico.osm.pbf

# Preparar los datos del mapa para rutas en automóvil
RUN osrm-extract -p /opt/car.lua mexico.osm.pbf && \
    osrm-partition mexico.osrm && \
    osrm-customize mexico.osrm

# Exponer el puerto por defecto de OSRM
EXPOSE 5000

# Iniciar el servidor OSRM con los datos preparados
CMD ["osrm-routed", "--algorithm", "MLD", "mexico.osrm"]