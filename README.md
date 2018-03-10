# drone-swagger-codegen

Drone plugin for generating client libraries from a swagger spec.

## Docker

Build the Docker image with the following commands:

```
docker build --rm=true -f Dockerfile -t plugins/swagger-codegen .
```

## Usage

Execute from the working directory:

```
docker run --rm \
  -e PLUGIN_SOURCE=./swagger.yml \
  -e PLUGIN_LANGUAGE=javascript \
  -e PLUGIN_TARGET=./client/javascript \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  plugins/swagger-codegen --dry-run
```
