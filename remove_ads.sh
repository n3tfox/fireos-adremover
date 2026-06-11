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
