#!/bin/bash

curl -i -X POST -H "Content-Type: application/x-www-form-urlencoded"  \
  --user your-client-id:your-client-secret \
  -d 'code=yourCode&grant_type=authorization_code&redirect_uri=http%3A%2F%2Fmy-cool-endpoint.localhost%2Fcallback' \
  http://127.0.0.1:4444/oauth2/token
