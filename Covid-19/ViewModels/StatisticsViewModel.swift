//
//  TrackingViewModel.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation
class StatisticsViewModel {
    
    var isSuccess: Observable<Bool?> = Observable(nil)
    var data : StatisticsModel?
    weak var dataSource = Observable<StatisticsModel?>(nil)
    
    init(dataSource : Observable<StatisticsModel?>) {
        self.dataSource = dataSource
    }
    
    func fetchData(countryName : String, fromDate : String, toDate : String){
        URLCache.shared.removeAllCachedResponses()
        NetworkManager.shared.provider.request(.tracking(name: countryName, fromDate: fromDate, toDate: toDate)) { [weak self] result in

            guard let self = self else { return }
            DispatchQueue.main.async {
                 switch result {
                 case .success(let response):
                   do {
                    let result : StatisticsModel = try JSONDecoder().decode(StatisticsModel.self, from: response.data)
//                       self.data = result
                       self.dataSource?.value = result
                       self.isSuccess.value = true                 
                   } catch {
                       self.isSuccess.value = false
                     print(error)
                   }
                 case .failure(let error):
                     self.isSuccess.value = false
                     print(error)
                 }
            }
        }
    }
    

}
