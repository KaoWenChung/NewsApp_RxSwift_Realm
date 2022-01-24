//
//  Config.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/22.
//

import RealmSwift

enum Status: String {
    case success = "ok"
    case otherError
}

// Response of JSON data field
let RESULT_CODE = "status"
let RESULT_DATA = "articles"

/// realm data store model (store statueCode because in offline, we would need it to determine if it was a successful request)
final class ResultModel: Object {
    @objc dynamic var data: Data? = nil
    @objc dynamic var statuCode: Int = 0
    @objc dynamic var key: String = ""
    override static func primaryKey() -> String? {
        return "key"
    }
}
