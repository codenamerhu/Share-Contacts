//
//  QRCodeAddContactViewController.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/09.
//

import UIKit
import AVFoundation

import Contacts

class QRCodeAddContactViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let contact = CNMutableContact()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            messageAlert(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.")
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            messageAlert(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.")
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func messageAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: title, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        print("code is \(metadataObjects)")
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        print("QRCode is \(code)")
        
        let dataArray = code.components(separatedBy: ",")
        print("QRCode is \(dataArray)")
        
        for contactData in dataArray {
            let con = contactData.components(separatedBy: "=")
            makeContact(key: con[0], value: con[1])
        }
        
        // Save
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        do {
            print("saved")
            try store.execute(saveRequest)
            messageAlert(title: "Contact saved", message: "Contact has been sucessfully save")
            
        } catch {
            messageAlert(title: "Action faled", message: "Something went wrong")
            print("Saving contact failed, error: \(error)")
        }
        
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func makeContact(key: String, value: String) {
        switch key {
        case "givename":
            contact.givenName = decryptSymbols(string: value)
            
        case "familyname":
            contact.familyName = decryptSymbols(string: value)
            
        case "mobile":
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberMobile,
                value: CNPhoneNumber(stringValue: decryptSymbols(string: value)))]
            
        case "telephone":
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberiPhone,
                value: CNPhoneNumber(stringValue: decryptSymbols(string: value)))]
            
        case "homephone":
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberHomeFax,
                value: CNPhoneNumber(stringValue: decryptSymbols(string: value)))]
            
        case "workphone":
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberWorkFax,
                value: CNPhoneNumber(stringValue: decryptSymbols(string: value)))]
            
        case "mainphone":
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberMain,
                value: CNPhoneNumber(stringValue: decryptSymbols(string: value)))]
            
        case "otherphone":
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberOtherFax,
                value: CNPhoneNumber(stringValue: decryptSymbols(string: value)))]
            
        default:
            return
        }
        
    }

}

