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
    @IBOutlet weak var textYourtime: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var LabelTime: UILabel!
    @IBOutlet weak var labelCreated: UILabel!
    override func viewDidLoad() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        super.viewDidLoad()
        currentWhaether(sity: cityName)
        var colorTop = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0).cgColor
        if (hour > 18){
            colorTop = UIColor(red: 255/255, green: 87/255, blue: 51/255, alpha: 1.0).cgColor
        }
        if (hour > 20){
            colorTop = UIColor(red: 40/255, green: 116/255, blue: 166/255, alpha: 1.0).cgColor

        }
        if (hour < 18){
            colorTop = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0).cgColor
        }
       
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
        self.labelCity.textColor = UIColor.white
        self.labelTemp.textColor = UIColor.white
        let grandientLayer = CAGradientLayer()
        grandientLayer.frame = self.view.bounds
        grandientLayer.colors = [colorTop, colorButton]
        self.mainView.layer.insertSublayer(grandientLayer, at: 0)
        self.textYourtime.textColor = UIColor.white
        self.labelCity.textColor = UIColor.black
        self.labelTemp.textColor = UIColor.black
        self.LabelTime.textColor = UIColor.white
        self.labelCreated.textColor = UIColor.black
        func currMinute() -> String{
            if(minutes < 10){
                return String(minutes) + "0"
            }
            else{
                return String(minutes)
            }
    }
        self.LabelTime.text = "\(hour) : " + currMinute()

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

