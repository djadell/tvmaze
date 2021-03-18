//
//  ListVC.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 07/03/2021.
//

import UIKit

class ListVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate static let cellID = "ListTVC"
    fileprivate static let loadingCellID = "LoadingTVC"
    fileprivate var isFirstLoadingList: Bool = false
    fileprivate var isLoadingList: Bool = false
    fileprivate var tvShowItems = [TvShowViewModel]()
    fileprivate let titlePage = "Tv show list"
    fileprivate var actualPageLoaded = 1
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titlePage
        setupTableView()
        fetchData()
        
        ListVM.shared.netStatusChangeHandler = {
            DispatchQueue.main.async { [unowned self] in
                if self.isFirstLoadingList {
                    fetchData()
                } else {
                    self.reloadData()
                }
            }
        }
    }

    func setupTableView() {
        tableView.register(UINib.init(nibName: String(describing: ListTVC.self), bundle: nil), forCellReuseIdentifier: ListVC.cellID)
        tableView.register(UINib.init(nibName: String(describing: LoadingTVC.self), bundle: nil), forCellReuseIdentifier: ListVC.loadingCellID)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func fetchData() {
        showProgress(text: "Loading...")
        isFirstLoadingList = true
        isLoadingList = true
        ListVM.shared.fetchFirtsTvShows { (tvShows) in
            self.tvShowItems = tvShows?.map({return TvShowViewModel(tvShow: $0)}) ?? []
            self.reloadData()
            self.isFirstLoadingList = false
            self.hideProgress()
        } failure: { (error) in
            self.hideProgress()
            self.showAler(title: "Error", message: error?.localizedDescription)
            self.isLoadingList = false
            return
        }
    }
    
    fileprivate func fetchMoreData() {
        self.isLoadingList = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        ListVM.shared.fetchNextTvShows { (tvShows) in
            let moreTvShowItems = tvShows?.map({return TvShowViewModel(tvShow: $0)}) ?? []
            self.tvShowItems.append(contentsOf: moreTvShowItems)
            self.actualPageLoaded += 1
            self.reloadData()
        } failure: { (error) in
            self.showAler(title: "Error", message: error?.localizedDescription)
            self.isLoadingList = false
            return
        }

    }
    
    fileprivate func reloadData() {
        title = "\(titlePage)  - Page: \(actualPageLoaded)"
        self.tableView.reloadData()
        self.isLoadingList = false
    }
}

extension ListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.tvShowItems.count
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cellCandidate = tableView.dequeueReusableCell(withIdentifier: ListVC.cellID, for: indexPath)
            guard let cell = cellCandidate as? ListTVC else {
                return UITableViewCell()
            }
            let tvShowViewModel = self.tvShowItems[indexPath.row]
            cell.tvShowViewModel = tvShowViewModel
            return cell
        } else {
            let cellCandidate = tableView.dequeueReusableCell(withIdentifier: ListVC.loadingCellID, for: indexPath)
            guard let cell = cellCandidate as? LoadingTVC else {
                return UITableViewCell()
            }
            cell.spinner.startAnimating()
            return cell
        }
    }
}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "detailvc") as? DetailVC {
            let tvShowViewModel = self.tvShowItems[indexPath.row]
            vc.tvShowViewModel = tvShowViewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.fetchMoreData()
        }
    }
}

