//
//  CountriesViewModel.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation
class CountriesViewModel {
    var isSuccess: Observable<Bool?> = Observable(nil)
    weak var dataSource = Observable<[CountriesModelElement]?>(nil)
//    init(dataSource : Observable<[CountriesModelElement]?>) {
//        self.dataSource = dataSource
//    }
    lazy var data = [CountriesModelElement?]()
    
    func fetchData(){
        URLCache.shared.removeAllCachedResponses()
        NetworkManager.shared.provider.request(.countries) { [weak self] result in

            guard let self = self else { return }
            DispatchQueue.main.async {
                 switch result {
                 case .success(let response):
                   do {
                    let result : [CountriesModelElement] = try JSONDecoder().decode([CountriesModelElement].self, from: response.data)
                       self.data = result
                       self.isSuccess.value = true                 
                   } catch {
                     print(error)
                       self.isSuccess.value = false
                   }
                 case .failure(let error):
                     print(error)
                     self.isSuccess.value = true

                 }
            }
        }
    }
    

}
