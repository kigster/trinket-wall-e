#!/usr/bin/env bash
source ~/.bash_colors
set -e

arduino_home="/Applications/Arduino.app"
tmp=/tmp/230492034928
rm -rf $tmp
mkdir -p $tmp

build_flags=" -c -g -Os -w -std=gnu++11 -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics  -w -x c++ -E -CC -mmcu=attiny85 -DF_CPU=8000000L -DARDUINO=10608 -DARDUINO_AVR_TRINKET3 -DARDUINO_ARCH_AVR"
compile_flags_1=" -c -g -Os -w -std=gnu11 -ffunction-sections -fdata-sections -MMD -mmcu=attiny85 -DF_CPU=8000000L -DARDUINO=10608 -DARDUINO_AVR_TRINKET3 -DARDUINO_ARCH_AVR"
compile_flags_2=" -c -g -Os -w -std=gnu++11 -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -MMD -mmcu=attiny85 -DF_CPU=8000000L -DARDUINO=10608 -DARDUINO_AVR_TRINKET3 -DARDUINO_ARCH_AVR"

builder="${arduino_home}/Contents/Java/arduino-builder"
adafruit_tiny="/Users/kig/Library/Arduino15/packages/adafruit/hardware/avr/1.4.3/variants/tiny8"
gpp="${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-g++"
ar="${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-ar"
includes="-I/Users/kig/arduino/sketches/libraries/Adafruit_NeoPixel -I/Users/kig/arduino/sketches/libraries/NewPing -I${tmp}"
arduino_home_avr=${arduino_home}/Contents/Java/hardware/arduino/avr/cores/arduino
function run {
  printf "${bldgrn} running command: ${txtblu}${*}${txtred}\n"
  eval "$*"
}

