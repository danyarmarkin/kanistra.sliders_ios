//
//  ViewController.swift
//  test2
//
//  Created by Данила Ярмаркин on 09.06.2021.
//

import UIKit
import Firebase
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var ref: DatabaseReference!
    var v = 1
    let changing = false
    let db = Firestore.firestore()
    var locationManager: CLLocationManager!
    var realtimeDatabase: RealtimeDatabase!
    @IBOutlet weak var slider: UISlider!

    @IBOutlet weak var sliderLabel: UILabel!
    let SLIDER_VALUE_ID = "sliderValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // compass init
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()

        // realtime database init
        ref = Database.database(url: "https://test-firebase-4e1b8-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        realtimeDatabase = RealtimeDatabase()
        realtimeDatabase.setRef(ref: ref)
        realtimeDatabase.setListener(path: SLIDER_VALUE_ID, obj: slider, sliderLabel: sliderLabel)


    }
    @IBAction func send(_ sender: Any) {
        v += 1
        v %= 10
        realtimeDatabase.set(path: "h", data: v)
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
       realtimeDatabase.set(path: SLIDER_VALUE_ID, data: sender.value)
    }

    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        print(newHeading.magneticHeading)
    }


}

