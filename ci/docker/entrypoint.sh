#!/bin/sh
echo "window.ENV_GRPC_URL='${ENV_GRPC_URL}';" > /usr/share/nginx/html/js/env.js
echo "window.ENV_HTTP_URL='${ENV_HTTP_URL}';" >> /usr/share/nginx/html/js/env.js
echo "window.ENV_IMAGE_PROXY='${ENV_IMAGE_PROXY}';" >> /usr/share/nginx/html/js/env.js
echo "window.ENV_SENTRY_DSN='${ENV_SENTRY_DSN}';" >> /usr/share/nginx/html/js/env.js