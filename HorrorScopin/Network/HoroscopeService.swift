//
//  HoroscopeService.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-03.
//

import Foundation
import RxSwift

enum CustomError: String, Error {
    case Decoding
    case Service
    case Input
}

class HoroscopeService {
    private struct Constants {
        static let baseURL = "https://aztro.sameerkumar.website"
        static let sign = "/?sign="
        static let day = "&day="
    }
    
    static private var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }
    
    static func getHoroscope(for sign: String = "aries", day: String = "yesterday")-> Observable<Horoscope?>{
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.sign)\(sign)\(Constants.day)\(day)") else {
            return Observable.empty()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try? jsonDecoder.decode(Horoscope.self, from: data)
            }
    }
    
//    static func getHoroscope(for sign: String = "aries", day: String = "yesterday", handler: @escaping (Result<Horoscope,Error>) -> () ) {
//        guard let url = URL(string: "\(Constants.baseURL)\(Constants.sign)\(sign)\(Constants.day)\(day)") else {
//            handler(.failure(CustomError.Input))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let httpResponse = response as? HTTPURLResponse  else {
//                handler(.failure(CustomError.Service))
//                return
//            }
//            if httpResponse.statusCode == 200 {
//                let jsoonDecoder = JSONDecoder()
//                jsoonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let data = data,
//                   let locationDetails = try? jsoonDecoder.decode(Horoscope.self, from: data)  {
//                    print(locationDetails)
//                    handler(.success(locationDetails))
//                } else {
//                    handler(.failure(CustomError.Decoding))
//                    return
//                }
//            } else {
//                print("Status code: \(httpResponse.statusCode)")
//                handler(.failure(CustomError.Service))
//            }
//        }.resume()
//    }
//    
 
}
