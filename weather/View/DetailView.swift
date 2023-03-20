//
//  DetailView.swift
//  weather
//Program bol vytvoreny v rámci kurzu na portali skillmea.sk
//  Created by crow on 20/03/2023.
//

import SwiftUI

struct DetailView: View {
    @State private var weatherResult: WeatherMain?

    let location: Locations
    
    let icon = [
        "01d": "sun.max.fill",
        "02d": "cloud.sun.fill",
        "03d": "cloud.fill",
        "04d": "smoke.fill",
        "09d":"cloud.sun.rain.fill",
        "10d": "cloud.heavyrain.fill",
        "11d": "cloud.bolt.fill",
        "13d": "cloud.snow.fill",
        "50d": "text.aligncenter"
    ]
    
    var svkDescription: String {
        switch weatherResult?.current.weather.first?.main {
        case "Clear":
            return "Jasno"
        case "Clouds":
            return "Oblačno"
        case "Thunderstorm":
            return "Búrka"
        case "Drizzle":
            return "Mrholenie"
        case "Rain":
            return "Dážď"
        case "Snow":
            return "Sneženie"
        default:
            return "No more"
        }
    }
    
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                Text("\(Date.now, format: .dateTime.day().month().year())")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                
                Text(svkDescription)
                    .font(.system(size:35))
                    .padding(.bottom, -30)
                
                Text("\(Int(weatherResult?.current.temp ?? 0))°C")
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                
                Text("Pocitová teplota je \(Int(weatherResult?.current.feels_like ?? 0))°C")
                    .padding(.bottom, 50)
                    .padding(.top, -40)
                    .foregroundColor(.gray)
                
                if let day = weatherResult?.daily {
                    ForEach(day, id: \.dt) { day in
                        HStack{
                            Text(dayOfWeek(_:day.dt))
                                .frame(width: 110, alignment: .leading)
                            
                            Spacer()
                            Image(systemName:icon[day.weather.first!.icon] ?? "exclamationmark.square")
                                .symbolRenderingMode(.multicolor)
                            
                            Spacer()
                            Text("\(Int(day.temp.day))°C")
                                .frame(width: 60, alignment: .trailing)
                        }
                        .padding(.bottom, 3)
                        
                        Divider()
                    }
                }
            }.padding(20)
            
        }.navigationTitle(location.name)

            .onAppear{
                downloadData(lat: location.latitude, lon: location.longtitude)
            }
    }
    
    func downloadData(lat:Double, lon:Double){
       
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=\( APIKey.appID)&exclude=minutely,hourly,alerts&units=metric"
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Missing data")
                return
            }
            
            if let json = try? JSONDecoder().decode(WeatherMain.self, from: data){
               weatherResult = json
            }
        }
        task.resume()
    }
    
    func dayOfWeek(_ num:Int) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        let jsonDate = Date(timeIntervalSince1970: TimeInterval(num))
        let dateString = formatter.string(from: jsonDate).capitalized
        return dateString
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let lc = Locations(name: "Čadca", latitude: 49.4386, longtitude: 18.7898 )
        DetailView(location: lc)
    }
}
