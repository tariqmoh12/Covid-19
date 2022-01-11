//
//  NewsVc.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import UIKit
import SDWebImage

class NewsVc: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var dismissButton: UIImageView!
    
    // MARK: - Variables
    lazy var countryImageString = ""
    lazy var countryName = ""
    lazy var countryCode = ""

    
    // MARK: - Storyboard instance
    static func storyboardInstance() -> NewsVc? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NewsVc") as? NewsVc
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var artistNewsListDataSource = ArticlesDataSource(self, tableView)

    private lazy var viewModel : ArticlesViewModel = {
        let viewModel = ArticlesViewModel(dataSource: artistNewsListDataSource.data)
        return viewModel
    }()

    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
        self.showSpinner(onView: self.view)
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        viewModel.fetchData(country: countryCode)
    }
    
    private func setUpViews(){
        self.view.backgroundColor = .black
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
        countryNameLabel.textColor = .white
        self.countryImageView.sd_setImage(with: URL(string: countryImageString), placeholderImage: UIImage(named: "placeholder"))
        self.countryNameLabel.text = countryName
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissTapped(tapGestureRecognizer:)))
         dismissButton.isUserInteractionEnabled = true
        dismissButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
 
    
    
    func bindData(){
        viewModel.isSuccess.bind { [weak self] bool in
            guard let self = self else { return }
            guard let bool = bool else {return}
            if !bool {
                self.presentAlert(withTitle: "", message: "Something went wrong!")
            }
            self.removeSpinner()

          }

        viewModel.dataSource?.bind{[weak self] data in
            guard let self = self else { return }
            guard let data = data else { return}
            self.removeSpinner()
            self.tableView.reloadData()
            
        }
    }

  
}

private extension NewsVc{
    @objc func dismissTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
