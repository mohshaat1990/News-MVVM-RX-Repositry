//
//  GetHeadlinesProtocol.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/30/19.
//  Copyright © 2019 shaat. All rights reserved.
//
import RxSwift
protocol HeadLinesServiceProtocol {
    func getHeadlines(newsRequest: NewsRequest)-> Observable<[Article]>
}
