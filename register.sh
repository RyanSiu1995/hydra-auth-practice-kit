#!/bin/bash

curl -i -X POST -H "content-type: application/json" \
  -d '{
  "client_id": "your-client-id",
  "client_secret": "your-client-secret",
  "grant_types": ["authorization_code","refresh_token"],
  "response_types": ["code","id_token"],
  "scope": "openid,offline",
  "redirect_uris": ["http://my-cool-endpoint.com/callback"]
}' http://127.0.0.1:4445/clients
