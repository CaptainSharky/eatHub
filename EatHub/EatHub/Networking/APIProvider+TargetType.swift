//
//  APIProvider+TargetType.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Moya
import Foundation

extension APIProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1")!
    }

    var path: String {
        switch self {
            case .searchMeal:
                return "/search.php"
            case .mealDetails:
                return "/lookup.php"
            case .randomMeal:
                return "/random.php"
            case .randomSelection:
                return "/randomselection.php"
            case .categories:
                return "/categories.php"
            case .latestMeals:
                return "/latest.php"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        //TODO: Добавить моки
        return Data()
    }

    var task: Task {
        switch self {
            case .searchMeal(let name):
                return .requestParameters(parameters: ["s": name], encoding: URLEncoding.default)
            case .mealDetails(let id):
                return .requestParameters(parameters: ["i": id], encoding: URLEncoding.default)
            default:
                return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
