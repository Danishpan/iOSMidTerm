//
//  EditViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by Даир Алаев on 20.01.2021.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var idBox: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleBox: UITextField!
    @IBOutlet weak var subtitleBox: UITextField!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate:SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editItem(_ sender: Any) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateText = dateFormatter.string(from: datePicker.date)
        
        delegate?.editItem(Int(idBox.text ?? "") ?? 0, titleBox.text!, subtitleBox.text!, dateText, statusSwitch.isOn)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
