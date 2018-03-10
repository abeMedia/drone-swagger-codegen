#!/bin/sh
set -e

# check for required variables
[ -z "$PLUGIN_LANGUAGE" ] && echo "Output language is not set" && exit 1
[ -z "$PLUGIN_TARGET" ] && echo "Output target is not set" && exit 1

# if swagger spec not set check for local one
[ -z "$PLUGIN_SOURCE" ] && PLUGIN_SOURCE=$(ls swagger.json swagger.yml swagger.yaml 2>/dev/null | head -1)
[ -z "$PLUGIN_SOURCE" ] && echo "Swagger source is not set" && exit 1

# github token auth (for remote swagger spec on private github URL)
[ ! -z "$GITHUB_TOKEN" ] && PLUGIN_AUTH="Authorization:token $GITHUB_TOKEN"

# swagger language configuartion - if not a file we assume it's a JSON string
if [ ! -z "$PLUGIN_CONFIG" ] && [ ! -f "$PLUGIN_CONFIG" ]; then
  echo "$PLUGIN_CONFIG" > /tmp/config.json
  PLUGIN_CONFIG=/tmp/config.json
fi

# java -jar /opt/swagger-codegen-cli/swagger-codegen-cli.jar config-help -l $PLUGIN_LANGUAGE

java -jar /opt/swagger-codegen-cli/swagger-codegen-cli.jar generate \
  --auth "$PLUGIN_AUTH" \
  --config "$PLUGIN_CONFIG" \
  --input-spec "$PLUGIN_SOURCE" \
  --lang "$PLUGIN_LANGUAGE" \
  --output "$PLUGIN_TARGET"
