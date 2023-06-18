//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//  Modified by A Mor.

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    init() { UITableView.appearance().backgroundColor = UIColor.clear
     
           UITableViewCell.appearance().backgroundColor = UIColor.clear
         
    }
    var body: some View {
        
        ZStack{
            Image("background2")
                .resizable().opacity(0.8)
            VStack {
                
                
                Spacer()
                Text(modelData.userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                
                
                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }.listStyle(.automatic) .scrollContentBackground(.hidden).background(Color.white).opacity(0.9)
            }.padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            .foregroundColor(.black)
            .shadow(color: .accentColor,  radius: 0.5).opacity(0.9)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])

        .onAppear {
            Task.init {
                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
               
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
