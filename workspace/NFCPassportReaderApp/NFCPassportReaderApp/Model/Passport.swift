//
//  Passport.swift
//  NFCPassportReaderApp
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
//import NFCPassportReader


public struct Passport {
    public var documentType : String
    public var documentSubType : String
    public var personalNumber : String
    public var documentNumber : String
    public var issuingAuthority : String
    public var documentExpiryDate : String
    public var firstName : String
    public var lastName : String
    public var dateOfBirth : String
    public var gender : String
    public var nationality : String
    public var image : UIImage
    
    public var passportSigned : Bool = false    //护照是否签名正确
    public var passportDataValid : Bool = false //护照数据是否有效
    public var errors : [Error] = []
    
    public var fullName: String
    
    init( fromNFCPassportModel model : NFCPassportModel ) {
        self.image = model.passportImage ?? UIImage(named:"head")!
        
        let elements = model.passportDataElements ?? [:]
        print("识别出来的个人信息：")
        print( elements )
        let type = elements["5F03"] //值为：PO //类型
        documentType = type?[0] ?? "?"      //文档类型
        documentSubType = type?[1] ?? "?"   //文档子类型
        
        issuingAuthority = elements["5F28"] ?? "?" //发行机关
        documentNumber = (elements["5A"] ?? "?").replacingOccurrences(of: "<", with: "" ) //护照编号
        nationality = elements["5F2C"] ?? "?"   //国籍
        dateOfBirth = elements["5F57"]  ?? "?"  //出生日期
        gender = elements["5F35"] ?? "?"        //性别
        documentExpiryDate = elements["59"] ?? "?"  //过期日期
        personalNumber = (elements["53"] ?? "?").replacingOccurrences(of: "<", with: "" )   //个人编号
        
        let names = (elements["5B"] ?? "?").components(separatedBy: "<<")   //姓名，值为："HU<<HUAXIANG<<<<<<<<<<<<<<<<<<<<<<<<<<<"
        lastName = names[0].replacingOccurrences(of: "<", with: " " )   //姓
        
        var name = ""
        if names.count > 1 {
            let fn = names[1].replacingOccurrences(of: "<", with: " " ).strip()
            name += fn + " "
        }
        firstName = name.strip()    //名
        
        self.fullName = model.fullName ?? ""    //"王东海"
        
        
        // Check whether a genuine passport or not
        
        // Two Parts:
        // Part 1 - Has the SOD (Security Object Document) been signed by a valid country signing certificate authority (CSCA)?
        // 第1部分—安全对象文档是否由有效的国家签名证书颁发机构(CSCA)签署?
        // Part 2 - has it been tampered with (e.g. hashes of Datagroups match those in the SOD?
        // 第2部分-它被篡改了吗?(例如，数据组的哈希值与SOD匹配?)
        guard let sod = model.getDataGroup(.SOD) else { return }
        
        guard let dg1 = model.getDataGroup(.DG1),
            let dg2 = model.getDataGroup(.DG2) else { return }
        
        
        // Validate passport 验证护照
        let pa =  PassiveAuthentication()
        //是否签名正确
        do {
            //检查护照是否签名正确
            try pa.checkPassportCorrectlySigned( sodBody : sod.body )
            self.passportSigned = true
        } catch let error {
            self.passportSigned = false
            errors.append( error )
        }
        //护照数据是否有效
        do {
            //检查数据是否被篡改
            try pa.checkDataNotBeenTamperedWith( sodBody : sod.body, dataGroupsToCheck: [.DG1:dg1, .DG2:dg2] )
            self.passportDataValid = true
        } catch let error {
            self.passportDataValid = false
            errors.append( error )
        }
    }
    
    init( passportMRZData: String, image : UIImage, signed:Bool, dataValid:Bool ) {
        
        self.image = image
        self.passportSigned = signed
        self.passportDataValid = dataValid
        let line1 = passportMRZData[0..<44]
        let line2 = passportMRZData[44...]
        
        // Line 1
        documentType = line1[0..<1]
        documentSubType = line1[1..<2]
        issuingAuthority = line1[2..<5]
        
        let names = line1[5..<44].components(separatedBy: "<<")
        lastName = names[0].replacingOccurrences(of: "<", with: " " )
        
        var name = ""
        if names.count > 1 {
            let fn = names[1].replacingOccurrences(of: "<", with: " " ).strip()
            name += fn + " "
        }
        firstName = name.strip()
        
        
        self.fullName = ""
        
        // Line 2
        documentNumber = line2[0..<9].replacingOccurrences(of: "<", with: "" )
        nationality = line2[10..<13]
        dateOfBirth = line2[13..<19]
        gender = line2[20..<21]
        documentExpiryDate = line2[21..<27]
        personalNumber = line2[28..<42].replacingOccurrences(of: "<", with: "" )
    }
}
