FROM nginx:alpine
LABEL org.opencontainers.image.authors="Mateus Da Silva Lima"
LABEL description="Minha primeira aplicação web em Docker"
LABEL version="1.0"
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
