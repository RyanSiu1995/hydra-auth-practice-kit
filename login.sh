#!/bin/bash

curl -i -X PUT -H "Content-Type: application/json" \
  -d '{
  "subject": "whoiam"
}' \
  http://127.0.0.1:4445/oauth2/auth/requests/login/accept?login_challenge=string

