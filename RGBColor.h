
#ifndef _RGB_COLOR_H_
#define _RGB_COLOR_H_

typedef uint8_t color_t;
typedef uint32_t rgb_color_t;

// 0 <= X,Y <= 255
// 0 <=   f <= 1.0
#define converge(X,Y,f) (Y*f + (1 - f)*X)

class RGBColor {
public:

    color_t r;
    color_t g;
    color_t b;

    RGBColor() :
            r(0), g(0), b(0) {
    }
    RGBColor(color_t r, color_t g, color_t b) :
            r(r), g(g), b(b) {
    }
    RGBColor(rgb_color_t p) {
      r = (p >> 16) & 0xff;
      g = (p >> 8) & 0xff;
      b = p & 0xff;
    }

    RGBColor operator-(const RGBColor c) {
      return RGBColor(r - c.r, g - c.g, b - c.b);
    }

    RGBColor operator+(const RGBColor c) {
      return RGBColor(r + c.r, g + c.g, b + c.b);
    }

    RGBColor operator+(const uint32_t c) {
      RGBColor c2 = RGBColor(c);
      return *this + (RGBColor) c2;
    }

    void operator-=(const RGBColor c) {
      r -= c.r;
      g -= c.g;
      b -= c.b;
    }

    void operator+=(const RGBColor c) {
      r += c.r;
      g += c.g;
      b += c.b;
    }

    RGBColor operator*(const float f) {
      color_t tR = r * f;
      color_t tG = g * f;
      color_t tB = b * f;
      if (tR == 0 && r != 0) tR = 1;
      if (tG == 0 && g != 0) tG = 1;
      if (tB == 0 && b != 0) tB = 1;

      return RGBColor(tR, tG, tB);
    }

    /* expecting 0 <= f <= 1 */
    RGBColor scaleTo(const RGBColor other, const float ratio) {
      RGBColor c = RGBColor(
        converge(r, other.r, ratio),
        converge(r, other.g, ratio),
        converge(r, other.b, ratio)
      );
      return c;
    }

    RGBColor operator/(const int f) {
      return RGBColor(r / f, g / f, b / f);
    }
};

#endif
