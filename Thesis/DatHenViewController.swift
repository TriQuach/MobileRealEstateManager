//
//  DatHenViewController.swift
//  Thesis
//
//  Created by Tri Quach on 6/7/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import DateTimePicker
class DatHenViewController: UIViewController {

    @IBOutlet weak var lblTime: UILabel!
    var idUser:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("idUser new" + String(idUser))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnPickTime(_ sender: Any) {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        
        picker.completionHandler = { date in
            // do something after tapping done
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            self.lblTime.text = formatter.string(from: date)
        }
    }
}
