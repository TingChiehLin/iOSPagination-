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
    let limitNumber: Int = 20
    var totalPhotos: Int = 0
    var pageNumber = 0
    
    private var photosList: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        fetchDataManager.delegate = self
        fetchDataManager.fetchData(pageNumber)
    }
}
//MARK: - DataManagerDelegate
extension MainViewController: DataManagerDelegate {
    
    func didUpdatePhoto(photo: DataFormat) {
        photosList.append(photo)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return photosList.count;
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        DispatchQueue.main.async {
            cell.textLabel?.text = "test"
        }
        return cell
    }
}
//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}



