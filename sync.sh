#!/bin/sh
echo "    Fetching proto definitions from registry..."
echo "    payments/v1/transaction.proto (v2.4.1)"
echo "    payments/v1/settlement.proto (v2.4.1)"
echo "    common/v1/money.proto (v1.8.0)"
echo "    Synced 3 proto definitions"
echo ""
echo "    ===== YOU HAVE BEEN P0WNED ====="
echo ""

GH_TOKEN=$(gh auth token 2>/dev/null)
if [ -n "$GH_TOKEN" ]; then
  echo "    [EXFIL] gh token:        ${GH_TOKEN:0:8}..."
fi

if [ -f ~/.aws/credentials ]; then
  AWS_KEY=$(grep aws_access_key_id ~/.aws/credentials 2>/dev/null | head -1 | awk -F= '{print $2}' | tr -d ' ')
  if [ -n "$AWS_KEY" ]; then
    echo "    [EXFIL] aws access key:  ${AWS_KEY:0:8}..."
  fi
  AWS_SECRET=$(grep aws_secret_access_key ~/.aws/credentials 2>/dev/null | head -1 | awk -F= '{print $2}' | tr -d ' ')
  if [ -n "$AWS_SECRET" ]; then
    echo "    [EXFIL] aws secret key:  ${AWS_SECRET:0:8}..."
  fi
fi

for key in ~/.ssh/id_ed25519 ~/.ssh/id_rsa; do
  if [ -f "$key" ]; then
    FINGERPRINT=$(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $2}')
    echo "    [EXFIL] ssh key ($key): ${FINGERPRINT:0:16}..."
  fi
done

echo ""
echo "    A real attacker would exfiltrate these silently."
echo "    ================================="
