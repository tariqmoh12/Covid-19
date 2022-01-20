//
//  CountryTrackingDataSource.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/10/22.
//

import Foundation
import UIKit
class StatisticsDataSource : NSObject, UITableViewDataSource , UITableViewDelegate{
    
    var data = Observable<StatisticsModel?>(nil)
    private let tableView: UITableView
    private let identifier = "CountryStatisticsTableViewCell"
    var isSubmitBtnEnable = Observable<Bool>(false)
    lazy var Names = ["Today Confirmed","Today Deaths","Today new confirmed","Today new deaths","Today new open cases","Today new recovered"]
    lazy var values = [Int]()

    private let Vc : StatisticsVc
    
    init(_ viewController : StatisticsVc ,_ tableView: UITableView) {
         self.tableView = tableView
         self.Vc = viewController
         super.init()
         setup()
         registerCells()
     }
    


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let countriesCount = data.value?.dates?.the20220108?.countries?.country. else { return 0}
        return 6
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryStatisticsTableViewCell", for: indexPath) as! CountryStatisticsTableViewCell
        if let value = data.value?.total{

        switch indexPath.row{
        case 0 :
            
            cell.valueLabel.text = "\(Names[indexPath.row]) : \((value.todayConfirmed))"
        case 1 :
            cell.valueLabel.text = "\(Names[indexPath.row]) : \(value.todayDeaths)"
        case 2 :
            cell.valueLabel.text = "\(Names[indexPath.row]) : \(value.todayNewConfirmed)"
        case 3 :
            cell.valueLabel.text = "\(Names[indexPath.row]) : \(value.todayNewDeaths)"
        case 4 :
            cell.valueLabel.text = "\(Names[indexPath.row]) : \(value.todayNewOpenCases)"
        case 5:
            cell.valueLabel.text = "\(Names[indexPath.row]) : \(value.todayNewRecovered)"
        default:
            break
            
        }
        }
//        guard let articleModel = data.value?.total else { return UITableViewCell()}
//        cell.model = data.value?
        return cell
    }
    
}

private extension StatisticsDataSource {
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
    }
}

private extension StatisticsDataSource {
    func registerCells(){
        //registerCells
        self.tableView.register(UINib(nibName: "CountryStatisticsTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryStatisticsTableViewCell")
    }
}


