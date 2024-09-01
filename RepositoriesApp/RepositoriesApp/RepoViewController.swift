//
//  RepoViewController.swift
//  RepositoriesApp
//
//  Created by Mariam Abdelhamid on 8/31/24.
//

import UIKit
import RxSwift
import RxCocoa


class RepoViewController: UIViewController {

    @IBOutlet private weak var searchRepo: UISearchBar!
    @IBOutlet private weak var repoTableView: UITableView!
    
    var viewModel : RepoViewModel?
    let disposeBag = DisposeBag()
    var items: [Item] = [] {
        didSet {
            if items.count == 0 {
                repoTableView.isHidden = true
            } else {
                repoTableView.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RepoViewModel(repoServiceApi: RepoServiceApi())
        bindData()
    }

    func bindData() {
        self.viewModel?.repoItems
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.items = value
                self?.repoTableView.reloadData()
            }).disposed(by: disposeBag)
        
        self.viewModel?.errorHandling
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.showAlert(for: value)
                self?.items = []
                self?.repoTableView.reloadData()
            }).disposed(by: disposeBag)
        
        searchRepo.rx.text
                    .orEmpty
                    .distinctUntilChanged()
                    .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
                    .subscribe(onNext: { [weak self] searchText in
                        if searchText.isEmpty {
                            self?.items = []
                            self?.repoTableView.reloadData()
                        } else {
                            self?.viewModel?.getRepoData(searchText: searchText)
                        }
                    })
                    .disposed(by: disposeBag)
    
    }
    
    func showAlert(for error: Error) {
        var message: String
        
        if let customError = error as? RepoError {
            switch customError {
            case .badUrl:
                message = "The URL provided is invalid. Please check the URL and try again."
            case .badServerResponse:
                message = "The server response was not as expected. Please try again later."
            case .failedFetchData:
                message = "Failed to fetch data. Please check your internet connection or try again later."
            }
        } else {
            message = error.localizedDescription
        }
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension RepoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setCell(item: items[indexPath.row])
        return cell
    }
}
