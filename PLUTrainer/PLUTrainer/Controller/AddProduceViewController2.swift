//
//  AddProduceViewController2.swift
//  PLUTrainer
//
//  Created by Cao Mai on 6/1/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class AddProduceViewController2: UIViewController {
    
    var produceImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    var nameTextField = UITextField()
    var codeTextField = UITextField()
    var imagePickerButton = UIButton()
    var imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           UIView.setAnimationsEnabled(true)
    
       }
    
    func configure() {
        nameTextField.placeholder = "Produce Name"
        codeTextField.placeholder = "PLU Code"
        imagePickerButton.setTitle("Image Picker", for: .normal)
        imagePickerButton.backgroundColor = .blue
//        produceImageView.image = UIImage(named: "banana")
        imagePickerButton.addTarget(self, action: #selector(selectImagePressed), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [produceImageView, nameTextField, codeTextField, imagePickerButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        
        ])
        
    }
    
    @objc func selectImagePressed() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
}


    
extension AddProduceViewController2: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            produceImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    
}
