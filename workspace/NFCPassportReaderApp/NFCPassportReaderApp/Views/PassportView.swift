//
//  PassportView.swift
//  NFCPassportReaderApp
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI

// Outline view of passport
struct PassportView : View {
    var passport : Passport?
    
    init( passport: Passport? ) {
        self.passport = passport
    }
    
    var body: some View {
        return HStack {
            if (self.passport) != nil {
                
                ZStack(alignment: .bottomTrailing) {
                    PassportDetailsView(passport: self.passport!)
                    
                    HStack {
                        if !self.passport!.passportDataValid {
                            VStack {
                                Image( systemName:"exclamationmark").foregroundColor(.red)
                                    .font(.system(size: 50))
                                    .padding(.bottom, 5)
                                
                                Text( "Tampered")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            
                        }
                        VStack(alignment: .center) {
                            if self.passport!.passportSigned {
                                Image( systemName:"checkmark.seal").foregroundColor(.green)
                                    .font(.system(size: 50))
                                    .padding(.bottom, 5)
                                Text( "Genuine")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            } else {
                                Image( systemName:"xmark.seal").foregroundColor(.red)
                                    .font(.system(size: 50))
                                    .padding([.leading,.trailing], 15)
                                    .padding(.bottom, 5)
                                Text( "Not Genuine")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 22)
                            }
                        }

                    }.padding( [.trailing, .bottom], 10)
                }
            } else {
                Text( "No Passport set")
            }
        }
        .background(Image( "background" ).blur(radius:10))
        .cornerRadius(10)
        .shadow(radius: 20)
        
    }
}


// Shows the Pzssport details
struct PassportDetailsView : View {
    var passport: Passport
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Spacer()
                Image(uiImage:passport.image)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 180)
                    .padding([.leading], 10.0)
                Spacer()
            }
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text( passport.documentType)
                    Spacer()
                    Text( passport.issuingAuthority)
                    Spacer()
                    Text( passport.documentNumber)
                }
                Text( passport.lastName)
                Text( passport.firstName)
                Text( passport.nationality)
                Text( passport.dateOfBirth)
                Text( passport.gender)
                Text( passport.documentExpiryDate )
                
                Spacer()
            }.padding([.trailing], 10.0)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
    }
}

 
#if DEBUG
struct PassportView_Previews : PreviewProvider {
    static var previews: some View {
        let pptData = "P<GBRTEST<<TEST<TEST<<<<<<<<<<<<<<<<<<<<<<<<1234567891GBR8001019M2106308<<<<<<<<<<<<<<04"
        let passport = Passport( passportMRZData: pptData, image:UIImage(named: "head")!, signed: false, dataValid: false )
        let pd = PassportDetails()
        pd.passport = passport
        
        return Group {
            PassportView( passport:passport)
                .environment( \.colorScheme, .light)
 
        }.frame(width: UIScreen.main.bounds.width-10, height: 220)
        .environmentObject(pd)
    }
}
#endif
