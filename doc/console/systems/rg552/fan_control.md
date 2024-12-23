## More convenient fan control

<details>
<summary>create "fan_control.cpp"</summary>

```cpp
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <limits>

void showHelp(const std::string& programName) {
    std::cout << "usage:\n";
    std::cout << programName << " <0-255> - set fan speed\n";
    std::cout << programName << " - check fan speed\n";
    std::exit(1);
}

bool isNumber(const std::string& str) {
    for (char c : str) {
        if (!std::isdigit(c)) {
            return false;
        }
    }
    return true;
}

int main(int argc, char* argv[]) {
    const std::string pwmFile = "/sys/class/hwmon/hwmon1/pwm1";

    if (argc != 2) {
        // Display current fan speed
        std::ifstream pwmInput(pwmFile);
        if (!pwmInput.is_open()) {
            std::cerr << "Error: Unable to read fan speed from " << pwmFile << "\n";
            return 1;
        }

        std::string currentSpeed;
        std::getline(pwmInput, currentSpeed);
        std::cout << currentSpeed << "\n";
        return 0;
    }

    std::string arg = argv[1];

    // Check for valid integer input
    if (!isNumber(arg)) {
        showHelp(argv[0]);
    }

    int speed = std::stoi(arg);

    // Validate range
    if (speed < 0 || speed > 255) {
        showHelp(argv[0]);
    }

    // Set fan speed
    std::ofstream pwmOutput(pwmFile);
    if (!pwmOutput.is_open()) {
        std::cerr << "Error: Unable to set fan speed in " << pwmFile << "\n";
        return 1;
    }

    pwmOutput << speed;
    if (!pwmOutput) {
        std::cerr << "Error: Failed to write fan speed. Ensure you have the proper permissions.\n";
        return 1;
    }

    return 0;
}
```
</details>

compile it 
```
g++ fan_control.cpp -o fan_control
```
_Note. you might need to install g++ if not present_
_Note. we do c++ because bash scripts don't work with u+s_

copy ```fan_control``` to ```/bin/fan_control```
```
sudo cp fan_control /bin/
```

make it owned by root
```
sudo chown root:root /bin/fan_control
```

make it execute with root permissions
```
sudo chmod u+s /bin/fan_control
```

now you don't need to type password everytime you want to change fan speed
you can also add button modifying fan speed to your desktop environment of choice
for example 

## gnome
using [this](https://extensions.gnome.org/extension/7012/custom-command-toggle/) gnome extension
![Screenshot From 2024-12-21 19-43-00](https://github.com/user-attachments/assets/e96f5c42-af86-42aa-a224-3225fdd1e6c9)

## automatic

<details>
<summary>create "auto_fan_control.sh"</summary>

```bash
#!/bin/bash

# File paths
TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"  # Update this path if necessary
FAN_SPEED_FILE="/sys/class/hwmon/hwmon1/pwm1"   # Update this path if necessary

# Fan speed values
FAN_HIGH=255
FAN_LOW=70

while true; do
    # Read CPU temperature (convert from millidegrees to degrees)
    if [[ -r $TEMP_FILE ]]; then
        CPU_TEMP=$(cat $TEMP_FILE)
        CPU_TEMP=$((CPU_TEMP / 1000))
    else
        echo "Error: Cannot read CPU temperature file: $TEMP_FILE"
        exit 1
    fi

    # Adjust fan speed based on temperature
    #if temperatur is greater than 60 degress, set max fan speed
    if [[ $CPU_TEMP -gt 60 ]]; then
        /bin/fan_control $FAN_HIGH
    #if temperature is lower than 40 degresss, set fan to low speed
    elif [[ $CPU_TEMP -lt 40 ]]; then
        /bin/fan_control $FAN_LOW
    fi

    # Wait for 10 seconds
    sleep 10
done
```
</details>

_Note. you can adjust check interval, speed and temperature parameters to your liking_

move it to ```/usr/local/bin``` and make executable
```
sudo mv auto_fan_control.sh /usr/local/bin/auto_fan_control.sh
sudo chmod +x /usr/local/bin/auto_fan_control.sh
```

<details>
<summary>create systemd service file at "/etc/systemd/system/auto_fan_control.service"</summary>

```systemd
[Unit]
Description=Auto Fan Speed Control Service
After=multi-user.target

[Service]
ExecStart=/usr/local/bin/auto_fan_control.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```
</details>

enable and start the service
```
sudo systemctl daemon-reload
sudo systemctl enable --now auto_fan_control.service
```

check if service is fine
```
sudo systemctl status auto_fan_control.service
```