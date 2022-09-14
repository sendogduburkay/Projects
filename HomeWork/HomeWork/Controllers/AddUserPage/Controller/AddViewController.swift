//
//  AddViewController.swift
//  HomeWork
//
//  Created by Muhammed Burkay Şendoğdu on 11.09.2022.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject{
    func didUserAddNewPerson(user: User)
    func didUserUpdateInformation(user: User, indexPath: IndexPath?)
}

class AddViewController: UIViewController {

    @IBOutlet var genderPickerView: UIPickerView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    var userStatus: UserStatus?
    var indexPath: IndexPath?
    var pickGenderFromPickerView: Gender = .Male
    weak var delegate: AddViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserStatus()
        setupGenderPickerView()
    }
}



// MARK: - AddViewController - Helper
extension AddViewController{
    
    func setupGenderPickerView(){
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
    }
    func checkUserStatus(){
        switch userStatus{
        case .registered(user: let user):
            [nameTextField, surnameTextField, genderTextField].forEach { textField in
                textField?.isUserInteractionEnabled = false
                textField?.backgroundColor = .lightGray
            }
            nameTextField.text = user.name
            surnameTextField.text = user.surname
            phoneTextField.text = user.phoneNumber
            genderTextField.text = user.gender.rawValue
            genderPickerView.isHidden = true
            saveButton.setTitle("Update", for: .normal)
        case .unregistered:
            genderTextField.isHidden = true
        default: break
        }
    }
}

// MARK: -  AddViewController - Action

extension AddViewController{
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let surname = surnameTextField.text,
              let phone = phoneTextField.text,
              !name.isEmpty,
              !surname.isEmpty,
              !phone.isEmpty else {
            fatalError("User can't save!")
        }
        let user = User(name: name, surname: surname, phoneNumber: phone, gender: pickGenderFromPickerView)
        
        switch userStatus{
        case .unregistered:
            delegate?.didUserAddNewPerson(user: user)
        case .registered:
            delegate?.didUserUpdateInformation(user: user, indexPath: indexPath)
        default: break
        }
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension AddViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender.allCases[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickGenderFromPickerView = Gender.allCases[row]
    }
}
