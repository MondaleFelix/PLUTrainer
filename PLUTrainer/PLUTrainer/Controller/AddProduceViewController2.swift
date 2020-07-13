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
    var saveButton = UIButton()
    var coreDataStack = CoreDataStack()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    
    
    func configure() {
        self.nameTextField.placeholder = "Produce Name"
        self.codeTextField.placeholder = "PLU Code"
        self.imagePickerButton.setTitle("Image Picker", for: .normal)
        self.imagePickerButton.backgroundColor = .blue
        self.saveButton.setTitle("SAVE", for: .normal)
        self.saveButton.backgroundColor = .orange
        self.imagePickerButton.addTarget(self, action: #selector(selectImagePressed), for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [produceImageView, nameTextField, codeTextField, imagePickerButton, saveButton])
        
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
    
    @objc func saveButtonPressed() {
        let newProduce = Produce(context: self.coreDataStack.managedContext)
        newProduce.name = self.nameTextField.text!
        newProduce.plu = self.codeTextField.text!
        newProduce.image = self.produceImageView.image?.pngData()
        self.coreDataStack.saveContext()
        self.alert()
        self.resetUI()
    }
    
    func alert() {
        let alert = UIAlertController(title: "Saved", message: "Produce saved successfully!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

