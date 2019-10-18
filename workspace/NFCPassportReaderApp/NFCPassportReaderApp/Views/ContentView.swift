//
//  ContentView.swift
//  NFCPassportReaderApp
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI
import Combine
//import NFCPassportReader

// A View that just uses the UIColor systemBackground allowing
// For light.dark mode support - willo be removed once this makes its way into SwiftUI properly
struct BackgroundView : UIViewRepresentable {
    
    var color: UIColor = .systemBackground
    
    func makeUIView(context: Context) -> UIView {
        UIView(frame: .zero)
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        view.backgroundColor = color
    }
}



struct ContentView : View {
    @EnvironmentObject var passportDetails: PassportDetails

    @State private var showingAlert = false
    @State private var showDetails = false
    @State private var alertTitle : String = ""
    @State private var alertMessage : String = ""
    
    private let passportReader = PassportReader()
    
    var body: some View {
        ZStack {
            VStack {
                Text( "Enter passport details" )
                    .foregroundColor(Color.secondary)
                    .font(.title)
                    .padding(0)

                TextField("Passport number",
                          text: $passportDetails.passportNumber)
                    .textContentType(.name)
                    .foregroundColor(Color.secondary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                
                TextField("Date of birth",
                          text: $passportDetails.dateOfBirth)
                    .foregroundColor(Color.secondary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                
                TextField("Passport expiry date",
                          text: $passportDetails.expiryDate)
                    .foregroundColor(Color.secondary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])

                Spacer()
            }.padding( .top )
            VStack {
                Spacer()
                
                Button(action: {
                    self.scanPassport()
                }) {
                    Text("Scan Passport")
                        .font(.largeTitle)
                    .foregroundColor(passportDetails.isValid ? .secondary : Color.secondary.opacity(0.25))
                    }
                    //.disabled( !passportDetails.isValid )
                Spacer()
            }
            
            PassportView( passport: self.passportDetails.passport )
                .frame(width: UIScreen.main.bounds.width-20, height: 220)
                .offset(y: showDetails ? 0 : UIScreen.main.bounds.height + 100)
                .animation(.easeInOut(duration: 0.3))
                .onTapGesture {
                    self.showDetails.toggle()
                }
        }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message:
                    Text(alertMessage), dismissButton: .default(Text("Got it!")))
    }
     .background(BackgroundView())
    }
}

extension ContentView {
    func scanPassport( ) {
        let mrzKey = self.passportDetails.getMRZKey()

        
        //let dataGroups : [DataGroupId] = [.COM, .DG1, .DG2, .DG3, .DG4, .DG5, .DG6, .DG7, .DG8, .DG9, .DG10, .DG11, .DG12, .DG13, .DG14, .DG15, .DG16 ,.SOD]
        let dataGroups : [DataGroupId] = [.COM, .DG1, .DG2, .SOD]
        print("mrzKey: \(mrzKey)")
        passportReader.readPassport(mrzKey: mrzKey, tags: dataGroups, completed: { (passport, error) in
            if let passport = passport {
                // All good, we got a passport 很好，我们有护照了
                let passportModel = Passport( fromNFCPassportModel: passport)

                DispatchQueue.main.async {
                    self.passportDetails.passport = passportModel
                    self.showDetails.toggle()
                }

            } else {
                self.alertTitle = "Oops"
                self.alertTitle = "\(error?.localizedDescription ?? "Unknown error")"
                self.showingAlert = true

            }
        })

    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {

    static var previews: some View {
        let pptData = "P<GBRTEST<<TEST<TEST<<<<<<<<<<<<<<<<<<<<<<<<1234567891GBR8001019M2106308<<<<<<<<<<<<<<04"
        let passport = Passport( passportMRZData: pptData, image:UIImage(named: "head")!, signed: true, dataValid: true )
        let pd = PassportDetails()
        pd.passport = passport
        
        return Group {
            ContentView().environment( \.colorScheme, .light).environmentObject(pd)
            ContentView().environment( \.colorScheme, .dark).environmentObject(pd)
        }
    }
}
#endif
