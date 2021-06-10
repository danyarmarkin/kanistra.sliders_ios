//
// Created by Данила Ярмаркин on 10.06.2021.
//

import Foundation
import Firebase
import UIKit

class RealtimeDatabase {
    var ref: DatabaseReference!
    func setRef(ref : DatabaseReference) {
        self.ref = ref
    }

    func set(path : String, data : Any) {
        ref.child(path).setValue(data)
    }

    func setListener(path : String, obj : Any, sliderLabel: UILabel) {
        if let slider = obj as? UISlider {
            ref.child(path).observe(DataEventType.value, with: { (snapshot) in
                if let val = snapshot.value as? Float {
                    slider.value = val
                    let color = UIColor(red: CGFloat(val), green: CGFloat(1 - val), blue: 0, alpha: 1)
                    slider.tintColor = color
                    sliderLabel.text = String(Int(round(val * 100)))

                }

            })
        } else if let label = obj as? UILabel {

        }
    }
}