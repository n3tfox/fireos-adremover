#!/bin/bash

# Script to restore lockscreen ads on Fire OS 8
# It unsuspends the ad packages.

echo "Restoring global lockscreen ad settings to 1..."
adb shell settings put global LOCKSCREEN_AD_ENABLED 1
adb shell settings put global com.amazon.systemui.kso.mode 1

echo "Unsuspending Amazon ad-related packages..."
adb shell pm unsuspend com.amazon.kindle.kso
adb shell pm unsuspend com.amazon.hybridadidservice
adb shell pm unsuspend com.amazon.advertisingidsettings
adb shell pm unsuspend com.amazon.adep

echo "Ad-related packages unsuspended successfully."
