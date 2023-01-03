//
//  RxMoya+.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/22.
//

import Moya
import RxSwift
import RealmSwift

extension MoyaProvider {
    func cacheRequest(token: Target) -> Observable<Moya.Response> {
        return Observable.create({[weak self] (observer) -> Disposable in
            var key = token.baseURL.absoluteString + token.path
            if case .requestParameters(let param, _) = token.task, let requestParam = self?.toJSONString(dict: param) {
                key += requestParam
            }
            DispatchQueue.main.async {
                do {
                    let realm = try Realm()
                    let pre = NSPredicate(format: "key = %@",key)
                    let ewresponse = realm.objects(ResultModel.self).filter(pre)
                    if !ewresponse.isEmpty, let filterResult = ewresponse.first, let data = filterResult.data {
                        let creatResponse = Response(statusCode: filterResult.statuCode, data: data)
                        observer.onNext(creatResponse)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            let cancellableToken = self?.request(token) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                    let model = ResultModel()
                    model.data = response.data
                    model.key = key
                    model.statuCode = response.statusCode
                    DispatchQueue.main.async {
                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.add(model, update: .all)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        })
    }
    /// Convert Dictionary to JSON string
    func toJSONString(dict: Dictionary<String, Any>?) -> String {
        guard let _dict = dict,
              let _data = try? JSONSerialization.data(withJSONObject: _dict, options: JSONSerialization.WritingOptions.prettyPrinted),
              let strJson = NSString(data: _data, encoding: String.Encoding.utf8.rawValue) else { return "" }
        return strJson as String
    }
}
