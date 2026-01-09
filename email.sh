#!/bin/bash

# --- 1. Get current BTC/USD price ---
BTC_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd')
CURRENT_DATE=$(date -R)

# Check if price was retrieved successfully
if [ -z "$BTC_PRICE" ] || [ "$BTC_PRICE" == "null" ]; then
    echo "Error: Could not retrieve BTC price. Using a default or exiting."
    BTC_PRICE="N/A (Error retrieving price)" # Provide a fallback message
    # You might consider exiting here if the price is crucial:
    # exit 1
fi

EMAIL_TEMP_FILE=$(mktemp)
cp "email.txt" "$EMAIL_TEMP_FILE"
sed -i "s|\[DATE\]|$CURRENT_DATE|g" "$EMAIL_TEMP_FILE"
sed -i "s|\[BTC_PRICE\]|$BTC_PRICE|g" "$EMAIL_TEMP_FILE"

curl -v smtp://mail.saxrag.com --mail-from healthcheck@mywaifu.best --mail-rcpt poiasd@saxrag.com --upload-file "$EMAIL_TEMP_FILE"

rm "$EMAIL_TEMP_FILE"