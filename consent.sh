#!/bin/bash

curl -i -X PUT -H "Content-Type: application/json" \
  -d '{
  "grant_scope": ["my-scope"]
}' \
  http://127.0.0.1:4445/oauth2/auth/requests/consent/accept?consent_challenge=string
