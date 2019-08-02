//
//  NewsViewController.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/30/19.
//  Copyright © 2019 shaat. All rights reserved.
//
import RxSwift
import UIKit
import PullToRefreshKit
import Windless
class NewsViewController: UIViewController {
    typealias ViewModelType = NewsViewModel
    // MARK: - Properties
    private var viewModel: ViewModelType!
    private var newsService = HeadLinesWebService()
    private let disposeBag = DisposeBag()
    private let loadSubject = PublishSubject<Void>()
    private let loadMoreSubject = PublishSubject<Void>()
    private let pullToRefreshSubject = PublishSubject<Void>()
    // MARK: - UI
    @IBOutlet weak var newsTableView: UITableView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        viewModel = ViewModelType(newsService)
        configure(with: viewModel)
        initPullToRefresh()
        initLoadMoreToRefresh()
    }
    
}

extension NewsViewController: ConfigurableTableView {
    
    func startWindless() {
        self.newsTableView.windless
            .apply {
                $0.beginTime = 0
                $0.pauseDuration = 1
                $0.duration = 1.5
                $0.animationLayerOpacity = 0.8
            }
            .start()
    }
    
    func registerCell() {
        let listNib = UINib.init(nibName: HeadlineCell.getCellIdentifier(), bundle: nil)
        self.newsTableView.register(listNib, forCellReuseIdentifier: HeadlineCell.getCellIdentifier())
        
    }
    
    func initPullToRefresh() {
        self.newsTableView.configRefreshHeader(container:self) { [weak self] in
            self?.pullToRefreshSubject.onNext(())
        }
    }
    
    func initLoadMoreToRefresh() {
        self.newsTableView.configRefreshFooter(container:self) { [weak self] in
            self?.newsTableView.switchRefreshFooter(to: .refreshing)
            self?.loadMoreSubject.onNext(())
        }
        
    }
}
// MARK: - View Model Configure
extension NewsViewController: ControllerType {
    func configure(with viewModel: NewsViewModel) {
        bindViews()
        obseverLoading()
       self.loadSubject.onNext(())
        
    }
}
// MARK: - RX Configure
extension NewsViewController: ConfigureRx {
    func bindViews() {
        viewModel.output.articles.bind(to: newsTableView.rx.items(cellIdentifier: HeadlineCell.getCellIdentifier(),
                                                                  cellType: HeadlineCell.self)) {  row, article, cell in
                                                        cell.configure(data: article)
                                                                    
            }
            .disposed(by: disposeBag)
        loadSubject.subscribe(viewModel.input.load)
            .disposed(by: disposeBag)
        loadMoreSubject.subscribe(viewModel.input.loadMore)
            .disposed(by: disposeBag)
        pullToRefreshSubject.subscribe(viewModel.input.pullToRefresh)
            .disposed(by: disposeBag)
        
        
    }
    
    func obseverLoading() {
        viewModel.output.rx_isLoading.subscribe(onNext:{  (loading) in
            if loading == false {
                self.newsTableView.switchRefreshFooter(to: .normal)
             self.newsTableView.switchRefreshHeader(to: .normal(.success,0.0))
                
            }
        }).disposed(by: disposeBag)
        viewModel.output.windlessStart.subscribe(onNext:{  (loading) in
            if loading == true {
                self.startWindless()
            } else {
               self.newsTableView.windless.end()
            }
        }).disposed(by: disposeBag)
    }
    
}
