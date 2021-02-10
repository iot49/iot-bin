# /bin/zsh

DATE=$(date +'20%y-%m-%d')

cd $IOT/iotpython
git checkout iot

function make_board () {
    echo ports/${1:?Port folder is required}: make BOARD=${2:?Board name is required}
    cd $IOT/iotpython/ports/$1
    make BOARD=$2 clean
    make BOARD=$2
    cp build-$2/firmware.uf2 $IOT/iot-bin/iotpython/$2.uf2
}

make_board "atmel-samd"  "feather_m4_express"
# make_board "nrf"         "particle_argon"
# make_board "nrf"         "feather_nrf52840_express"
# make_board "stm"         "feather_stm32f405_express"
