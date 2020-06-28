//
//  AddProduceViewController.swift
//  PLUTrainer
//
//  Created by Mondale on 1/10/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class AddProduceViewController: UIViewController {
    
    
//    let data = ProduceList.sharedInstance
//    let quizList = Quiz.sharedInstance
    var imagePicker = UIImagePickerController()
    
    var produceImageView =  UIImageView()
    var nameTextField =  UITextField()
    var codeTextField = UITextField()
    var stackView = UIStackView()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
    }
    
    
    private func configure(){
        nameTextField.text = "Testing"
        codeTextField.text = "Code testing"
        print(stackView.arrangedSubviews)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
  
        
        ])
        
        

    }
    

//    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
//        
//        let name = nameTextField.text!
//        let code = codeTextField.text!
//        let image = produceImageView.image!
//        
//        let produce = Produce(image: image, name: name, plu: code)
//        
//        data.addProduce(produce)
//        quizList.addProduce(produce)
//        self.dismiss(animated: true, completion: nil)
//    }
    
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
