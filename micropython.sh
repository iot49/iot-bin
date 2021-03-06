# /bin/zsh

DATE=$(date +'20%y-%m-%d')

cd $IOT/micropython
git checkout mp

# idf 4 only!
# source $ESPIDF/export.sh

function make_board () {
    echo ports/${1:?Port folder is required}: make BOARD=${2:?Board name is required} $3
    cd $IOT/micropython/ports/$1

    # make BOARD=$2 clean
    make BOARD=$2 $3

    # copy binaries
    cp build-$2/firmware.bin    $IOT/iot-bin/micropython/$1-$2-firmware.bin 2>/dev/null
    cp build-$2/application.bin $IOT/iot-bin/micropython/$1-$2-application.bin 2>/dev/null
    sha256sum -b build-$2/application.bin >$IOT/iot-bin/micropython/$1-$2-application.sha256 2>/dev/null
    cp build-$2/firmware.dfu    $IOT/iot-bin/micropython/$1-$2-firmware.dfu 2>/dev/null
    cp build-$2/firmware.uf2    $IOT/iot-bin/micropython/$1-$2-firmware.uf2 2>/dev/null
}

make_board "esp32" "GENERIC_OTA"
make_board "stm32" "ADAFRUIT_F405_EXPRESS"

# make_board "nrf"   "particle_xenon" "SD=s140"
# make_board "nrf"   "particle_argon" "SD=s140"
