FROM ubuntu:latest
LABEL authors="luis"

ENTRYPOINT ["top", "-b"]


# Usa la imagen oficial de Ruby como base
FROM ruby:3.2.0

# Instala las dependencias, incluyendo el paquete de reemplazo libmariadb-dev-compat
RUN apt-get update -qq && apt-get install -y build-essential libmariadb-dev-compat nodejs


# Instala rbenv y ruby-build
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Instala una versión específica de Ruby
#RUN rbenv install 3.2.0
#RUN rbenv global 3.2.0

# Crea y establece el directorio de trabajo en /app
WORKDIR /app

# Copia el Gemfile y Gemfile.lock a la imagen
COPY Gemfile Gemfile.lock ./

# Instala las gemas de la aplicación
RUN gem install bundler:2.4.13
RUN bundle install

# Copia el resto de la aplicación a la imagen
COPY . .

# Expon el puerto 3000 (ajusta según sea necesario)
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["rails", "server", "-b", "0.0.0.0"]
