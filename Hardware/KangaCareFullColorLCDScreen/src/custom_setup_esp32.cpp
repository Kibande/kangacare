// /**************************************************************************
//   This is a library for several Adafruit displays based on ST77* drivers.

//   This example works with the 1.14" TFT breakout
//     ----> https://www.adafruit.com/product/4383
//   The 1.3" TFT breakout
//     ----> https://www.adafruit.com/product/4313
//   The 1.47" TFT breakout
//     ----> https://www.adafruit.com/product/5393
//   The 1.54" TFT breakout
//     ----> https://www.adafruit.com/product/3787
//   The 1.69" TFT breakout
//     ----> https://www.adafruit.com/product/5206
//   The 1.9" TFT breakout
//     ----> https://www.adafruit.com/product/5394
//   The 2.0" TFT breakout
//     ----> https://www.adafruit.com/product/4311


//   Check out the links above for our tutorials and wiring diagrams.
//   These displays use SPI to communicate, 4 or 5 pins are required to
//   interface (RST is optional).

//   Adafruit invests time and resources providing this open source code,
//   please support Adafruit and open-source hardware by purchasing
//   products from Adafruit!

//   Written by Limor Fried/Ladyada for Adafruit Industries.
//   MIT license, all text above must be included in any redistribution
//  **************************************************************************/

// #include <Adafruit_GFX.h>    // Core graphics library
// #include <Adafruit_ST7789.h> // Hardware-specific library for ST7789
// #include <SPI.h>
// #include <Fonts/FreeSans9pt7b.h>

//   #define TFT_CS        10
//   #define TFT_RST        9 // Or set to -1 and connect to Arduino RESET pin
//   #define TFT_DC         14



// Adafruit_ST7789 tft = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);

// float p = 3.1415926;

// int count = 0;

// void setup(void) {
//   Serial.begin(115200);
//   Serial.print(F("Hello! Feather TFT Test"));

//   // initialize TFT
//   tft.init(240, 280); // Init ST7789 240x135
//   tft.setRotation(3);
//   tft.fillScreen(ST77XX_BLACK);
//   tft.setFont(&FreeSans9pt7b);

//   Serial.println(F("Initialized"));
//   uint16_t time = millis();
//   tft.fillScreen(ST77XX_BLACK);
//   time = millis() - time;

//   Serial.println(time, DEC);
//   delay(500);

//   // large block of text
//   tft.setCursor(tft.width() *0.5f, tft.height() * 0.5f);
//   tft.fillScreen(ST77XX_BLACK);
//   tft.setTextColor(ST77XX_WHITE);
//   tft.print("Kibande Steven");
//   delay(4000);

//   // a single pixel
//   tft.drawPixel(tft.width() *0.5f, tft.height() *0.2f, ST77XX_GREEN);
//   delay(500);
  

//   tft.fillRect(tft.width() *0.5f, tft.height() * 0.7f,tft.width() *0.4f, tft.height() * 0.2f,ST77XX_GREEN);
  
//   Serial.println("done");
//   delay(1000);
// }

// void loop() {
// //   tft.invertDisplay(true);
// //   delay(500);
// //   tft.invertDisplay(false);
// //   delay(500);

//  tft.fillScreen(ST77XX_BLACK);
//  tft.setCursor(tft.width() *0.1f, tft.height() * 0.1f);
//  tft.print(count);
//  delay(500);
//  count++;
// }


// // #include <Adafruit_GFX.h>    // Core graphics library
// // #include <Adafruit_ST7789.h> // Hardware-specific library for ST7789
// // #include <SPI.h>

// // // TFT display pin definitions
// // #define TFT_CS        10
// // #define TFT_RST       9  // Or set to -1 and connect to Arduino RESET pin
// // #define TFT_DC        14

// // // Initialize the Adafruit ST7789 TFT display
// // Adafruit_ST7789 tft = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);

// // // Example 16x16 pixel image in 16-bit RGB565 format
// // const uint16_t testBitmap[16][16] PROGMEM = {
// //   {0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800},
// //   {0xF800, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xF800, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0xF800, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xF800, 0x07E0, 0x001F, 0x001F, 0x07E0, 0xF800, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xF800, 0x07E0, 0x001F, 0x001F, 0x07E0, 0xF800, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xF800, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0xF800, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x001F, 0x07E0, 0xF800},
// //   {0xF800, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0x07E0, 0xF800},
// //   {0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800, 0xF800}
// // };


// // // Function to display a bitmap on the screen
// // void displayBitmap(int16_t x, int16_t y, const uint16_t bitmap[][16], int16_t w, int16_t h) {
// //   for (int16_t j = 0; j < h; j++) {
// //     for (int16_t i = 0; i < w; i++) {
// //       tft.drawPixel(x + i, y + j, pgm_read_word(&(bitmap[j][i])));
// //     }
// //   }
// // }


// // void setup(void) {
// //   Serial.begin(115200);
// //   Serial.print(F("Hello! Feather TFT Test"));

// //   // Initialize TFT
// //   tft.init(240, 280); // Init ST7789 240x135
// //   tft.setRotation(3);
// //   tft.fillScreen(ST77XX_BLACK);
// //   Serial.println(F("Initialized"));
// //   delay(500);

// //   // Display the test bitmap
// //   tft.fillScreen(ST77XX_BLACK);
// //   Serial.println("done");
// //   delay(1000);
// // }

// // void loop() {
// //   tft.invertDisplay(true);
// //   delay(500);
// //   tft.invertDisplay(false);
// //   delay(500);
// // }
