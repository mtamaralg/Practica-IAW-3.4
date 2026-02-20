# 1. Imagen base
FROM ubuntu:latest

# 2. Actualizar e instalar nginx
RUN apt-get update && apt-get install -y nginx git

# 3. Clonar la web estática (el juego 2048)
RUN rm -rf /var/www/html/*
RUN git clone https://github.com/josejuansanchez/2048.git /var/www/html/

# 4. Exponer el puerto 80
EXPOSE 80

# 5. Arrancar nginx
CMD ["nginx", "-g", "daemon off;"]
