//
//  NewsViewModel.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/21.
//

import RxSwift
import Moya

final class NewsViewModel {
    private let provider = MoyaProvider<News>()
    func loadData<T: Mapable>(_ model: T.Type) -> Observable<[T]> {
        return provider.cacheRequest(token: .articles)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observe(on: MainScheduler.instance)
            .debug()
            .distinctUntilChanged()
            .catch({ (error) -> Observable<Response> in
                return Observable.empty()
            }).mapResponseToArray(T.self)
    }
}

 
