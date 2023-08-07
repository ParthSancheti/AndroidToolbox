@echo off
set /p mode="Enter the mode (ROM/REC): "
set "m=C:\ADB\Tools\Magisk-v25.2.3.apk"
if /i "%mode%"=="ROM" (
    adb install %m%
    echo Need To Reboot to Continue
    pause
    adb reboot recovery
    pause
    echo select adb sideload
    adb sideload %m%
    echo completed
    pause
adb reboot
    pause
) else if /i "%mode%"=="REC" (
    echo select adb sideload
    adb sideload %M%
    pause
    adb reboot
    pause
    adb install %m%
  pause
)
