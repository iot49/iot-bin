# /bin/zsh

DATE=$(date +'20%y-%m-%d')

cd $IOT/micropython
git checkout iot

# idf 4 only!
# source $ESPIDF/export.sh

function make_board () {
    echo ports/${1:?Port folder is required}: make BOARD=${2:?Board name is required}
    cd $IOT/micropython/ports/$1
    # make clean
    make BOARD=$2
    cp build-$2/firmware.bin    $IOT/iot-bin/micropython/$1-$2-firmware.bin 2>/dev/null
    cp build-$2/application.bin $IOT/iot-bin/micropython/$1-$2-application.bin 2>/dev/null
    cp build-$2/firmware.dfu    $IOT/iot-bin/micropython/$1-$2-firmware.dfu 2>/dev/null
}

make_board "esp32" "GENERIC_OTA"
make_board "stm32" "ADAFRUIT_F405_EXPRESS"
