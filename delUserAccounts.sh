#!/bin/bash

input="data/userAccounts.csv"

while IFS=',' read -r userid name
do
    echo "del $userid"
    userdel $userid
done < "$input"
