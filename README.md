# fireos-adremover

Remove (or restore) lockscreen ads on Amazon Fire tablets using a script. Tested on Fire Max 11 (Fire OS 8).

## Requirements

* ADB (Android Debug Bridge)
* Linux or a Linux-like shell that can run scripts
* A USB cable connected to the tablet (must support data, not just charging)

## How to use

Clone the repo:

```
git clone https://github.com/n3tfox/fireos-adremover/
cd fireos-adremover
```

Install ADB if you don't already have it:

```
# Debian/Ubuntu
sudo apt install adb

# Fedora
sudo dnf install android-tools

# Arch
sudo pacman -S android-tools
```

Make the scripts executable:

```
chmod +x remove_ads.sh restore_ads.sh
```

Connect your tablet via USB, make sure ADB debugging is enabled, and authorize the connection if prompted.

### Remove ads

```
./remove_ads.sh
```

Example output:

```
Setting global lockscreen ad settings to 0...
Suspending Amazon ad-related packages...
Package com.amazon.kindle.kso new suspended state: true
Package com.amazon.hybridadidservice new suspended state: true
Package com.amazon.advertisingidsettings new suspended state: true
Package com.amazon.adep new suspended state: true
Ad-related packages suspended and settings configured successfully.
Please lock and unlock your tablet to verify.
```

### Restore ads

```
./restore_ads.sh
```

Example output:

```
Restoring global lockscreen ad settings to 1...
Unsuspending Amazon ad-related packages...
Package com.amazon.kindle.kso new suspended state: false
Package com.amazon.hybridadidservice new suspended state: false
Package com.amazon.advertisingidsettings new suspended state: false
Package com.amazon.adep new suspended state: false
Ad-related packages unsuspended successfully.
```

## How it works

This uses package suspension (`pm suspend`) rather than disabling or uninstalling, since Amazon blocks both of those approaches for the KSO (Kindle Special Offers) package on newer Fire OS versions.

`remove_ads.sh`:

```bash
#!/bin/bash
# Script to remove/disable lockscreen ads on Fire OS 8
# It uses the package suspension method since Amazon blocks disabling/uninstalling the KSO package.
echo "Setting global lockscreen ad settings to 0..."
adb shell settings put global LOCKSCREEN_AD_ENABLED 0
adb shell settings put global com.amazon.systemui.kso.mode 0
echo "Suspending Amazon ad-related packages..."
adb shell pm suspend com.amazon.kindle.kso
adb shell pm suspend com.amazon.hybridadidservice
adb shell pm suspend com.amazon.advertisingidsettings
adb shell pm suspend com.amazon.adep
echo "Ad-related packages suspended and settings configured successfully."
echo "Please lock and unlock your tablet to verify."
```
