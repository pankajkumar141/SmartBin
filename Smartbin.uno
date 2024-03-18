#define BLYNK_TEMPLATE_ID “TMPL3j02LCgaw” 
#define BLYNK_TEMPLATE_NAME “Smart”
#define BLYNK_AUTH_TOKEN “nLlqFGkHvuRRSf8AlOS2g372DzLABNKX” 
#define BLYNK_PRINT Serial
#include <WiFi.h> 
#include <WiFiClient.h>
#include <BlynkSimpleEsp32.h>
Char auth[] = BLYNK_AUTH_TOKEN; 
Char ssid[] = “Home_2G”;
Char pass[] = “iem@aiml”; 
BlynkTimer timer;
#define echoPin 32
#define trigPin 33 
#include<ESP32Servo.h> 
Servo servo;
Long duration; 
Int distance; 
Int binLevel=0;
Void SMESensor()
{
Int ir=digitalRead(34); 
If(ir==HIGH)
{
Servo.write(180);
For(int i=0; i<50; i++)
{
Blynk.virtualWrite(V2, 90); 
Ultrasonic();
Delay(25);
}
Servo.write(0); 
Blynk.virtualWrite(V2, 0);
}
If(ir==LOW)
{
Ultrasonic(); 
Delay(20);
}
}
Void ultrasonic()
{
digitalWrite(trigPin, LOW); 
delayMicroseconds(2); 
digitalWrite(trigPin, HIGH); 
delayMicroseconds(10); 
digitalWrite(trigPin, LOW);
duration = pulseIn(echoPin, HIGH);
distance = duration * 0.034 / 2; //formula to calculate the distance for ultrasonic sensor 
binLevel=map(distance, 21, 0, 0,100); // ADJUST BIN HEIGHT HERE 
Blynk.virtualWrite(V0, distance);
Blynk.virtualWrite(V1, binLevel);
}
Void setup()
{
Serial.begin(9600); 
Servo.attach(13); 
pinMode(34, INPUT); 
pinMode(trigPin, OUTPUT); 
pinMode(echoPin, INPUT);
Blynk.begin(auth, ssid, pass, “blynk.cloud”, 80); 
Delay(200);
Timer.setInterval(1000L, SMESensor);
}
Void loop()
{
Blynk.run();
Timer.run();
}