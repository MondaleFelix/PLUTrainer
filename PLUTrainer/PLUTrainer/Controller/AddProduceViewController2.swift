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
        image.image = UIImage(named: "no item image")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        //        image.layer.borderColor = UIColor.color(red: 123, green: 12, blue: 12)?.cgColor
        //        image.layer.borderWidth = 5
//        image.layer.cornerRadius = 75
        image.layer.masksToBounds = true
        image.backgroundColor = .gray
        
        return image
    }()
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Produce Name"
        textField.borderStyle = .roundedRect
        textField.tag = 0
        //        textField.keyboardType = .default //keyboard type
        
        return textField
    }()
    var codeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "PLU Code"
        textField.tag = 1
        return textField
    }()
    var imagePickerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.setTitle("Select Image", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    var imagePicker = UIImagePickerController()
    var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    var coreDataStack = CoreDataStack()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white
        
        UITextField.connectFields(fields: [nameTextField, codeTextField])

        // Do any additional setup after loading the view.
    }
    
    
    
    func configure() {
//        self.nameTextField.placeholder = "Produce Name"
//        self.codeTextField.placeholder = "PLU Code"


        self.imagePickerButton.addTarget(self, action: #selector(selectImagePressed), for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        self.view.addSubview(produceImageView)
        self.view.addSubview(imagePickerButton)
        self.view.addSubview(nameTextField)
        self.view.addSubview(codeTextField)
        self.view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            self.produceImageView.widthAnchor.constraint(equalToConstant: 200),
            self.produceImageView.heightAnchor.constraint(equalToConstant: 200),
            self.produceImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.produceImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)

        ])
        
        NSLayoutConstraint.activate([
            self.imagePickerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imagePickerButton.topAnchor.constraint(equalTo: produceImageView.bottomAnchor, constant: 30),
            self.imagePickerButton.widthAnchor.constraint(equalToConstant: 120),
            self.nameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.nameTextField.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 30),
            self.codeTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.codeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            self.saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.saveButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 60),
            self.saveButton.widthAnchor.constraint(equalToConstant: 180)
            
        ])
        
        
        
//
//        let stack = UIStackView(arrangedSubviews: [produceImageView, nameTextField, codeTextField, imagePickerButton, saveButton])
        
//        stack.axis = .vertical
//        stack.spacing = 20
//        stack.distribution = .fillProportionally
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stack)

//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
//
//        ])
        
    }
    
    @objc func selectImagePressed() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveButtonPressed() {
        let newProduce = Produce(context: self.coreDataStack.managedContext)
        newProduce.name = self.nameTextField.text!
        newProduce.plu = self.codeTextField.text!
        newProduce.image = self.produceImageView.image?.pngData()
        self.coreDataStack.saveContext()
//        self.resetUI()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func resetUI() {
        self.nameTextField.text = ""
        self.codeTextField.text = ""
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

