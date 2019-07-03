//
//  NewsTableViewController.swift
//  NewsReader
//
//  Created by User on 28/6/19.
//  Copyright © 2019 amagain. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {

    private var articleListVM: ArticleListViewModel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    private func populateNews() {
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] articleResponse in
                let articles = articleResponse?.articles
                self?.articleListVM = ArticleListViewModel(articles!)
                
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                
            }).disposed(by: disposeBag)
                
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell  else {
            fatalError("Cell Doesn't Exist")
        }
        let articleVM = self.articleListVM.articleAt(indexPath.row)
    
        articleVM.title.asDriver(onErrorJustReturn: "")
        .drive(cell.titleLabel.rx.text)
        .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
        .disposed(by: disposeBag)
        
        return cell
    }
        
}
