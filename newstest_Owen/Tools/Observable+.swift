//
//  Observable+.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/22.
//

import RxSwift
import SwiftyJSON
import Moya

/// Protocol for Data to JSON
public protocol Mapable {
    init?(jsonData:JSON)
}

/// Error Type
enum ObservableError: Error {
    /// not a response
    case noMoyaResponse
    /// fail of http request
    case failureHTTP
    /// out of data
    case noData
    /// it's not the object
    case notMakeObjectError
}

// MARK: - Extension Map
extension Observable {
    /// Convert data to JSON
    private func resultToJSON<T: Mapable>(_ jsonData: JSON, ModelType: T.Type) -> T? {
        return T(jsonData: jsonData)
    }
    /// Convert respnse data to object
    final func mapResponseToObj<T: Mapable>(_ type: T.Type) -> Observable<T?> {
        return map { representor in
            // Check is Moya.Response
            guard let response = representor as? Moya.Response else {
                throw ObservableError.noMoyaResponse
            }
            // Check is successful response
            guard ((200...209) ~= response.statusCode) else {
                throw ObservableError.failureHTTP
            }
            // Convert data to JSON
            let json = try JSON.init(data: response.data)
            // Check is status code exist and is response status code as same as successful status code
            if let code = json[RESULT_CODE].string, code == Status.success.rawValue {
                // Convert response status code and return it
                return self.resultToJSON(json[RESULT_DATA], ModelType: type)
            }else {
                // Throw error when it can't be declared.
                throw ObservableError.notMakeObjectError
            }
        }
    }
    
    /// convert respnse data to array of object
    final func mapResponseToArray<T: Mapable>(_ type: T.Type) -> Observable<[T]> {
        return map { response in
            guard let response = response as? Moya.Response else {
                throw ObservableError.noMoyaResponse
            }
            guard ((200...209) ~= response.statusCode) else {
                throw ObservableError.failureHTTP
            }
            let json = try JSON.init(data: response.data)
            if let code = json[RESULT_CODE].string, code == Status.success.rawValue {
                var objects: [T] = []
                let objectsArrays = json[RESULT_DATA].array
                if let array = objectsArrays {
                    for object in array {
                        if let obj = self.resultToJSON(object, ModelType:type) {
                            objects.append(obj)
                        }
                    }
                    return objects
                } else {
                    throw ObservableError.noData
                }
            } else {
                throw ObservableError.notMakeObjectError
            }
        }
    }
}

