//
//  ViewController.swift
//  Sample App For SDK
//
//  Created by Abbas amini on 4/1/23.
//

import UIKit

import NFCReaderApple

class ViewController: UIViewController  , CardAndPassportDetectionViewControllerDelegate,NFCReaderDelegate {
    func didSuccess(data: NFCReaderApple.NFCPassportModel) {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        lblFirstName.text = "First Name: \(data.firstName)"
        lblLastName.text = "Last Name : \(data.lastName)"
        lblBirthDay.text = "Birthday : \(data.dateOfBirth)"
        lblPersoanlNumber.text = "Persoanl No: \(data.personalNumber ?? "can not read")"
        lblDocumentNumber.text = "Document No: \(data.documentNumber)"
        imgNFCimage.image = data.passportImage
    }
    
    func resultScanner(didFind result: NFCReaderApple.MrzScanResult) {
        
    }
    
    private var result : MrzScanResult? = nil
    func didFail(message: String) {
        lblLastName.text = message
    }

    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var imgNFCimage: UIImageView!
    @IBOutlet weak var imgFront: UIImageView!
    @IBOutlet weak var lblPersoanlNumber: UILabel!
    @IBOutlet weak var lblDocumentNumber: UILabel!
    
    @IBOutlet weak var lblMrz: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    
    @IBOutlet weak var swPassport: UISwitch!
    @IBAction func passportMode(_ sender: Any) {
    }
    @IBOutlet weak var lblLastName: UILabel!
    
    @IBOutlet weak var lblBirthDay: UILabel!
    
    @IBOutlet weak var lblValid: UILabel!
    func cardAndPassportDetectionViewController(_ viewController: CardAndPassportDetectionViewController, didDetectCard mrzScanResult: MrzScanResult, withSettings settings: CardAndPassportDetectionSettings) {

        CoreReader.sharedInstace.delegate = self
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        self.result = mrzScanResult
        lblFirstName.text = "First Name : \(mrzScanResult.surnames) "
        lblLastName.text = "Last Name : \(mrzScanResult.givenNames)"
        lblBirthDay.text = "Birthday : \(formatter1.string(from: mrzScanResult.birthDate!))"
        imgBack.image = mrzScanResult.backImage
        imgFront.image = mrzScanResult.frontImgae
        lblPersoanlNumber.text = "Personal No : \(mrzScanResult.personalNumber)"
        lblDocumentNumber.text = "Document No : \(mrzScanResult.documentNumber)"
        lblMrz.text = "MRZ : \(mrzScanResult.mrzString)"
        
    }
    
    @IBOutlet weak var btnScanner: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    
    }

    @IBAction func scanner(_ sender: Any) {
        let settings = CardAndPassportDetectionSettings()
        settings.passportMode = swPassport.isOn
        let controller = CardAndPassportDetectionViewController(settings: settings)
        controller.delegate = self
        lblFirstName.text = "First Name :"
        lblLastName.text = "Last Name :"
        lblBirthDay.text = "Birthday :"
        imgBack.image = nil
        imgFront.image = nil
        lblPersoanlNumber.text = "Personal No :"
        lblDocumentNumber.text = "Document No :"
        lblMrz.text = "MRZ:"
        self.present(controller, animated: true)
    }
    
    @IBAction func readChip(_ sender: Any) {
        if let c = self.result {
                        CoreReader.sharedInstace.readChip(resulat: c)
        }else{
            // create the alert
                   let alert = UIAlertController(title: "Error", message: "First scan card or passport with OCR", preferredStyle: UIAlertController.Style.alert)

                   // add an action (button)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
        }
        
       
        
    }
}


