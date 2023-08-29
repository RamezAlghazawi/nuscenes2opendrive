# Use Python 3.8 as the base image
FROM python:3.8-slim

# Install system dependencies for OpenCV, GTK, and some other potential libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libsm6 \
        libxext6 \
        libxrender-dev \
        libgl1-mesa-glx \
        libglib2.0-0 \
        xvfb && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the nuscenes-to-osm-exporter tool and the Nuscenes maps into the container
COPY nuscenes-to-osm-exporter /app/nuscenes-to-osm-exporter
COPY nuscenes /app/nuscenes


# Install the Python dependencies
RUN pip install -r /app/nuscenes-to-osm-exporter/requirements.txt

# Command that will be executed when the Docker container starts
CMD ["python", "/app/nuscenes-to-osm-exporter/nuscenes_map_to_osm_exporter.py", "/app/nuScenes-map-expansion-v1/expansion"]
