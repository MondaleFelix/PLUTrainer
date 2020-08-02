//
//  AddProduceViewController2.swift
//  PLUTrainer
//
//  Created by Cao Mai on 6/1/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class AddProduceViewController2: UIViewController {
    
    
    let produceImageView = UIImageView()
    let nameTextField = UITextField()
    let codeTextField =  UITextField()
    let imagePicker = UIImagePickerController()
    let saveButton = UIButton()
    
    var coreDataStack = CoreDataStack()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureStackView()
        UITextField.connectFields(fields: [nameTextField, codeTextField])

    }



    private func configure() {
        
        view.backgroundColor = .white
        produceImageView.translatesAutoresizingMaskIntoConstraints = false
        produceImageView.contentMode = .scaleAspectFit
        produceImageView.isUserInteractionEnabled = true
        produceImageView.image = UIImage(named: "no item image")
        
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Produce Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.tag = 0
        
        
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.borderStyle = .roundedRect
        codeTextField.placeholder = "PLU Code"
        codeTextField.tag = 1

        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.layer.cornerRadius = 7
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(selectImagePressed))
        produceImageView.addGestureRecognizer(singleTap)
    }
    
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [produceImageView, nameTextField, codeTextField, saveButton])

        stack.axis = .vertical
        stack.spacing = 20
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
        let newProduce = Produce(context: coreDataStack.managedContext)
        newProduce.name = nameTextField.text!
        newProduce.plu = codeTextField.text!
        newProduce.image = produceImageView.image?.pngData()
        coreDataStack.saveContext()
        navigationController?.popViewController(animated: true)
    }


    func resetUI() {
        nameTextField.text = ""
        codeTextField.text = ""
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

