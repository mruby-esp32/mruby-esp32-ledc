mruby-esp32-ledc
============

LEDC (PWM) library for [mruby-esp32](https://github.com/mruby-esp32).

## Installation
In `esp32_build_config.rb`, at the end of the `MRuby::CrossBuild` block, add the following:

```ruby
  conf.gem :github => 'dino-rb/mruby-esp32-ledc'
```

In `CMakeLists.txt`, make sure the line `PRIV_REQUIRES` includes the `driver` component. Add it if needed:

```
  add_prebuilt_library(
    libmruby ${LIBMRUBY_FILE}
    PRIV_REQUIRES esp_wifi esp_hw_support esp_rom mqtt driver 
  )
````

## Example
```ruby
group = ESP32::LEDC_LOW_SPEED_MODE
channel = ESP32::LEDC_CHANNEL_0
timer = ESP32::LEDC_TIMER_0
resolution = ESP32::LEDC_TIMER_10_BIT
frequency = 1000
pin = ESP32::GPIO_NUM_2

ESP32::LEDC.timer_config(group, timer, resolution, frequency)
ESP32::LEDC.channel_config(pin, group, timer, channel)

# Set the built-in LED to 1/8 brightness.
ESP32::LEDC.write(group, channel, 128)
```
