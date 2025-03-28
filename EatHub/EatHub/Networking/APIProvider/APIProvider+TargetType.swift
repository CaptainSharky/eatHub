//
//  APIProvider+TargetType.swift
//  EatHub
//
//  Created by Kirill Prokofyev on 25.03.2025.
//

import Foundation

extension APIProvider {
    var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "https://www.themealdb.com/api/json/v2/9973533")!
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

    var method: String {
        "GET"
    }

    // swiftlint:disable:next discouraged_optional_collection
    var queryItems: [URLQueryItem]? {
        switch self {
            case .searchMeal(let name):
                return [URLQueryItem(name: "s", value: name)]
            case .mealDetails(let id):
                return [URLQueryItem(name: "i", value: id)]
            default:
                return nil
        }
    }

    var urlRequest: URLRequest? {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = queryItems

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
