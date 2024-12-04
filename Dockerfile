# Usa la misma versión de Ruby especificada en el Gemfile
FROM ruby:3.3.6

# Instala las dependencias necesarias
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configura el usuario de Git (opcional)
RUN git config --global user.name "tu_usuario"
RUN git config --global user.email "tu_correo"

# Configura el directorio de trabajo
WORKDIR /usr/src/app

# Copia los archivos Gemfile y Gemfile.lock para instalar gemas
COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock

# Instala las gemas especificadas en el Gemfile
RUN bundle install

# Copia el resto del código de la aplicación al contenedor
COPY . /usr/src/app

# Expone el puerto 3000 para la aplicación Rails


# Comando para iniciar el servidor de Rails
#CMD ["rails", "server", "-b", "0.0.0.0"]
#CMD ["rake","db:migrate"]

# 4. Crear un proyecto
#    rails new .
# 5. Establecer permisos desde el anfitrion
#    sudo chown -R usuario:grupo *
#   sudo chown -R 1000:1000 *
# 6. Lanzar el servidor
#    rails server -b 0.0.0.0
# 7. Abrir otra terminal
#    docker exec -it appmvc bash
# 8. Permisos git en proyecto
#   sudo chown -R $(whoami):$(whoami) .

#   docker exec -it proyecto_ruby_arq-web-1 bash
#   docker exec -it proyecto_ruby_arq-db-1 bash
COPY entry-point.sh /usr/bin/
RUN chmod +x /usr/bin/entry-point.sh
ENTRYPOINT ["entry-point.sh"]

EXPOSE 3000
