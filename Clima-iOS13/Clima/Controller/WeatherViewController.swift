
import UIKit
import CoreLocation


class WeatherViewController: UIViewController{

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager  = WeatherManager()
    let locationManager = CLLocationManager() /* responsible for getting hold of the current GPS location of the phone.*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self /*requestLocationdan sonra çağırırsan crash yersin.*/
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() /* bir kereliğine mevcut konumu teslim edilmesini ister. Eğer bunun gibi durağan bir program yerine uygulamayı kullandıkları süre boyunca adım adım konum verilerine ihtiyaç duyduğunuz bir navigasyon uygulaması veya fitness uygulaması var ise startUpdatingLocation() kullanılmalıdır. Sürekli bize rapor atar.*/
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    

    
    
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    /* Klavye açıldığında return tuşuna basıldığında işlem yapmasını sağlıyoruz.*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    /*TextField'ın içine bir şey yazmadığımız sürece didEndEditing func çalışmayacaktır. */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            searchTextField.placeholder = "Type Something"
            return false
            
        }
    }
    /*Editleme yani yazma işlemleri bitip de geçmek için butona bastığımızda textField'ın içini boşaltır. */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text?.lowercased(){
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
    }
    
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /* last deme sebebimiz mevcut konumu alırken en doğru hale gelene kadar birkaç konum alabiliyor.Last ile en son ve en doğru konumu alabiliyoruz. */
        if let location = locations.first{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
