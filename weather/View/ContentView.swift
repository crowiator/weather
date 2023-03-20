//
//  ContentView.swift
//  weather
// Program bol vytvoreny v rámci kurzu na portali skillmea.sk
//  Created by crow on 20/03/2023.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    //Map
    @State private var mapView = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.92, longitude: 19.64),
        span:MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    //Locations
    let locations = [
        Locations(name: "Čadca", latitude: 49.4386, longtitude: 18.7898 ),
        Locations(name: "Tunis", latitude: 36.8065, longtitude: 10.1815)
    ]
    
    
    var body: some View {
        
        
        
        NavigationView{
            //showing map on screen + pins
            Map(coordinateRegion: $mapView, annotationItems: locations){ location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longtitude)) {
                    NavigationLink {
                        DetailView(location: location)
                    } label: {
                        VStack{
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            Text(location.name)
                                .foregroundColor(.primary)
                                .font(.caption)
                        }
                    }

                }
                //all displey
            }.ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
