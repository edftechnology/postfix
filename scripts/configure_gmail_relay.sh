#!/usr/bin/env bash
set -euo pipefail

gmail_user="${1:-edendenis@gmail.com}"

printf "Gmail account for Postfix relay [%s]: " "$gmail_user"
IFS= read -r input_user
if [[ -n "$input_user" ]]; then
    gmail_user="$input_user"
fi

printf "Gmail app password for %s: " "$gmail_user"
stty -echo
IFS= read -r gmail_pass
stty echo
printf "\n"

gmail_pass="$(printf '%s' "$gmail_pass" | tr -d '[:space:]')"
if [[ -z "$gmail_pass" ]]; then
    echo "Empty Gmail app password; aborting." >&2
    exit 1
fi

sudo -v

sudo apt-get update
sudo apt-get install -y libsasl2-modules ca-certificates postfix mailutils

backup="/etc/postfix/main.cf.bak-codex-$(date +%Y%m%d-%H%M%S)"
sudo cp -a /etc/postfix/main.cf "$backup"

tmpfile="$(mktemp)"
printf '[smtp.gmail.com]:587 %s:%s\n' "$gmail_user" "$gmail_pass" > "$tmpfile"
sudo install -o root -g root -m 600 "$tmpfile" /etc/postfix/sasl_passwd
rm -f "$tmpfile"

sudo postmap /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd.db

sudo postconf -e 'relayhost = [smtp.gmail.com]:587'
sudo postconf -e 'smtp_sasl_auth_enable = yes'
sudo postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd'
sudo postconf -e 'smtp_sasl_security_options = noanonymous'
sudo postconf -e 'smtp_sasl_tls_security_options = noanonymous'
sudo postconf -e 'smtp_tls_security_level = encrypt'
sudo postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt'
sudo postconf -e 'smtp_use_tls = yes'
sudo postconf -e 'smtp_generic_maps = hash:/etc/postfix/generic'

tmpgeneric="$(mktemp)"
{
    printf 'root@tesla.lan %s\n' "$gmail_user"
    printf 'edenedfsls@tesla.lan %s\n' "$gmail_user"
    printf 'edenedfsls@tesla %s\n' "$gmail_user"
    printf 'howdy@localhost %s\n' "$gmail_user"
    printf 'root %s\n' "$gmail_user"
    printf 'edenedfsls %s\n' "$gmail_user"
} > "$tmpgeneric"
sudo install -o root -g root -m 644 "$tmpgeneric" /etc/postfix/generic
rm -f "$tmpgeneric"

sudo postmap /etc/postfix/generic
sudo systemctl restart postfix

echo "Postfix Gmail relay configured."
echo "Backup created at: $backup"
echo "Run this test:"
echo "  echo \"Postfix Gmail relay test\" | mail -s \"Postfix Gmail relay test\" $gmail_user"
echo "Then check:"
echo "  tail -n 50 /var/log/mail.log"
