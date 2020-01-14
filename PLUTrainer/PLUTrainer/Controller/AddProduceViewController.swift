//
//  AddProduceViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/10/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class AddProduceViewController: UIViewController {
    
    
    let data = Quiz.sharedInstance
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var produceImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    

    override func viewDidLoad() {

        super.viewDidLoad()
        imagePicker.delegate = self

    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let name = nameTextField.text!
        let code = codeTextField.text!
        let image = produceImageView.image!
        
        let produce = Produce(image: image, name: name, plu: code)
        
        data.addProduce(produce)

        
    }
    
    @IBAction func selectImagePressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}
    
extension AddProduceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            produceImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
