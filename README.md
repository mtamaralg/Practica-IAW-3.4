# Práctica: Dockerización de una aplicación web y publicación en Docker Hub

**Asignatura:** Implantación de Aplicaciones Web (IAW)  
**Curso:** 2025/2026  
**Alumna:** Marina Tamaral Gonzalez 
**Usuario Docker Hub:** [tamaralgonzalezm](https://hub.docker.com/u/tamaralgonzalezm)  
**Imagen Pública:** `tamaralgonzalezm/nginx-2048`

---

## 1. Introducción
El objetivo fundamental de esta práctica es profundizar en el proceso de **creación de imágenes personalizadas** mediante el uso de archivos **Dockerfile**. A diferencia de prácticas anteriores donde se utilizaban imágenes oficiales de Docker Hub, en este caso hemos definido nuestra propia infraestructura empaquetando un servidor web **Nginx** junto con el código fuente del juego **2048** sobre una base de **Ubuntu**.

---

## 2. Definición del Dockerfile
Se ha diseñado un archivo `Dockerfile` siguiendo un flujo lógico de construcción para garantizar que la imagen sea funcional y ligera:

* **Imagen Base**: Se utiliza `FROM ubuntu:latest`, partiendo de una distribución Linux estándar y actualizada.
* **Actualización y Dependencias**: Se ejecutan comandos `apt-get` para actualizar los repositorios e instalar **Nginx** (servidor web) y **Git** (control de versiones).
* **Inyección de Código**: Se ha limpiado el directorio por defecto de Nginx (`/var/www/html/`) y se ha clonado el repositorio oficial del juego 2048 mediante Git.
* **Exposición de Puertos**: Se define el puerto **80** como el canal de comunicación del contenedor.
* **Comando de Ejecución**: Se establece `nginx -g "daemon off;"` como proceso principal para que el contenedor permanezca activo mientras el servidor esté funcionando.

---

## 3. Proceso de Construcción y Publicación

### 3.1. Creación de la Imagen (Build)
Desde la terminal de la instancia EC2 de AWS, se procedió a construir la imagen asignando el tag correspondiente a mi usuario de Docker Hub:
`docker build -t tamaralgonzalezm/nginx-2048 .`

### 3.2. Publicación en el Registro Remoto (Push)
Para que la imagen sea accesible desde cualquier lugar del mundo, se llevaron a cabo los siguientes pasos de publicación:
1. **Autenticación**: Inicio de sesión mediante `sudo docker login` para vincular las credenciales de la terminal con la cuenta de Docker Hub.
2. **Subida de Capas**: Ejecución del comando `sudo docker push tamaralgonzalezm/nginx-2048`, lo que transfiere todas las capas de nuestra imagen personalizada a la nube de Docker.

---

## 4. Verificación y Despliegue
La imagen ha quedado publicada con éxito. Para verificar su portabilidad, se puede ejecutar en cualquier máquina con Docker instalado mediante el comando:
`docker run -d -p 80:80 tamaralgonzalezm/nginx-2048`

Este comando descargará automáticamente la imagen desde Docker Hub y levantará el servidor Nginx con el juego 2048 disponible en el puerto 80 del host.

---
