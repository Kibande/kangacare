#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ArduinoJson.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
#define OLED_RESET -1 // Reset pin # (or -1 if sharing Arduino reset pin)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
// Data wire is plugged into port 2 on the Arduino
#define ONE_WIRE_BUS 14
// Setup a oneWire instance to communicate with any OneWire devices (not just 
Maxim/Dallas temperature ICs)
OneWire oneWire(ONE_WIRE_BUS);
// Pass our oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);
// ESP hotspot network details
const char *ssid = "ILEMUT";
const char *password = "12345678";
WiFiServer server(80);
DynamicJsonDocument deviceInfo(1024);
DynamicJsonDocument deviceReadings(1024);
bool sendDeviceInfo = false;
bool sendDeviceReadings = false;
float tempC =0;
int led1=0, led2=2, buzzer=14;
void setup() {
// put your setup code here, to run once:
Serial.begin(115200);
// SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
Serial.println(F("SSD1306 allocation failed"));
for(;;); // Don't proceed, loop forever
}
display.display();
delay(2000); // Pause for 2 seconds
display.clearDisplay();
display.setTextSize(2);
display.setTextColor(WHITE);
display.setCursor(0, 10);
// Display static text
display.println("KangaCare");
display.setCursor(0, 30);
display.println("Baby-Temp");
display.setCursor(0, 50);
display.println("Monitor");
display.display();
delay(3000);
pinMode(led1,OUTPUT);
pinMode(led2,OUTPUT);
pinMode(buzzer,OUTPUT);
digitalWrite(led1, LOW);
digitalWrite(buzzer, LOW);
digitalWrite(led2, LOW);
Serial.println("Configuring access point...");
WiFi.softAP("Ivan", "12345678");
WiFi.softAP(ssid, password);
IPAddress myIP = WiFi.softAPIP();
Serial.print("AP IP address: ");
Serial.println(myIP);
server.begin();
Serial.println("Server started");
deviceInfo["id"] = "WH56UW";
deviceInfo["hospital"] = "Mbarara Regional Referal";
deviceInfo["username"] = "Magambo Family";
deviceInfo["reference"] = "PCIDSS";
deviceInfo["reference"] = 89;
deviceInfo["charging"] = false;
// Show initial display buffer contents on the screen --
// the library initializes this with an Adafruit splash screen.
}
void loop() {
// put your main code here, to run repeatedly:
/*Serial.println("Number of connections");
Serial.println(WiFi.softAPgetStationNum());*/
display.clearDisplay();
//deviceReadings["temperature"] = Tc;
Serial.print("Requesting temperatures...");
sensors.requestTemperatures(); // Send the command to get temperatures
Serial.println("DONE");
// After we got the temperatures, we can print them here.
// We use the function ByIndex, and as an example get the temperature from the 
first sensor only.
tempC=sensors.getTempCByIndex(0);
// Check if reading was successful
if(tempC != DEVICE_DISCONNECTED_C)
{
Serial.print("Temperature for the device 1 (index 0) is: ");
Serial.println(tempC);
deviceReadings["temperature"] = tempC;
display.setCursor(0, 10);
display.println("Baby-Temp");
display.setCursor(10, 32);
display.print(tempC);
display.setCursor(80,32);
display.print("*C");
display.display();
delay(3000);
display.clearDisplay();
if(tempC>36){
digitalWrite(led1, HIGH);
digitalWrite(buzzer, LOW);
digitalWrite(led2, LOW);
}
else if(tempC<=33){
digitalWrite(led1,LOW);
digitalWrite(buzzer, HIGH);
digitalWrite(led2, LOW);
}
else{
digitalWrite(led1, LOW);
digitalWrite(buzzer, LOW);
digitalWrite(led2 , HIGH);
}
}
else
{
Serial.println("Error: Could not read temperature data");
}
WiFiClient client = server.available(); // listen for incoming clients
if (client)
{ // if you get a client,
Serial.println("New Client Request."); // print a message out the serial port
String currentLine = ""; // make a String to hold incoming data 
from the client
while (client.connected())
{ // loop while the client's connected
if (client.available())
{ // if there's bytes to read from the client,
char c = client.read(); // read a byte, then
Serial.write(c); // print it out the serial monitor
if (c == '\n')
{ // if the byte is a newline character
// if the current line is blank, you got two newline characters in a 
row.
// that's the end of the client HTTP request, so send a response:
if (currentLine.length() == 0)
{
// HTTP headers always start with a response code (e.g. HTTP/1.1 200 
OK)
// and a content-type so the client knows what's coming, then a blank 
line:
client.println("HTTP/1.1 200 OK");
client.println("Content-type: application/json");
client.println();
if (sendDeviceInfo)
{
serializeJsonPretty(deviceInfo, client); // device readings
sendDeviceInfo = false;
}
if (sendDeviceReadings)
{
serializeJsonPretty(deviceReadings, client); // device readings
sendDeviceReadings = false;
}
// The HTTP response ends with another blank line:
client.println();
// break out of the while loop:
break;
}
else
{ // if you got a newline, then clear currentLine:
currentLine = "";
}
}
else if (c != '\r')
{ // if you got anything else but a carriage return 
character,
currentLine += c; // add it to the end of the currentLine
}
// Check to see if the client request was "GET /DIF" or "GET /DR":
if (currentLine.endsWith("GET /DIF"))
{
sendDeviceInfo = true;
}
if (currentLine.endsWith("GET /DR"))
{
sendDeviceReadings = true;
}
}
}
// close the connection:
client.stop();
Serial.println("Client Request done.");
}
}