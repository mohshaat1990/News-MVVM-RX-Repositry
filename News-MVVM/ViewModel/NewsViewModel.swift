//
//  NewsViewModel.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/30/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import RxSwift
import RxCocoa
import Reachability

class NewsViewModel: ViewModelProtocol {
    
    struct Input {
        let load: AnyObserver<Void>
        let loadMore: AnyObserver<Void>
        let pullToRefresh: AnyObserver<Void>
    }
    
    struct Output {
        let rx_isLoading: Observable<Bool>
        let windlessStart:Observable<Bool>
        var articles : Observable<[Article]>
        let serverErrorsObservable: Observable<String>
    }
    
    // MARK: - Public properties
    var input: Input
    let output: Output
    
    // MARK: - Private properties
    private var headLineServiceProtcol : HeadLinesServiceProtocol!
    private let pageSize = Key.NewsDefaults.PageSize
    private let rx_isLoadingSubject = PublishSubject<Bool>()
    private let windlessStartSubject = PublishSubject<Bool>()
    private var page = 1
    private let loadSubject = PublishSubject<Void>()
    private let loadMoreSubject = PublishSubject<Void>()
    private let pullToRefreshSubject = PublishSubject<Void>()
    private let articlesSubject =  BehaviorRelay<[Article]>(value: [])
    private let serverErrorsSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    private var reachability: Reachability?
    
    init(_ headLinesServiceProtocol: HeadLinesServiceProtocol) {
        headLineServiceProtcol = headLinesServiceProtocol
        input = Input(load: loadSubject.asObserver(), loadMore: loadMoreSubject.asObserver(),
                      pullToRefresh: pullToRefreshSubject.asObserver())
        
        output = Output(rx_isLoading: rx_isLoadingSubject.asObservable(), windlessStart: windlessStartSubject.asObserver(), articles: articlesSubject.asObservable(),serverErrorsObservable: serverErrorsSubject.asObservable())
        observeRechability()
        observeLoading()
    }
    
    private func observeRechability() {
        reachability = Reachability()
        reachability?.whenReachable = { reachability in
            if self.headLineServiceProtcol is HeadLinesLocalService {
                self.headLineServiceProtcol = HeadLinesWebService()
                self.page = 1
                self.getNews()
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    private func observeLoading() {
        loadSubject.subscribe(onNext:{  _ in
            if self.headLineServiceProtcol is HeadLinesWebService {
                self.getNews()
            } else {
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        loadMoreSubject.subscribe(onNext:{  _ in
            if self.headLineServiceProtcol is HeadLinesWebService {
                self.page += 1
                self.getNews()
            } else {
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        pullToRefreshSubject.subscribe(onNext:{  _ in
            if self.headLineServiceProtcol is HeadLinesWebService {
                self.page = 1
                self.getNews()
            } else {
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
    }
    
    private func getCountryCode() -> String {
        return Key.NewsDefaults.defaultCountryCode
    }
    
    private func showLoading() {
        self.rx_isLoadingSubject.onNext(true)
        if self.articlesSubject.value.count == 0 {
            let array = [Article]( repeating: Article(), count: 10 )
            self.articlesSubject.accept(array)
            self.windlessStartSubject.onNext(true)
        } else {
            self.windlessStartSubject.onNext(false)
        }
    }
    
    private func hideLoading () {
        self.rx_isLoadingSubject.onNext(false)
        self.windlessStartSubject.onNext(false)
    }
    
    private func getNews() {
        showLoading()
        let newRequest = NewsRequest(countryCode: getCountryCode(), pageSize: self.pageSize, page: self.page )
        self.headLineServiceProtcol.getHeadlines(newsRequest: newRequest).materialize().subscribe(onNext: { [weak self] event in
            self?.hideLoading()
            switch event {
            case .next(let articles):
                self?.set(articles: articles)
            case .error(let error):
                if self?.page == 1 && self?.headLineServiceProtcol is HeadLinesWebService {
                    self?.headLineServiceProtcol = HeadLinesLocalService()
                    self?.getNews()
                }
                self?.serverErrorsSubject.onNext(error.localizedDescription)
            default:
                break
            }
        })
            .disposed(by: disposeBag)
    }
    
    private func set(articles: [Article]) {
        var allArticles = [Article]()
        if self.page != 1 {
            allArticles.append(contentsOf: self.articlesSubject.value)
        }
        saveOffline(articles: articles)
        allArticles.append(contentsOf: articles)
        self.articlesSubject.accept( allArticles)
    }
    
    private func saveOffline(articles: [Article]) {
        if headLineServiceProtcol is HeadLinesWebService && self.page == 1  {
            if articles.count >= 5  {
                HeadLinesLocalService.save(articles: Array(articles.prefix(5)))
            } else {
                HeadLinesLocalService.save(articles: articles)
            }
        }
    }
}
