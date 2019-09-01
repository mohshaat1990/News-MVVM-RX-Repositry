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
    // MARK: - UI
    @IBOutlet weak var newsTableView: UITableView!
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        viewModel = ViewModelType(newsService)
        configure(with: viewModel)
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
    
    private func initPullToRefresh()-> Observable<Void> {
        return Observable.create { observer in
            self.newsTableView.configRefreshHeader(container:self) {
            observer.onNext(())
        }
        return Disposables.create()
        }
    }
    
    private func initLoadMoreToRefresh()-> Observable<Void> {
        return Observable.create { observer in
            self.newsTableView.configRefreshFooter(container:self) {
                self.newsTableView.switchRefreshFooter(to: .refreshing)
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
    
    private func initLoad()-> Observable<Void> {
        return Observable.create { observer in
                observer.onNext(())
            return Disposables.create()
          }
        }
    

}
// MARK: - View Model Configure
extension NewsViewController: ControllerType {
    func configure(with viewModel: NewsViewModel) {
        obseverLoading(with: viewModel)
        bindViews(with: viewModel)
    }
    
    func bindViews(with viewModel: NewsViewModel) {
        viewModel.output.articles.bind(to: newsTableView.rx.items(cellIdentifier: HeadlineCell.getCellIdentifier(),
                                                                  cellType: HeadlineCell.self)) {  row, article, cell in
                                                                    cell.configure(data: article)
                                                                    
            }
            .disposed(by: disposeBag)
        initLoad().subscribe(viewModel.input.load)
            .disposed(by: disposeBag)
        initLoadMoreToRefresh().subscribe(viewModel.input.loadMore)
            .disposed(by: disposeBag)
        initPullToRefresh().subscribe(viewModel.input.pullToRefresh)
            .disposed(by: disposeBag)
        
        
    }
    
    func obseverLoading(with viewModel: NewsViewModel) {
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

