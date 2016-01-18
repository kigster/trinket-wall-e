
#include <avr/pgmspace.h>
#include "RGBColor.h"
#include "Arduino.h"

typedef enum RGBOverTimeMode_e {
  Normal    = (1 << 0),
  Blinking  = (1 << 1),
  Fading    = (1 << 2),
} RGBOverTimeMode;

/**
* Class that wraps three separate LEDs and treats them as a single LED.
*/

class RGBPixelEffect {

private:
  RGBColor _color;
  RGBColor _fadeFrom = 0, _fadeTo = 0;
  uint32_t _lastUpdateAt = 0, _fadeStartedAt = 0;
  uint32_t _periodMs = 0;
  RGBOverTimeMode _mode = Normal;
  bool _enabled = true;
  long _blinkCount = 0, _blinkForCount = 0;
  bool _lastBlinkStateOn = false;

public:
  RGBPixelEffect() : _color(0,0,0) {
  };

  void tick() {
    _checkTiming();
  }

  void fade(rgb_color_t from, rgb_color_t to, long periodMs) {
    _reset();
    _mode = Fading;
    _fadeFrom = RGBColor(from);
    _fadeTo = RGBColor(to);
    _fadeStartedAt = millis();
    _periodMs = periodMs;
    _setColor(_fadeFrom);
  }

  void blink(rgb_color_t color, long periodMs) {
    blink(color, periodMs, 0);
  }

  // times = 0 for unlimited
  void blink(rgb_color_t color, long periodMs, long times) {
    _reset();
    _blinkForCount = times;
    _mode = Blinking;
    _blinkCount = 0;
    _periodMs = periodMs;
    _lastUpdateAt = millis();
    _lastBlinkStateOn = true;
    _setColor(color);
  }

  // show color for a period, then turn off
  void showFor(rgb_color_t color, long periodMs) {
    blink(color, periodMs, 1);
  }

  void setColor(RGBColor color) {
    _reset();
    _setColor(color);
  }
  void setColor(rgb_color_t color) {
    _reset();
    _setColor(color);
  }

  void off() {
    _reset();
    _off();
  }

  bool isEnabled() {
    return _enabled;
  }

  void toggleEnabled() {
    _enabled = ! _enabled;
  }

  void enabled(bool enable) {
    _enabled = enable;
  }

  void enable() {
    _enabled = true;
  }

  void disable() {
    _enabled = false;
  }

private:
  void _reset() {
    _mode = Normal;
    _fadeFrom = _fadeTo = 0;
    _blinkForCount = 0 ;
    _blinkCount = 0;
    _periodMs = 0;
    _lastUpdateAt = 0;
    _lastBlinkStateOn = false;
  }

  void _setColor(RGBColor color) {
    _color = color;
    _write();
  }

  void _setColor(rgb_color_t color) {
    _color = RGBColor(color);
    _write();
  }

  void _off() {
    _color.r = 0;
    _color.g = 0;
    _color.b = 0;
  }

  void _checkTiming() {
    long _now = millis();
    switch (_mode) {
      case Blinking:
      if (_now >= _lastUpdateAt + _periodMs) {
        if (_blinkForCount > 0 && _blinkCount >= _blinkForCount * 2) {
          _reset();
          off();
        } else {
          _blinkCount++;
          _lastBlinkStateOn = !_lastBlinkStateOn;
          _lastBlinkStateOn ? _write() : _off();
          _lastUpdateAt = _now;
        }
      }
      break;
      case Fading:
      if (_now - _fadeStartedAt > _periodMs) {
        _mode = Normal;
        _setColor(_fadeTo);
      } else {
        /* should be between 0 and 1 now */
        float _ratio = 1.0 * (_now - _fadeStartedAt) / _periodMs;
        RGBColor _intermediate = _fadeFrom.scaleTo(_fadeTo, _ratio);
        if (_now - _lastUpdateAt > 100) {
          _lastUpdateAt = _now;
        }
        _setColor(_intermediate);
      }
      break;
    }
  }

  void _write() {
    if (isEnabled()) {
      // todo
    } else {
      _off();
    }
  }
};
