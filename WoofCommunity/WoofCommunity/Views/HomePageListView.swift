//
//  HomePageListView.swift
//  WoofCommunity
//
//  Created by Kathleen Diep on 7/11/22.
//
import SwiftUI
import MapKit
import CoreLocation

struct HomePageListView: View {
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct HomePageListView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageListView()
    }
}

// MARK: - STRUCT VIEWS

struct Home : View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
            }
        }
    }
    
}
