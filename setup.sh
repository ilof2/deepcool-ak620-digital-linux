#!/bin/bash

declare -A PRODUCTS

PRODUCTS=(
    [ak620]="0x0002"
    [ak500s]="0x0004"
)

if [ "$#" -ne 2 ]
then
    echo "Please provide valid product and chipset names."
    exit 1
fi

PRODUCT=$1
CHIPSET=$2

sed -i "/PRODUCT_ID = 0/c\PRODUCT_ID = ${PRODUCTS[${PRODUCT}]}" deepcool-ak-series-digital.py
sed -i "/CHIPSET = \"\"/c\CHIPSET = \"${CHIPSET}\"" deepcool-ak-series-digital.py

sudo cp -f deepcool-ak-series-digital.service /lib/systemd/system/
sudo cp -f deepcool-ak-series-digital-restart.service /lib/systemd/system/
sudo cp -f deepcool-ak-series-digital.py /usr/bin/deepcool-ak-series-digital.py

sudo systemctl enable deepcool-ak-series-digital.service
sudo systemctl enable deepcool-ak-series-digital-restart.service
sudo systemctl start deepcool-ak-series-digital.service
