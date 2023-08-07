@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd C:\ADB\Bin
    set /p last=<color.cfg
REM Setting Up Location
set "config.txt=C:\ADB\Bin\config.txt"

REM Setting Valve
color %last%
cd %open%
REM:PSG
title @Advanced tool by {PSG}

REM Getting Values via TXT
for /f "tokens=1* delims==" %%a in (%config.txt%) do (
    set "%%a=%%b")

:boot
cls
mode con cols=60 lines=20
echo.
echo    MM   MM  SSSSS
echo    MMM MMM  SS
echo    MM M MM  SSSSS
echo    MM   MM     SS
echo    MM   MM  SSSSS
echo.
timeout /t 1 /nobreak >null
goto :home

:home
cls
echo A Android utility by PSG
echo.
echo ############ Home ###############
echo 1. Reboot
echo 2. Flash
echo 3. Tools
echo 4. Advance_Mod
echo 5. Color_Changer
echo 6. Help
echo 7. Exit
echo.
set /p "choice=Enter your choice: "
if %choice% equ 1 goto :reboot
if %choice% equ 2 goto :flash
if %choice% equ 3 goto :tools
if %choice% equ 4 goto :advance_mod
if %choice% equ 5 goto :color_changer
if %choice% equ 6 goto :help
if %choice% equ 7 goto :exit
echo Bad Request
echo Going To Home
timeout /t 1 /nobreak >null
goto :home

:reboot
cls
echo ################# Reboot Sub Menu #################
echo.
echo 1. Reboot to ROM
echo 2. Reboot to Recovery
echo 3. Reboot to Fastboot
echo 4. Go Back
echo.
set /p "choice=Enter your choice: "
if %choice% equ 1 goto :rom
if %choice% equ 2 goto :rec
if %choice% equ 3 goto :fast
if %choice% equ 4 goto :home
echo Bad Request
echo Going To Reboot
timeout /t 1 /nobreak >null
goto :reboot

:flash
cls
echo ################# Flash Sub Menu #################
echo.
echo 1. Magisk
echo 2. ADB Sideload
echo 3. Flash Recovery
echo 4. GSI
echo 5. Go Back

echo.
set /p "choice=Enter your choice: "

if %choice% equ 1 goto :magisk
if %choice% equ 2 goto :adb
if %choice% equ 3 goto :reco
if %choice% equ 4 goto :gsi
if %choice% equ 5 goto :home
echo Bad Request
echo Going To Flash
timeout /t 1 /nobreak >null
goto :flash

:tools
cls
echo ################# Tools Sub Menu #################
echo.
echo 1. Unlock
echo 2. CRB
echo 3. Mi_Flash Tool
echo 4. DNS
echo 5. Deblotware
echo 6. Mi_Unlock
echo 7. Mi_Pro
echo 8. Go Back
echo.
set /p "choice=Enter your choice: "
if %choice% equ 1 (
    echo Unlock option selected.
    echo Coming Soon
    timeout /t 2 /nobreak >null
    goto :continue_or_quit
)
if %choice% equ 2 (
    echo Unlock option selected.
    echo Coming Soon
    timeout /t 2 /nobreak >null
    goto :continue_or_quit
)
if %choice% equ 3 (
    echo Mi_Flash Tool option selected.
    start "" "%MIF%"
    goto :continue_or_quit
)
if %choice% equ 4 (
    echo DNS option selected.
    start "" "%DNS%"
    goto :continue_or_quit
)
if %choice% equ 5 (
    echo Deblotware option selected.
    start "" "%Deblotware%"
    goto :continue_or_quit
)
if %choice% equ 6 (
    echo Mi_Unlock option selected.
    start "" "%MIU%"
    goto :continue_or_quit
)
if %choice% equ 7 (
    echo Mi_Pro option selected.
    start "" "%PRO%"
    goto :continue_or_quit
)
if %choice% equ 8 (
    echo Going To Home
    timeout /t 1 /nobreak >null
    goto :home
) else (
    echo Bad Request 
    timeout /t 1 /nobreak >null
    goto :tools
)

