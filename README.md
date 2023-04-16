# NFCREAD FRAMEWORK SAMPLE PROJECT!
-Please Visit More Details | Github; https://github.com/Sanalogi/NFCREAD-IOS-Framework-Example

NFC Read is a tool designed for reading and verifying the official documents such as identity cards or passports. An example use case can be a police officer performing ID checks on the street, where NFC Read can be used with ease via an Android or an IOS smartphone to scan and verify the presented official document. The application does not require any specialised equipment or additional training.

- There is no additional training required for the personal to detect the fraudulent identity cards.

- It is a mobile solution that does not require any specialised hardware.

- No manual data entries are required: NFC Read automatically creates entries for data without any errors.

- A face match is automatically performed by obtaining the high resolution biometric image stored inside the NFC chip of the identity document

## Installation of the Framework

```
DO NOT FORGET
NFC operation works on devices with iOS13 and higher
Project deployment version must be iOS13 or higher
```


## 1: Simply add the following line to your Podfile:

```ruby
pod 'OpenSSL-Universal'
```

## 2: Add frameworks to your project

```
You can download framework files from: https://login.nfcread.com/files/SanalogiReader-01.zip and 
Extract zips and embed&sign below frameworks

1. SanalogiReader.xcframework 

```
![alt text](https://github.com/abbasamini/Sample-App-For-SDK/blob/main/Image/Screen%20Shot%202023-04-06%20at%201.30.42%20AM.png?raw=true)

```
Go to "General -> Frameworks, Libraries and Embedded Content" and make the added frameworks "Embed & Sign"

Be sure that when adding frameworks: General->Frameworks,Libraries and Embedded content
```


## 3: Permissions

```xml
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
<string>A0000002471001</string>
<string>00000000000000</string>
</array>

<key>NSCameraUsageDescription</key>
<string> We need to access camera.</string>
	
<key>NFCReaderUsageDescription</key>
<string> We need to access NFC for scan passport.</string>
 
```
## 4: You must add the api key to the plist.([How can i get licence key?](https://nfcread.com))

```xml
  <key>SanalogiReaderToken</key>
  <string>LICENCEKEY</string>
```
![alt text](https://github.com/abbasamini/Sample-App-For-SDK/blob/main/Image/Screen%20Shot%202023-04-06%20at%201.30.18%20AM.png?raw=true)
## 5: Include NFC in your project
Select "Signing & Capabilities -> Capability-> Near Field Communication Tag Reading" and then remove the first item from the "entitlements" file created under the project.
![alt text](https://github.com/abbasamini/Sample-App-For-SDK/blob/main/Image/Screen%20Shot%202023-04-06%20at%201.30.28%20AM.png?raw=true)
```
DELETE “Item 0 (Near Field Communication Tag Reading Session Format) - NFC Data Exchange Format “
```
Only the item listed below should remain.
```
Item 1 (Near Field Communication Tag Reading Session Format) - NFC tag-specific data protocol

After doing that open entitlement as source code and add this line <string>NDEF</string> after <string>TAG</string> line.
```

## 6: To read from the camera

```
1. Create a viewcontroller

```
You can review the sample code for the controls.
```swift
import UIKit
import NFCReaderApple

class ViewController: UIViewController,CardAndPassportDetectionViewControllerDelegate {
    func didFail(message: String) {
        
    }
    
    func cardAndPassportDetectionViewController(_ viewController: CardAndPassportDetectionViewController, didDetectCard mrzScanResult: MrzScanResult, withSettings settings: CardAndPassportDetectionSettings) {
 	print(mrzScanResult.givenNames)
        print(mrzScanResult.birthDate)
        print(mrzScanResult.surnames)
        print(mrzScanResult.documentNumber)
        print(mrzScanResult.personalNumber)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }
    @IBAction func scanner(_ sender: Any) {
        let settings = CardAndPassportDetectionSettings()
        settings.passportMode = false
        let controller = CardAndPassportDetectionViewController(settings: settings)
        controller.delegate = self
        self.present(controller, animated: true)
    }
    
     
}

```
## 7: To read from the NFC

You can review the sample code to start reading from NFC.

```swift
import UIKit
#if canImport(CoreNFC)
import NFCReaderApple


@available(iOS 13, *)

class ViewController: UIViewController,NFCReaderDelegate {

     func didSuccess(data: NFCReaderApple.NFCPassportModel) {
       
    }
    
    
    func didFail(message: String) {
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NFCReader.sharedInstance.delegate = self
    }

    @IBAction func scan(_ sender: Any) {
        NFCReader.sharedInstance.readChip()
    }
    
}



OCR Result Model

```swift
public class MrzScanResult {
    public let documentImage: UIImage
    public let documentType: String
    public let countryCode: String
    public let surnames: String
    public let givenNames: String
    public let documentNumber: String
    public let nationality: String
    public let birthDate: Date?
    public let sex: String?
    public let expiryDate: Date?
    public let personalNumber: String
    public let personalNumber2: String?
    public let mrzString: String
}
```
NFC Scan result Model
```swift
public class DocumentModel{
    public private(set) lazy var documentType : String =
    public private(set) lazy var documentSubType : String
    public private(set) lazy var personalNumber : String
    public private(set) lazy var documentNumber : String
    public private(set) lazy var issuingAuthority : String
    public private(set) lazy var documentExpiryDate : String
    public private(set) lazy var dateOfBirth : String
    public private(set) lazy var gender : String
    public private(set) lazy var nationality : String
    public lazy var lastName : String
    public lazy var firstName : String
    public var passportImage : UIImage
    public var issueDate:String?
    public var placeOfBirth:String?
    public var address:String?    
    public var telephone:String? 
    public var profession:String? 
}
```
