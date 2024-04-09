import time

import hid
import psutil

VENDOR_ID = 0x3633  # DeepCool's Vendor ID
PRODUCT_ID = 0x0004
CHIPSET = "coretemp"
INTERVAL = 2


def get_bar_value(input_value):
    return (input_value - 1) // 10 + 1


def get_data(value=0, mode="util"):
    base_data = [16] + [0 for i in range(64 - 1)]
    numbers = [int(char) for char in str(value)]
    base_data[2] = get_bar_value(value)
    if mode == "util":
        base_data[1] = 76
    elif mode == "start":
        base_data[1] = 170
        return base_data
    elif mode == "temp":
        base_data[1] = 19

    if len(numbers) == 1:
        base_data[5] = numbers[0]
    elif len(numbers) == 2:
        base_data[4] = numbers[0]
        base_data[5] = numbers[1]
    elif len(numbers) == 3:
        base_data[3] = numbers[0]
        base_data[4] = numbers[1]
        base_data[5] = numbers[2]
    elif len(numbers) == 4:
        base_data[3] = numbers[0]
        base_data[4] = numbers[1]
        base_data[5] = numbers[2]
        base_data[6] = numbers[3]

    return base_data


def get_temperature():
    temp = round(psutil.sensors_temperatures()[CHIPSET][0].current)
    return get_data(value=temp, mode="temp")


def get_utils():
    utils = round(psutil.cpu_percent())
    return get_data(value=utils, mode="util")


try:
    h = hid.device()
    h.open(VENDOR_ID, PRODUCT_ID)
    h.set_nonblocking(1)
    h.write(get_data(mode="start"))
    while True:
        h.set_nonblocking(1)
        h.write(get_temperature())
        time.sleep(INTERVAL)
        h.write(get_utils())
        time.sleep(INTERVAL)
except IOError as error:
    print(error)
    print(
        "Ensure that the AK Series CPU cooler is connected and the script has the correct Vendor ID and Product ID."
    )
except KeyboardInterrupt:
    print("Script terminated by user.")
finally:
    h.close()