:exit
echo Thank you
echo Visit Again
echo Press any key to exit 
pause >null
exit /b

:continue_or_quit
echo.
set /p "choice=Do you want to continue? (Y/N): "
if /i "%choice%" equ "Y" goto :home
goto :exit

:rom
set /p mode="Enter the mode (REC/BOOT): "

if "%mode%"=="REC" (
    echo Running adb reboot...
    adb reboot
goto :continue_or_quit
) else "%mode%"=="BOOT" (
    echo Running fastboot reboot...
    fastboot reboot
   goto :continue_or_quit

:rec
echo Booting In Recovery
   adb reboot recovery
   goto :continue_or_quit

:fast
echo Booting In Fastboot 
   adb reboot fastboot
   goto :continue_or_quit

:gsi
set /p device_type=Enter device type (A/AB): 
set /p img_location=Enter location of image file (e.g., system.img): 

if /i "%device_type%"=="A" (
    fastboot devices
    fastboot --disable-verification flash vbmeta vbmeta.img
    fastboot reboot fastboot
    fastboot getvar is-userspace
    fastboot erase system
    fastboot delete-logical-partition product
    fastboot flash system "%img_location%"
    fastboot reboot recovery
) else if /i "%device_type%"=="AB" (
    fastboot devices
    fastboot --disable-verification flash vbmeta vbmeta.img
    fastboot reboot fastboot
    fastboot getvar is-userspace
    fastboot erase system
    fastboot delete-logical-partition product_insertslothere
    fastboot flash system "%img_location%"
    fastboot reboot recovery
) else (
    echo Invalid device type entered. Please enter 'A' or 'AB'.
timeout /t 1 /nobreak >null
)
   goto :continue_or_quit

:reco
 set /p loc=Enter location of recovery img:
set /p ab=Enter 'a' or 'b':
if /i "%ab%"=="a" (
    fastboot flash recovery %loc%
    fastboot boot %loc%
) else if /i "%ab%"=="b" (
    fastboot boot %loc%
) else (
    echo Invalid choice. Please enter either 'a' or 'b'.
    timeout /t 1 /nobreak >null
)
   goto :continue_or_quit


:color_changer
cls
echo ################# Color Changer #################
echo Available colors:
echo 0 = Black        8 = Gray
echo 1 = Blue         9 = Light Blue
echo 2 = Green        A = Light Green
echo 3 = Aqua         B = Light Aqua
echo 4 = Red          C = Light Red
echo 5 = Purple       D = Light Purple
echo 6 = Yellow       E = Light Yellow
echo 7 = White        F = Bright White
echo.
set /p "color_choice=Enter the hexadecimal color code (0-F): "
color %color_choice%
 >color.cfg echo %color_choice%
echo This is a text with the selected color.

goto :continue_or_quit

:advance_mod
title AM
prompt @Advance_Mod
color 2
cls
cmd.exe
goto :continue_or_quit

:magisk
set /p mode="Enter the mode (ROM/REC): "
if /i "%mode%"=="ROM" (
	echo installing app
    adb install %m%
    echo Need To Reboot to Continue
    pause
    adb reboot recovery
	echo select adb sideload
    pause
     pushing your package upp...
    adb sideload %m%
    echo completed reboot to rom
    pause
adb reboot
goto :continue_or_quit
) else if /i "%mode%"=="REC" (
    echo select adb sideload
	pause
echo pushing your package upp...
    adb sideload %M% 
echo completed
    pause
echo reboot is needed
    adb reboot
    pause
echo install app left
    adb install %m%
  goto :continue_or_quit
)
:adb
set /p loc=Enter zip location:
echo Plz Select ADB Sideload
pause
echo Processing your package 
adb sideload %loc%
echo done..!
   goto :continue_or_quit

:help
cls
echo ################# Flash Tool Help #################
tinue_or_quit