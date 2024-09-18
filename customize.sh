SKIPUNZIP=0
MODDIR=${0%/*}
alias sh='/system/bin/sh'
a=$(getprop ro.system.build.version.release)
DEVICE=$(getprop ro.product.name)
C=$(getprop ro.product.system.manufacturer)
C_=$(getprop ro.product.system.brand)

: <<'HUBER'
BiliBili - @Huber_HaYu
GitHub - Huber_HaYu
HUBER

print_modname() {
  ui_print "***********************"
  echo -e "Crack Brightness"
  ui_print "***********************"
  ui_print "破解最高亮度（自动计算最佳亮度）"
}

set_permissions() {
    set_perm_recursive $MODPATH 0 0 0755 0644
    #set_perm_recursive  $MODPATH/system/vendor/etc/dolby  0  0  0755  0644 u:object_r:vendor_configs_file:s0
    #set_perm_recursive  $MODPATH/system/vendor/etc/audio  0  0  0755  0644 u:object_r:vendor_configs_file:s0
}

fade() {
    echo "计算中..(Waitting..)"
    _path="/sys/class/backlight/panel0-backlight/brightness"
    _path_max="/sys/class/backlight/panel0-backlight/max_brightness"
    
    cur_brightness=$(cat "$_path")
    max=$(cat "$_path_max")
    target_=max-750
    time=3
    
    steps=40
    delay=$(echo "$time / $steps" | bc -l)
    diff=$((target_ - cur_brightness))
    step_size=$(echo "$diff / $steps" | bc)
    
    for i in $(seq 1 $steps); do
        new=$((cur_brightness + i * step_size))
        echo $new > "$_path"
        sleep "$delay"
    done
    echo $target_ > "$_path"
    fade_out
}
fade_out() {
    _path="/sys/class/backlight/panel0-backlight/brightness"
    _path_max="/sys/class/backlight/panel0-backlight/max_brightness"
    
    cur_brightness=$(cat "$_path")
    max=$(cat "$_path_max")
    target_=1600
    time=3
    
    steps=40
    delay=$(echo "$time / $steps" | bc -l)
    diff=$((target_ - cur_brightness))
    step_size=$(echo "$diff / $steps" | bc)
    
    for i in $(seq 1 $steps); do
        new=$((cur_brightness + i * step_size))
        echo $new > "$_path"
        sleep "$delay"
    done
    echo $target_ > "$_path"
}

main() {
    fade
}

if [ "$C" = "Xiaomi" ] || [ "$C_" = "Xiaomi" ] || [ "$C" = "xiaomi" ] || [ "$C_" = "xiaomi" ]; then
    print_modname
    echo "闪屏为正常现象，5秒后准备计算"
    echo "Ready to calculate in 5 seconds"
    sleep 5
    main
    set_permissions
else
    echo "Not Support Device.不支持的设备"
    exit 1
fi