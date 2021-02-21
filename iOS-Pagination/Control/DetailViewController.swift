//
//  DetailViewController.swift
//  iOS-Pagination
//
//  Created by Lin Ting Chieh on 2021/2/16.
//

import UIKit

class DetailViewController: UIViewController {
    private let index: Int
    private let imageURL: String

    init(index: Int, image: Photo) {
        self.index = index
        self.imageURL = image.download_url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let label = UILabel()
        label.text = "\(index)"
        label.textColor = .black
        label.frame = CGRect(x: 150, y: 150, width: 100, height: 20)
        view.addSubview(label)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 450, width: 300, height: 300))
        imageView.imageFrom(URL(string: self.imageURL)!)
        view.addSubview(imageView)
    }
}

extension UIImageView {
    func imageFrom(_ url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                 if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         self?.image = image
                     }
                 }
            }
        }
    }
}
