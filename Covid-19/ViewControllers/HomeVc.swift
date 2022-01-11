//
//  ViewController.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import UIKit
import GoogleMaps
class HomeVc: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var selectCountryTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    
    // MARK: - Variables
    lazy var mapFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: self.view.frame.height - 155 )
    lazy var latLng = [Double]()
     var statisticsArr : StatisticsModel?
    let datePicker = UIDatePicker()
    let picker = UIPickerView()
    var countryNames = [String]()
    var data = [CountriesModelElement?]()
    var selectedIndex = 0
 
    // MARK: - Storyboard instance
    static func storyboardInstance() -> HomeVc? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeVc") as? HomeVc
    }
    
    private lazy var viewModel : CountriesViewModel = {
        let viewModel = CountriesViewModel()
        return viewModel
    }()
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
        self.showSpinner(onView: self.view)
        }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCountriesData()
        viewModel.fetchData()
           }
    

    private func setUpViews(){
        bottomStackView.backgroundColor = .white
        bottomStackView.spacing = 10
        
        selectCountryTextField.layer.cornerRadius = 10
        selectCountryTextField.layer.borderWidth = 1
        selectCountryTextField.layer.borderColor = UIColor.black.cgColor
        
        fromDateTextField.layer.cornerRadius = 10
        fromDateTextField.layer.borderWidth = 1
        fromDateTextField.layer.borderColor = UIColor.black.cgColor
        
        toDateTextField.layer.cornerRadius = 10
        toDateTextField.layer.borderWidth = 1
        toDateTextField.layer.borderColor = UIColor.black.cgColor
        
        self.view.backgroundColor = .white
        showDatePicker()
        showPickerView()
    }
   
    func showPickerView(){
        picker.translatesAutoresizingMaskIntoConstraints = false
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneCountryPicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        selectCountryTextField.inputAccessoryView = toolbar
        selectCountryTextField.inputView = picker
        view.addSubview(picker)
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 130)

       }
    
        func showDatePicker(){
            datePicker.datePickerMode = .date
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
            
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            fromDateTextField.inputAccessoryView = toolbar
            fromDateTextField.inputView = datePicker
            toDateTextField.inputAccessoryView = toolbar
            toDateTextField.inputView = datePicker
            datePicker.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 130)
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
             }
        
    }
    
        @objc func cancelDatePicker(){
            self.view.endEditing(true)
        }
        
        @objc func donedatePicker(){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if fromDateTextField.isEditing{
                self.fromDateTextField.text = formatter.string(from: datePicker.date)
            }else{
                self.toDateTextField.text = formatter.string(from: datePicker.date)
            }
            self.view.endEditing(true)
        }
        
        @objc func doneCountryPicker(){
            self.view.endEditing(true)
        }
    
    private func getWorldMap(latLng : [CountriesModelElement?]){
        GMSServices.provideAPIKey("AIzaSyBMUEMJ9h3OzsXth5gOM-Uzj9RpZnNqFBw")
        let camera = GMSCameraPosition.camera(withLatitude: 31.963158, longitude: 35.930359, zoom: 0.0)
        let mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        self.view.addSubview(mapView)
        mapView.delegate = self
        var chunkedArr = latLng.compactMap{$0?.latlng}
        var i = 1
        
        for country in chunkedArr {
            self.countryNames.append(latLng[i]?.name ?? "")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: country[0] ?? 0, longitude: country[1] ?? 0)
            marker.title = latLng[i]?.name
            marker.map = mapView
              i += 1
        }
        self.removeSpinner()
    }
    
    @IBAction func showStatistics(_ sender: Any) {
        if self.validateCountry() && validateToDate() && validateFromDate() {

        guard let StatisticsVc = StatisticsVc.storyboardInstance() else { return}
        StatisticsVc.countryName = selectCountryTextField.text ?? ""
        StatisticsVc.fromDate = fromDateTextField.text ?? ""
        StatisticsVc.toDate = toDateTextField.text ?? ""
        StatisticsVc.countryImageString = data[selectedIndex + 1]?.flags?.png ?? ""

        self.present(StatisticsVc, animated: true, completion: nil)
        }else{
            self.presentAlert(withTitle: "", message: "Please Select All Fields")
        }
    }
    
    @IBAction func showNews(_ sender: Any) {
        if self.validateCountry() && validateToDate() && validateFromDate() {
            guard let newsvc = NewsVc.storyboardInstance() else { return}
            newsvc.countryName = self.selectCountryTextField.text ?? ""
            newsvc.countryImageString = data[selectedIndex + 1]?.flags?.png ?? ""
            newsvc.countryCode =  data[selectedIndex + 1]?.alpha2Code?.lowercased() ?? ""
            self.present(newsvc, animated: true, completion: nil)
        }else{
            self.presentAlert(withTitle: "", message: "Please Select All Fields")
        }
       
    }
}

    
// MARK: - binding Extension
extension HomeVc{
       private func bindCountriesData() {
            viewModel.isSuccess.bind { [weak self] bool in
                guard let self = self else { return }
                guard let bool = bool else {return}
                if bool {
                    self.data = self.viewModel.data
                    self.getWorldMap(latLng: self.viewModel.data)
                }else{
                    self.presentAlert(withTitle: "", message: "Something went wrong!")
                }
                self.removeSpinner()

              }
           
        }
}

// MARK: - Maps Delegate Extension
extension HomeVc: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
       
    }
}

// MARK: - PickerView Delegates Extension
extension HomeVc : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryNames.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectCountryTextField.text = countryNames[row]
      
        selectedIndex = row
    }
}

// MARK: - Validations Extension
extension HomeVc {
    func validateCountry()->Bool{
        if selectCountryTextField.text != "Select Country"{
            return true
        }
        return false
    }
    func validateFromDate()-> Bool{
        if fromDateTextField.text != "From Date :"{
            return true
        }
        return false
    }
    func validateToDate()-> Bool{
        if toDateTextField.text != "To Date :"{
            return true
        }
        return false
    }
}