function compile {
  run "${builder}" -dump-prefs -logger=machine -hardware "${arduino_home}/Contents/Java/hardware" -hardware "/Users/kig/Library/Arduino15/packages" -hardware "/Users/kig/arduino/sketches/hardware" -tools "${arduino_home}/Contents/Java/tools-builder" -tools "${arduino_home}/Contents/Java/hardware/tools/avr" -tools "/Users/kig/Library/Arduino15/packages" -built-in-libraries "${arduino_home}/Contents/Java/libraries" -libraries "/Users/kig/arduino/sketches/libraries" -fqbn=adafruit:avr:trinket3 -ide-version=10608 -build-path "${tmp}" -warnings=none -prefs=build.warn_data_percentage=75 "/Users/kig/projects/trinket-wall-e/trinket-wall-e.ino"

  run "${builder}" -compile -logger=machine -hardware "${arduino_home}/Contents/Java/hardware" -hardware "/Users/kig/Library/Arduino15/packages" -hardware "/Users/kig/arduino/sketches/hardware" -tools "${arduino_home}/Contents/Java/tools-builder" -tools "${arduino_home}/Contents/Java/hardware/tools/avr" -tools "/Users/kig/Library/Arduino15/packages" -built-in-libraries "${arduino_home}/Contents/Java/libraries" -libraries "/Users/kig/arduino/sketches/libraries" -fqbn=adafruit:avr:trinket3 -ide-version=10608 -build-path "${tmp}" -warnings=none -prefs=build.warn_data_percentage=75 "/Users/kig/projects/trinket-wall-e/trinket-wall-e.ino"

  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "${tmp}/sketch/trinket-wall-e.ino.cpp" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "${tmp}/sketch/trinket-wall-e.ino.cpp" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "${tmp}/sketch/trinket-wall-e.ino.cpp" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "/Users/kig/arduino/sketches/libraries/Adafruit_NeoPixel/Adafruit_NeoPixel.cpp" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "/Users/kig/arduino/sketches/libraries/Adafruit_NeoPixel/esp8266.c" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "/Users/kig/arduino/sketches/libraries/NewPing/NewPing.cpp" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "${tmp}/sketch/trinket-wall-e.ino.cpp" -o "/dev/null"
  run "${gpp}" ${build_flags}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "${tmp}/sketch/trinket-wall-e.ino.cpp" -o "${tmp}/preproc/ctags_target_for_gcc_minus_e.cpp"
  run "${arduino_home}/Contents/Java/tools-builder/ctags/5.8-arduino5/ctags" -u --language-force=c++ -f - --c++-kinds=svpf --fields=KSTtzns --line-directives "${tmp}/preproc/ctags_target_for_gcc_minus_e.cpp"
  run "${gpp}" ${compile_flags_2}   -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "${tmp}/sketch/trinket-wall-e.ino.cpp" -o "${tmp}/sketch/trinket-wall-e.ino.cpp.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "/Users/kig/arduino/sketches/libraries/Adafruit_NeoPixel/esp8266.c" -o "${tmp}/libraries/Adafruit_NeoPixel/esp8266.c.o"
  run "${gpp}" ${compile_flags_2}   -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "/Users/kig/arduino/sketches/libraries/Adafruit_NeoPixel/Adafruit_NeoPixel.cpp" -o "${tmp}/libraries/Adafruit_NeoPixel/Adafruit_NeoPixel.cpp.o"
  run "${gpp}" ${compile_flags_2}   -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" ${includes} "/Users/kig/arduino/sketches/libraries/NewPing/NewPing.cpp" -o "${tmp}/libraries/NewPing/NewPing.cpp.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" -c -g -x assembler-with-cpp -mmcu=attiny85 -DF_CPU=8000000L -DARDUINO=10608 -DARDUINO_AVR_TRINKET3 -DARDUINO_ARCH_AVR  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/wiring_pulse.S" -o "${tmp}/core/wiring_pulse.S.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/WInterrupts.c" -o "${tmp}/core/WInterrupts.c.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/hooks.c" -o "${tmp}/core/hooks.c.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/wiring.c" -o "${tmp}/core/wiring.c.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/wiring_analog.c" -o "${tmp}/core/wiring_analog.c.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/wiring_digital.c" -o "${tmp}/core/wiring_digital.c.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/wiring_pulse.c" -o "${tmp}/core/wiring_pulse.c.o"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" ${compile_flags_1}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/wiring_shift.c" -o "${tmp}/core/wiring_shift.c.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/CDC.cpp" -o "${tmp}/core/CDC.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/HardwareSerial.cpp" -o "${tmp}/core/HardwareSerial.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/HardwareSerial0.cpp" -o "${tmp}/core/HardwareSerial0.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/HardwareSerial1.cpp" -o "${tmp}/core/HardwareSerial1.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/HardwareSerial2.cpp" -o "${tmp}/core/HardwareSerial2.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/HardwareSerial3.cpp" -o "${tmp}/core/HardwareSerial3.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/IPAddress.cpp" -o "${tmp}/core/IPAddress.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/PluggableUSB.cpp" -o "${tmp}/core/PluggableUSB.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/Print.cpp" -o "${tmp}/core/Print.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/Stream.cpp" -o "${tmp}/core/Stream.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/Tone.cpp" -o "${tmp}/core/Tone.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/USBCore.cpp" -o "${tmp}/core/USBCore.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/WMath.cpp" -o "${tmp}/core/WMath.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/WString.cpp" -o "${tmp}/core/WString.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/abi.cpp" -o "${tmp}/core/abi.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/main.cpp" -o "${tmp}/core/main.cpp.o"
  run "${gpp}" ${compile_flags_2}  -I${tmp}/sketch -I"${arduino_home_avr}" "-I${adafruit_tiny}" "${arduino_home_avr}/new.cpp" -o "${tmp}/core/new.cpp.o"

  for source in wiring_pulse.S WInterrupts.c hooks.c wiring.c wiring_analog.c wiring_digital.c wiring_pulse.c wiring_shift.c \
                CDC.cpp HardwareSerial.cpp HardwareSerial0.cpp HardwareSerial1.cpp HardwareSerial2.cpp HardwareSerial3.cpp \
                IPAddress.cpp PluggableUSB.cpp Print.cpp Stream.cpp Tone.cpp USBCore.cpp WMath.cpp WString.cpp abi.cpp main.cpp new.cpp; do
    run "${ar}" rcs  "${tmp}/core/core.a" "${tmp}/core/${source}.o"
  done
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-gcc" -w -Os -Wl,--gc-sections -mmcu=attiny85  -o "${tmp}/trinket-wall-e.ino.elf" "${tmp}/sketch/trinket-wall-e.ino.cpp.o" "${tmp}/libraries/Adafruit_NeoPixel/esp8266.c.o" "${tmp}/libraries/Adafruit_NeoPixel/Adafruit_NeoPixel.cpp.o" "${tmp}/libraries/NewPing/NewPing.cpp.o" "${tmp}/core/core.a" "-L${tmp}" -lm
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-objcopy" -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0  "${tmp}/trinket-wall-e.ino.elf" "${tmp}/trinket-wall-e.ino.eep"
  run "${arduino_home}/Contents/Java/hardware/tools/avr/bin/avr-objcopy" -O ihex -R .eeprom  "${tmp}/trinket-wall-e.ino.elf" "${tmp}/trinket-wall-e.ino.hex"
}

function upload {
  run ${arduino_home}/Contents/Java/hardware/tools/avr/bin/avrdude -C${arduino_home}/Contents/Java/hardware/tools/avr/etc/avrdude.conf -v -pattiny85 -cusbtiny -Uflash:w:trinket-wall-e.ino.hex:i
}

if [ -z "$1" ]; then
  compile
  upload
else
  $1
fi
