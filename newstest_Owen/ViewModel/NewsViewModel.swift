//
//  NewsViewModel.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/21.
//

import RxSwift
import Moya

class NewsViewModel {
    private let provider = MoyaProvider<News>()
   
    func loadData<T: Mapable>(_ model: T.Type) -> Observable<T?> {
        
        return provider.offLineCacheRequest(token: .articles)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observe(on: MainScheduler.instance)
            .debug()
            .distinctUntilChanged()
            .catch({ (error) -> Observable<Response> in
                //捕获错误，不然离线访问会导致Binding error to UI，可以再此显示HUD等操作
                print(error.localizedDescription)
                return Observable.empty()
            }).mapResponseToObj(T.self)
    }
}

 
