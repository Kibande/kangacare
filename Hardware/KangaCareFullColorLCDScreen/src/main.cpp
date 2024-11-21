// BLE
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include<string.h>
BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;



#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
      BLEDevice::startAdvertising();
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};



#include <Adafruit_GFX.h>    // Core graphics library
#include <Adafruit_ST7789.h> // Hardware-specific library for ST7789
#include <SPI.h>
#include "image.h"  // image files
#include <Fonts/FreeSans12pt7b.h>
#include <Fonts/FreeSansBold18pt7b.h>
#include <OneWire.h>
#include <DallasTemperature.h>

// GPIO where the DS18B20 is connected to
const int oneWireBus = 4;     

// Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(oneWireBus);

// Pass our oneWire reference to Dallas Temperature sensor 
DallasTemperature sensors(&oneWire);

// Thread  
#include <Thread.h>
#include <ThreadController.h>

float prev_temp =0.0;

float battery_level =0.0;

// ThreadController that will controll all threads
ThreadController controll = ThreadController();

Thread* btThread = new Thread();
Thread* drawingThread = new Thread();


// TFT display pin definitions
#define TFT_CS        10
#define TFT_RST       9  // Or set to -1 and connect to Arduino RESET pin
#define TFT_DC        14

// Initialize the Adafruit ST7789 TFT display
Adafruit_ST7789 tft = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);



// Function to display a bitmap on the screen
void displayBitmap(int16_t x, int16_t y, const uint16_t bitmap[], int16_t w, int16_t h) {
  for (int16_t j = 0; j < h; j++) {
    for (int16_t i = 0; i < w; i++) {
      uint16_t color = pgm_read_word(&bitmap[j * w + i]);
      tft.drawPixel(x + i, y + j, color);
    }
  }
}

void displayLogo(){
    displayBitmap(0, 0, logo, 280, 240); // Draw the image
}

void displayHappyBabyBG(){
    displayBitmap(0, 0, happy_baby, 280, 240); // Draw the image
    displayBitmap(40, 10, bluetooth_icon, 15, 15); // Draw the image
    displayBitmap(240, 10, battery_icon, 25, 13); // Draw the image
}


void updateMessage(float temp){
  if(temp){

tft.fillRect(78,180,180,50,ST77XX_WHITE);

    tft.setCursor(80, 210);
    tft.setFont(&FreeSans12pt7b);
    tft.setTextColor(ST77XX_BLACK);
    tft.print("Status: ");
    tft.setTextColor(ST77XX_GREEN);
    tft.print("Normal");
  }
}


void updateTemp(float tempC,float tempF){
  if(prev_temp != tempC){
    
    tft.fillRect(138,40,180,100,ST77XX_WHITE);
    
    tft.setCursor(140, 70);
    tft.setTextColor(ST77XX_GREEN);
    tft.setFont(&FreeSansBold18pt7b);
    String tempString = "";
    tempString += (int)tempC;
    tft.print(tempC);
    tft.print("*");
    tft.print("C");
    tft.setTextColor(ST77XX_BLUE);
     tft.setCursor(140, 130);
    tft.print(tempF);
    tft.print("*");
    tft.println("F");
    prev_temp = tempC;
    updateMessage(tempC);

    
  }

  
}





void drawingCallback(){
   // read temp values and draw to the screen


    sensors.requestTemperatures(); 
    float temperatureC = sensors.getTempCByIndex(0);
    float temperatureF = sensors.getTempFByIndex(0);
    Serial.print(temperatureC);
    Serial.println("ºC");
    Serial.print(temperatureF);
    Serial.println("ºF");

    updateTemp(temperatureC,temperatureF);
}

void btCallback(){
  // notify changed value
    if (deviceConnected) {

      String str = "";
      str += prev_temp;
      str +=";";
      str+=battery_level;
      
      pCharacteristic->setValue((char*)str.c_str());
      pCharacteristic->notify();

    }
    // disconnecting
    if (!deviceConnected && oldDeviceConnected) {
        //delay(500); // give the bluetooth stack the chance to get things ready
        pServer->startAdvertising(); // restart advertising
        Serial.println("start advertising");
        oldDeviceConnected = deviceConnected;
    }
    // connecting
    if (deviceConnected && !oldDeviceConnected) {
        // do stuff here on connecting
        oldDeviceConnected = deviceConnected;
    }
}

void initBT(){
  // Create the BLE Device
  BLEDevice::init("BuriCare Carrier 00001BC");

  // Create the BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Create the BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Create a BLE Characteristic
  pCharacteristic = pService->createCharacteristic(
                      CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ   |
                      BLECharacteristic::PROPERTY_WRITE  |
                      BLECharacteristic::PROPERTY_NOTIFY |
                      BLECharacteristic::PROPERTY_INDICATE
                    );

  // https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.descriptor.gatt.client_characteristic_configuration.xml
  // Create a BLE Descriptor
  pCharacteristic->addDescriptor(new BLE2902());

  // Start the service
  pService->start();

  // Start advertising
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  pAdvertising->setMinPreferred(0x0);  // set value to 0x00 to not advertise this parameter
  BLEDevice::startAdvertising();
  Serial.println("Waiting a client connection to notify...");
  
}

void initDrawing(){
 
  Serial.print(F("Hello! Feather TFT Test"));

  // Initialize TFT
  tft.init(240, 280); // Init ST7789 240x280
  tft.setRotation(3);
   
  Serial.println(F("Initialized"));

  // Display the bitmap
  tft.fillScreen(ST77XX_WHITE);

   displayLogo();
  delay(1500);
      displayHappyBabyBG();
      
    // delay(1000);
  Serial.println("done");

    // Start the DS18B20 sensor
  sensors.begin();
  delay(1000);
}


void setup() {
   Serial.begin(115200);
  initDrawing();
  initBT();
  
  btThread->onRun(btCallback);
  btThread->setInterval(100);

  drawingThread->onRun(drawingCallback);
  drawingThread->setInterval(100);

  controll.add(btThread);
  controll.add(drawingThread);
}

void loop() {
  // put your main code here, to run repeatedly:
  controll.run();
}


