#!/bin/bash

curl -i -H "Cookie: oauth2_authentication_csrf_insecure=token0" \
  -d 'response_type=code&redirect_uri=http%3A%2F%2Fmy-cool-endpoint.localhost%2Fcallback&client_id=your-client-id&state=my-cool-state' \
  http://127.0.0.1:4444/oauth2/auth?login_verifier=string
