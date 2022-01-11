//
//  NewsDataSource.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation
import UIKit
class ArticlesDataSource : NSObject, UITableViewDataSource , UITableViewDelegate{
    
    var data = Observable<ArticlesModel?>(nil)
    private let tableView: UITableView
    private let identifier = "ArticlesTableViewCell"
    var isSubmitBtnEnable = Observable<Bool>(false)
    private let Vc : NewsVc
    
    init(_ viewController : NewsVc ,_ tableView: UITableView) {
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
        guard let articlesCount = data.value?.articles?.count else { return 0}
        return articlesCount
           }
  
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        guard let articleModel = data.value?.articles?[indexPath.row] else { return UITableViewCell()}
        cell.model = articleModel
        return cell
    }
}

private extension ArticlesDataSource {
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
    }
}

private extension ArticlesDataSource {
    func registerCells(){
        //registerCells
        self.tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticlesTableViewCell")
    }
}


