//
//  NewsViewController.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/24.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

final class NewsViewController: UIViewController {
    private enum Content {
        static let heightForTableViewCell: CGFloat = 140.0
    }
    @IBOutlet weak private var tableView: UITableView!
    private let viewModel: NewsViewModel = NewsViewModel()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellID: String = "NewTableViewCell"
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.delegate = self
        viewModel.loadData(ArticleModel.self)
            .catch({ (error) -> Observable<[ArticleModel]> in
                print(error.localizedDescription)
                return Observable.empty()
            }).bind(to: tableView.rx.items(cellIdentifier: cellID, cellType: NewTableViewCell.self)) { (_, element, cell) in
                cell.setCell(element)
             }.disposed(by: disposeBag)
    }
}
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Content.heightForTableViewCell
    }
}
