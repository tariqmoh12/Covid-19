//
//  ArticlesViewModel.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation
class ArticlesViewModel {
    
    var isSuccess: Observable<Bool?> = Observable(nil)
    weak var dataSource = Observable<ArticlesModel?>(nil)
    
    init(dataSource : Observable<ArticlesModel?>) {
        self.dataSource = dataSource
    }
    
    func fetchData(country : String){
        URLCache.shared.removeAllCachedResponses()
        NetworkManager.shared.provider.request(.articles(country: country)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                 switch result {
                 case .success(let response):
                   do {
                    let result : ArticlesModel = try JSONDecoder().decode(ArticlesModel.self, from: response.data)
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
