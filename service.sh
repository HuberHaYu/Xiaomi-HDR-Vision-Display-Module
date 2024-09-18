#!/system/bin/sh
alias audio_chip_set='tinymix'
v=91
vh=19
MODDIR=${0%/*}
wait_until_login() {
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done
    while [ ! -d "/sdcard/Android" ]; do
        sleep 1
    done
    sleep 0.5s
    
    #monitor
    while true; do
        _path="/sys/class/backlight/panel0-backlight/brightness"
        _path_max="/sys/class/backlight/panel0-backlight/max_brightness"
        cur_brightness=$(cat "$_path")
        if [ "$cur_brightness" -gt 1500 ]; then
            settings put system screen_brightness_mode 0
            echo 4000 > "$_path"
        else
            settings put system screen_brightness_mode 1
        fi
        sleep 2
    done
}
wait_until_login
