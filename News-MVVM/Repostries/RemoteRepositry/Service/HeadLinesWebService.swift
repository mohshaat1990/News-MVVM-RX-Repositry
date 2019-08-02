//
//  HeadLinesService.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/31/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import RxSwift
import Moya
import Moya_ObjectMapper

class HeadLinesWebService : HeadLinesServiceProtocol {
    func getHeadlines(newsRequest: NewsRequest) -> Observable<[Article]> {
        return Observable.create { observer in
            let provider = MoyaProvider<HeadlinesApi>()
            provider.rx.request(.getTopHeadlines(newsRequest: newsRequest))
                .filterSuccessfulStatusCodes().mapObject(TopHeadlines.self)
                .subscribe(onSuccess: { (topHeadlines) in
                    if let articles = topHeadlines.articles {
                    observer.onNext(articles)
                    }
                }, onError: { (error) in
                    observer.onError(error)
                })
            return Disposables.create()
        }
    }
}
