//
//  SHMapView.swift
//  SwiftUIDemo191203
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView:View, UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
        
        MKMapView(frame: .zero)
        
    }
    
    
    func updateUIView(_ uiView: MapView.UIViewType, context: UIViewRepresentableContext<MapView>) {
        
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}
#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: landmarkData[0].locationCoordinate)
    }
}
#endif
