//
//  Explore.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/18/22.
//

import SwiftUI
import MapKit
import CoreLocation
import Firebase

struct Explore: View {
    // MARK: - Properties
    @State var map = MKMapView()
    @State var manager = CLLocationManager()

    var body: some View {
        VStack {
            Text("Explore")
        }
    }
}

//
//struct Explore_Previews: PreviewProvider {
//    static var previews: some View {
//        Explore()
//    }
//}
//
//
//struct MapView : UIViewRepresentable {
//
//    @Binding var map : MKMapView
//    func makeUIView(context: Context) ->  MKMapView {
//
//        map.delegate = context.coordinator
//        manager.delegate = context.coordinator
//        map.showsUserLocation = true
//        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.tap(ges:)))
//        map.addGestureRecognizer(gesture)
//        return map
//    }
//
//    func updateUIView(_ uiView:  MKMapView, context: Context) {
//
//
//    }
//
//}
//
