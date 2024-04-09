# AK620 Digital Air Cooler Monitor on Linux

This project enables monitoring of temperature and CPU utilization on DeepCool's AK620 digital air cooler for Linux systems. The solution has been tested on Ubuntu 23 with a Ryzen 7950X3D CPU. Customization may be required in the temperature section for other CPUs.

## Dependencies

This script requires the following dependencies:
- Python 3
- `hidapi`
- `psutil`

You can install by running the provided `setup.sh` script:
```bash
./setup.sh
```

### Step-by-Step Guide

1. **Install Python Dependencies**: First, you need to install the necessary Python libraries, `hidapi` and `psutil`. These libraries allow the script to interact with the hardware and monitor system resources.

   Open a terminal and run the following commands:
   ```bash
   pip install hid
   pip install psutil
   ```
    Note: If you encounter permission errors, try adding --user to install the packages for your user only or use sudo to install them system-wide (not recommended for pip).

2. **Clone the Repository**:   The script and necessary configuration files are hosted on GitHub. Use git to clone the repository to your local machine.
    ```bash
    git clone https://github.com/raghulkrishna/deepcool-ak620-digital-linux
   ```
3. **Navigate to the Project Directory**: Change your current directory to the newly cloned project folder.

    ```bash
    cd deepcool-ak620-digital-linux
    ```
4. **Run the Setup Script**: : The setup.sh script will automate the configuration and setup process. Run the script by executing:

    For coolers other than ak620 go to **deepcool-ak620-digital.py** and modify the **DEFAULT_VENDOR_ID** and **DEFAULT_PRODUCT_ID** accordingly. Check Trobuleshooting section on how to get vendor id and product id.

    ```bash
    bash ./setup.sh
    ```    

## Troubleshooting

1) If you encounter any errors related to HIDAPI or psutil, ensure that the dependencies are installed correctly by running the setup.sh script.
2) Make sure the AK620 digital air cooler is properly connected to your system and that the correct Vendor ID and Product ID are set in the script.
3) How to verify Product ID and Vendor ID ?  use lsusb -v to get the list of devices ans search for your cooler.

Credits
https://github.com/Algorithm0/deepcool-digital-info