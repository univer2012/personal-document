//
//  SHNFCPassportViewController.swift
//  SwiftDemo160801
//
//  Created by Mac on 2019/10/16.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit
import CoreNFC

@available(iOS 13.0, *)
class SHNFCPassportViewController: UIViewController,NFCTagReaderSessionDelegate {

    var nfcTagReaderSession: NFCTagReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scanBtn = UIButton()
        scanBtn.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.size.width - 40, height: 80)
        scanBtn.setTitle("Scan", for: .normal)
        scanBtn.backgroundColor = .blue
        scanBtn.setTitleColor(.white, for: .normal)
        scanBtn.addTarget(self, action: #selector(clickedNFC(_:)), for: .touchUpInside)
        view.addSubview(scanBtn)
    }
    
    @objc func clickedNFC(_ sender: Any) {
        guard NFCNDEFReaderSession.readingAvailable else {
            let alerView = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support tag scanning.",
                preferredStyle: .alert
            )
            alerView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alerView, animated: true, completion: nil)
            return
        }
        // 此处表示我要识别iso15693和iso14443两种NFC标签类型
        nfcTagReaderSession = NFCTagReaderSession(pollingOption: [.iso15693, .iso14443, .iso18092], delegate: self)
        nfcTagReaderSession?.alertMessage = "Hold your iPhone near the ISO15693 tag to begin transaction."
        nfcTagReaderSession?.begin()
        
    }
    
    //MARK: - Delegate
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("tagReaderSessionDidBecomeActive")
        print("isReady: \(String(describing: nfcTagReaderSession?.isReady))")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("tagReaderSession error:\(error)")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        // this part is never called!
        print("tagReaderSession tags:\(tags)")
        var tag: NFCTag? = nil
        var type: Int = 0
        if case let .iso15693(fdTag) = tags.first {
            //print("iso15693:\(self.string(from:  fdTag.identifier))")
            tag = tags.first
            type = 1
        }
        
        if case let .miFare(mifareTag) = tags.first {
            //print("mifareTag:\(self.string(from:  mifareTag.identifier))")
            if mifareTag.mifareFamily == .ultralight {
                tag = tags.first
                type = 2
            }
        }
        
        if tag == nil {
            session.invalidate(errorMessage: "No valid tag found.")
            return
        }
        
        session.connect(to: tag!) { (error: Error?) in
            if error != nil {
                session.invalidate(errorMessage: "Connection error. Please try again.")
                return
            }
            print("connect tag:\(String(describing: tag))")
            
            if type == 1 {
                self.writeData(from: tag!)
            }else {
                self.readMifare(tag!)
            }
        }
        
    }
    
    func writeData(from tag: NFCTag) {
        print("*********")
        guard case let .iso15693(one_five_six_nine_three_tag) = tag else {
            print("-----")
            return
        }
        let fastRead: [UInt8] = [0x00, 0x00, 0x00]
        DispatchQueue.global().async {
//            self.write15693(Data(fastRead), from: one_five_six_nine_three_tag)
            one_five_six_nine_three_tag.customCommand(requestFlags: [.highDataRate], customCommandCode: 0xCF, customRequestParameters: Data(fastRead)) { (responseData, error) in
                print("responseData:\(responseData),error:\(String(describing: error))")
            }
        }
    }
    func readMifare(_ tag: NFCTag) {
        guard case let .miFare(mifareTag) = tag else {
            return
        }
        DispatchQueue.global().async {
            //        let ledCommand: [UInt8] = [0x40, 0xc9, 0x02, 0x00, 0x00, 0x00, 0x00]
//            let first: [UInt8] = [0x40, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00]
            let first: [UInt8] = [0x71, 0x07]
            mifareTag.sendMiFareCommand(commandPacket: Data(first)) { (responseData, error: Error?) in
                print("responseData:\([UInt8](responseData)), error:\(String(describing: error))")
//                DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
//                    let second: [UInt8] = [0x40, 0xc0, 0x80, 0x00, 0x00, 0x00, 0x00]
//                    mifareTag.sendMiFareCommand(commandPacket: Data(second)) { (responseData, error: Error?) in
//                        print("temperature:\(self.string(from: responseData)), error:\(String(describing: error))")
//                        self.session?.invalidate()
//                    }
//                }
            }
        }
    }
    

}
