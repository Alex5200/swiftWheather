//
//  detailMVC.swift
//  swift_Wheather
//
//  Created by user on 23.09.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailMVC: UIViewController {
    var cityName = ""
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWhaether(sity: cityName)

        let colorTop = UIColor(red: 89/255, green: 156/255, blue: 169/255, alpha: 1.0).cgColor
        let colorButton = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor

        ///
        subView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        subView.layer.cornerRadius = 30
        // 2
        let blurEffect = UIBlurEffect(style: .dark)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        subView.insertSubview(blurView, at: 1)
        ///
        let grandientLayer = CAGradientLayer()
        grandientLayer.frame = self.view.bounds
        grandientLayer.colors = [colorTop, colorButton]
        self.mainView.layer.insertSublayer(grandientLayer, at: 0)
        self.labelCity.textColor = UIColor.black
        self.labelTemp.textColor = UIColor.black
    }
    
    
    func currentWhaether(sity: String){
        let url = "http://api.weatherapi.com/v1/current.json?key=7a4e32ed26e341f894370054212309&q=\(sity)"
        AF.request(url, method: .get).validate().responseJSON{response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let name = json["location"]["name"].stringValue
                    let temp = json["current"]["temp_c"].stringValue
                    self.labelCity.text = (name)
                    self.labelTemp.text = (temp + " C")
                    case .failure(let error):
                    print(error)
                
            }
            
        }
    }

}
