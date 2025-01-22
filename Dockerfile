FROM ubuntu:latest
LABEL maintainer="henrytharansg@gmail.com"

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    apache2 \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download the zip file using curl
RUN curl -L https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip -o /var/www/html/photogenic.zip

# Extract the zip file and clean up
WORKDIR /var/www/html/
RUN unzip photogenic.zip \
    && rm -f photogenic.zip

# Move extracted files to the correct location
RUN cp -rvf photogenic/* . \
    && rm -rf photogenic

# Start Apache in the foreground when the container starts
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

# Expose port 80
EXPOSE 80
