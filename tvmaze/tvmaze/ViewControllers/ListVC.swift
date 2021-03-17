//
//  ListVC.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 07/03/2021.
//

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate static let cellID = "ListViewCell"
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
    }

    func setupTableView() {
        tableView.register(UINib.init(nibName: String(describing: ListViewCell.self), bundle: nil), forCellReuseIdentifier: ListVC.cellID)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func fetchData() {
        //FIXME: Show progress animation...
        isLoadingList = true
        Service.shared.fetchFirtsTvShows { (tvShows) in
            self.tvShowItems = tvShows?.map({return TvShowViewModel(tvShow: $0)}) ?? []
            self.reloadData()
        } failure: { (error) in
            if let error = error {
                print("Failed to get tvshows:", error)
                //FIXME: show error alert
            }
            self.isLoadingList = false
            return
        }
    }
    
    fileprivate func fetchMoreData() {
        self.isLoadingList = true
        print("DEBUG Loading More...")
        Service.shared.fetchNextTvShows { (tvShows) in
            print("DEBUG Items: \(self.tvShowItems.count)")
            let moreTvShowItems = tvShows?.map({return TvShowViewModel(tvShow: $0)}) ?? []
            self.tvShowItems.append(contentsOf: moreTvShowItems)
            print("DEBUGItems: \(self.tvShowItems.count)")
            self.actualPageLoaded += 1
            self.reloadData()
        } failure: { (error) in
            if let error = error {
                print("Failed to get more tvshows:", error)
                //FIXME: show error alert
            }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tvShowItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCandidate = tableView.dequeueReusableCell(withIdentifier: ListVC.cellID, for: indexPath)
        guard let cell = cellCandidate as? ListViewCell else {
            return UITableViewCell()
        }
        let tvShowViewModel = self.tvShowItems[indexPath.row]
        cell.tvShowViewModel = tvShowViewModel
        
        return cell
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

