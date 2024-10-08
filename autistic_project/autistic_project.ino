#include <MFRC522.h>
#include <SPI.h>
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>

// Define pins for RFID readers
#define SS_PIN1 15
#define RST_PIN1 5
#define SS_PIN2 4
#define RST_PIN2 2
#define SS_PIN3 22
#define RST_PIN3 21

// Initialize RFID readers
MFRC522 mfrc522_1(SS_PIN1, RST_PIN1);
MFRC522 mfrc522_2(SS_PIN2, RST_PIN2);
MFRC522 mfrc522_3(SS_PIN3, RST_PIN3);

// BLE Server and Characteristic
BLEServer* pServer = nullptr;
BLECharacteristic* pCharacteristic = nullptr;
bool deviceConnected = false;

// BLE UUIDs
const char* SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const char* CHARACTERISTIC_UUID_RX = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

// RFID tag data for each waste category
byte foodTags[][4] = {{0xC3, 0x48, 0xEB, 0x24}, {0x73, 0xA3, 0x50, 0x25}};
byte paperTags[][4] = {{0xD3, 0x50, 0xDF, 0xF4}, {0x93, 0x56, 0xDB, 0xF7}};
byte plasticTags[][4] = {{0x83, 0x30, 0xD7, 0x24}, {0x43, 0xE6, 0x35, 0x25}};

// Callback class for BLE connections
class MyServerCallbacks : public BLEServerCallbacks {
public:
    void onConnect(BLEServer* pServer) {
        deviceConnected = true;
        Serial.println("Device connected");
    }

    void onDisconnect(BLEServer* pServer) {
        deviceConnected = false;
        Serial.println("Device disconnected");
    }
};

void setup() {
    Serial.begin(9600); // Initialize serial communication
    SPI.begin(); // Initialize SPI bus

    // Initialize RFID readers
    mfrc522_1.PCD_Init();
    mfrc522_2.PCD_Init();
    mfrc522_3.PCD_Init();

    // Create BLE Device and Server
    BLEDevice::init("BinBuddy");
    pServer = BLEDevice::createServer();
    pServer->setCallbacks(new MyServerCallbacks());

    // Create BLE Service and Characteristic
    BLEService* pService = pServer->createService(SERVICE_UUID);
    pCharacteristic = pService->createCharacteristic(
        CHARACTERISTIC_UUID_RX,
        BLECharacteristic::PROPERTY_READ |
        BLECharacteristic::PROPERTY_WRITE |
        BLECharacteristic::PROPERTY_NOTIFY |
        BLECharacteristic::PROPERTY_INDICATE
    );

    // Start BLE service and advertising
    pService->start();
    pServer->getAdvertising()->start();

    Serial.println("BLE Device is ready to connect.");
}

void loop() {
    checkRFIDTag(mfrc522_1, "Food Waste", foodTags, 2);
    checkRFIDTag(mfrc522_2, "Paper Waste", paperTags, 2);
    checkRFIDTag(mfrc522_3, "Plastic Waste", plasticTags, 2);
}

void checkRFIDTag(MFRC522& mfrc522, const char* wasteType, byte tags[][4], int tagCount) {
    if (mfrc522.PICC_IsNewCardPresent() && mfrc522.PICC_ReadCardSerial()) {
        byte* uid = mfrc522.uid.uidByte;

        bool correctCategory = false;
        for (int i = 0; i < tagCount; i++) {
            if (compareTag(uid, tags[i])) {
                correctCategory = true;
                break;
            }
        }

        String uidStr = getTagIDString(uid);
        // String message = "RFID Reader: " + String(wasteType) + " - Tag ID: " + uidStr + " - ";
        String message = uidStr;
        if (correctCategory) {
            message += ",Correctly sorted";
        } else {
            message += ",Incorrectly sorted";
        }

        Serial.println(message);

        if (deviceConnected) {
            pCharacteristic->setValue(message.c_str());
            pCharacteristic->notify(); // Notify Flutter app
            delay(500);
            pCharacteristic->setValue("");
            pCharacteristic->notify(); // Notify Flutter app

        }

        delay(1000); // Prevent multiple readings
    }
}

bool compareTag(byte* tag1, byte* tag2) {
    for (int i = 0; i < 4; i++) {
        if (tag1[i] != tag2[i]) {
            return false;
        }
    }
    return true;
}

String getTagIDString(byte* uid) {
    String uidStr = "";
    for (int i = 0; i < 4; i++) {
        if (uid[i] < 0x10) {
            uidStr += "0";
        }
        uidStr += String(uid[i], HEX);
    }
    return uidStr;
}
