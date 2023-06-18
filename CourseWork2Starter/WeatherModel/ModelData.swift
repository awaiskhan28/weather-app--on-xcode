import Foundation
class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published var air_pollution: AirPollution?
    @Published  var userLocation: String = ""
    init() {
        self.forecast = load("london.json")
        Task.init{
            do {
            try! await loadAirPollutionData(lat: forecast!.lat,lon: forecast!.lon)
            } catch {
                print("Error decoding JSON: \(error)")
                // Display an error message to the user
            }
        }
        
    }
    

    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=d8a82d90e5e5c44293f5cb7a883e09cc")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            userLocation = await getLocFromLatLong(lat: lat, lon: lon)
            Task.init{
                try! await loadAirPollutionData(lat: forecast!.lat,lon: forecast!.lon)
            }
            return forecastData
        } catch {
            throw error
        }
    }
    
    
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded_datat = try decoder.decode(Forecast.self, from: data)
           
            return decoded_datat
            
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
    
    func loadAirPollutionData(lat: Double, lon: Double) async throws -> AirPollution {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=d8a82d90e5e5c44293f5cb7a883e09cc")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            //print(data)
            let airPolutionData = try JSONDecoder().decode(AirPollution.self, from: data)
            DispatchQueue.main.async {
                self.air_pollution = airPolutionData
                
                
            }
           
            
            return airPolutionData
        } catch {
            throw error
        }
    }
}
