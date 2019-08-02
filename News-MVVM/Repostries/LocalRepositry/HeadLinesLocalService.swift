//
//  HeadLinesLocalService.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 8/1/19.
//  Copyright © 2019 shaat. All rights reserved.
//
import RealmSwift
import Foundation
import RxSwift

class HeadLinesLocalService: HeadLinesServiceProtocol  {
    
    func getHeadlines(newsRequest: NewsRequest) -> Observable<[Article]> {
        return Observable.create { observer in
            let realm = try! Realm()
            let articles = realm.objects(Article.self)
            observer.onNext(Array(articles))
            return Disposables.create()
    }
    }
 
    class func  save(articles: [Article]) {
        let realm = try! Realm()
        let oldArticles = realm.objects(Article.self)
        try! realm.write {
            realm.delete(oldArticles)
            realm.add(articles)
        }
    }
   
}
