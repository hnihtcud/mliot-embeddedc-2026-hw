@echo off 
echo STEP 1: CLEANING BUILD DIRECTORY
if exist build (
    echo Cleaning build directory...
    rmdir /s /q build
)
echo.
echo STEP 2: CONFIGURING PROJECT WITH CMAKE
cmake -B build -G Ninja
if %errorlevel% neq 0 (
    echo [ERROR] CMake configuration failed!
    pause
    exit /b 1
)
echo.
echo STEP 3: COMPILING FIRMWARE WITH NINJA
ninja -C build
if %errorlevel% neq 0 (
    echo [ERROR] Ninja build failed!
    pause
    exit /b 1
)
echo.
echo STEP 4: FLASHING FIRMWARE TO TARGET MCU
STM32_Programmer_CLI -c port=SWD -w build/app_firmware.bin 0x08000000 -v -rst
if %errorlevel% neq 0 (
    echo [ERROR] Flashing firmware failed!
    pause
    exit /b 1
)