FROM google/dart

WORKDIR /app
ADD pubspec.* /app/
RUN pub get --no-precompile
ADD . /app/
RUN pub get --offline --no-precompile

CMD []

ENTRYPOINT ["/usr/bin/dart", "bin/main.dart"]

# Service must listen to $PORT environment variable.
# This default value facilitates local development.
ENV PORT 8888