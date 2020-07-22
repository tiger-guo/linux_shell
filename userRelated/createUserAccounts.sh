#!/bin/bash

input="data/userAccounts.csv"
while IFS=',' read -r userId name
do
    echo "adding $userId"
    useradd -c "$name" -m $userId
done < "$input"
