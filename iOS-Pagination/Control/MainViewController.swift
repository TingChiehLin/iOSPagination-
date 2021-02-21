//
//  ViewController.swift
//  iOS-Pagination
//
//  Created by Lin Ting Chieh on 2021/2/15.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var fetchDataManager = FetchDataManager()
    var currentPage = 0
    var pageNumber = 0
    
    private var photosList: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellIdentifier)
        currentPage = pageNumber
        fetchDataManager.delegate = self
        fetchDataManager.fetchData(currentPage)
    }
    
}

//MARK: - Spiner
private func createSpinerFooter() -> UIView {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let spinner = UIActivityIndicatorView()
    footerView.addSubview(spinner)
    return footerView
}

//MARK: - DataManagerDelegate
extension MainViewController: DataManagerDelegate {
    
    func didUpdatePhoto(photo: [Photo]) {
        self.photosList = photo
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            let photo = self.photosList[indexPath.row]
            cell.textLabel?.text = photo.author
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let detailVcontroller = DetailViewController(index: indexPath.row, image: photosList[indexPath.row])
        guard let nav = navigationController else {
           return
        }
        nav.pushViewController(detailVcontroller, animated: true)
        
    }
}



