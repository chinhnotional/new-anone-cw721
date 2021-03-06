#!/bin/bash

NODE="http://65.108.128.139:2281"
#ACCOUNT="test"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1t03wt66r7xqszqfwyjhvklyynrk2tyqelhk30u9aga48ajy5kclq0xt3tt"
MARKETPLACE_CONTRACT_ADDR="one1qm8dzr6lyz9swhq98tgejhf9r8usqc64v5arjpf2jtpjs0w5yewqx3hkqs"
TOKEN_ID="$1"

APPROVE="{\"approve\": {\"token_id\":\"$TOKEN_ID\", \"spender\":\"$MARKETPLACE_CONTRACT_ADDR\"}}"

echo $APPROVE

RES=$(anoned tx wasm execute "$CONTRACT" "$APPROVE" --from "$ACCOUNT" -y --output json --chain-id "$CHAINID" --node "$NODE" --gas 35000000 --fees 0uan1 -y --output json)
echo $RES

TXHASH=$(echo $RES | jq -r .txhash)

echo $TXHASH

# sleep for chain to update
sleep "$SLEEP_TIME"

RAW_LOG=$(anoned query tx "$TXHASH" --chain-id "$CHAINID" --node "$NODE" -o json | jq -r .raw_log)

echo $RAW_LOG