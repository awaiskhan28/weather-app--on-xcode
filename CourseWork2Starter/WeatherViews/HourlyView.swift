//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.

import SwiftUI

struct HourlyView: View {
    
   @EnvironmentObject var modelData: ModelData

    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            
            VStack {
                
                
                Spacer()
                Text(modelData.userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                        
                    }
                }.listStyle(.automatic) .scrollContentBackground(.hidden).background(Color.white).opacity(0.8)
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            .foregroundColor(.black)
            .shadow(color: .clear,  radius: 0.5).opacity(0.8)
            
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])

    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
