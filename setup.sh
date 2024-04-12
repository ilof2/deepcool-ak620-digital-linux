#!/bin/bash

declare -A PRODUCTS

PRODUCTS=(
    [ak620]="0x0002"
    [ak500s]="0x0004"
)

usage() {
    echo "usage: ./setup.sh <model> <sensor> [-dt | --disable-temp] [-du | --disable-utils]"
    echo -e "\t-dt, --disable-temp:\tdisable sensor temperature display"
    echo -e "\t-du, --disable-utils:\tdisable CPU utilization display"
}

if [ "$#" -lt 2 ]
then
    echo "Please provide valid product and hardware sensor names."
    usage
    exit 1
fi

PRODUCT=$1
SENSOR=$2

while [[ $# -gt 2 ]]; do
    case "$3" in
        -dt|--disable-temp)
            sed -i "/SHOW_TEMP = True/c\SHOW_TEMP = False" deepcool-ak-series-digital.py
            break
            ;;
        -du|--disable-utils)
            sed -i "/SHOW_UTIL = True/c\SHOW_UTIL = False" deepcool-ak-series-digital.py
            break
            ;;
        *)
            echo "Invalid optional argument."
            usage
            exit 1
            ;;
    esac
done

sed -i "/PRODUCT_ID = 0/c\PRODUCT_ID = ${PRODUCTS[${PRODUCT}]}" deepcool-ak-series-digital.py
sed -i "/SENSOR = \"\"/c\SENSOR = \"${SENSOR}\"" deepcool-ak-series-digital.py

sudo cp -f deepcool-ak-series-digital.service /lib/systemd/system/
sudo cp -f deepcool-ak-series-digital-restart.service /lib/systemd/system/
sudo cp -f deepcool-ak-series-digital.py /usr/bin/deepcool-ak-series-digital.py

sudo systemctl enable deepcool-ak-series-digital.service
sudo systemctl enable deepcool-ak-series-digital-restart.service
sudo systemctl start deepcool-ak-series-digital.service
