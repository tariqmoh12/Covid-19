//
//  StatisticsVc.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/10/22.
//

import UIKit

class StatisticsVc: UIViewController  {
    
    // MARK: - Outlets
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var dismissButton: UIImageView!
    
    // MARK: - Variables
    lazy var flagUrl = ""
    lazy var countryName = ""
    lazy var fromDate = ""
    lazy var toDate = ""
    lazy var countryImageString = ""
    
    // MARK: - Storyboard instance
    static func storyboardInstance() -> StatisticsVc? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "StatisticsVc") as? StatisticsVc
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var statisticsDataSource = StatisticsDataSource(self, tableView)

    private lazy var viewModel : StatisticsViewModel = {
        let viewModel = StatisticsViewModel(dataSource: statisticsDataSource.data)
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
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.bindTrackingData()
            self.viewModel.fetchData(countryName: self.countryName, fromDate: self.fromDate, toDate: self.toDate)
        })
       
       
    }
    
    private func setUpViews(){
        self.view.backgroundColor = .black
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.countryNameLabel.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissTapped(tapGestureRecognizer:)))
         dismissButton.isUserInteractionEnabled = true
        dismissButton.addGestureRecognizer(tapGestureRecognizer)
        
        self.countryFlagImageView.sd_setImage(with: URL(string: countryImageString), placeholderImage: UIImage(named: "placeholder"))
        self.countryNameLabel.text = "\(countryName) Statistics"

    }
    
   private func bindTrackingData(){
       
       viewModel.isSuccess.bind { [weak self] bool in
           guard let self = self else { return }
           guard let bool = bool else {return}
           if !bool {
               self.presentAlert(withTitle: "", message: "Something went wrong!")
           }

         }
        viewModel.dataSource?.bind{[weak self] data in
            guard let self = self else { return }
            guard let data = data else { return}
            self.removeSpinner()
            self.tableView.reloadData()
        }
    }

}
private extension StatisticsVc{
    @objc func dismissTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
