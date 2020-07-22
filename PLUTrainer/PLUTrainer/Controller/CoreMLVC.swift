//
//  CoreMLVC.swift
//  PLUTrainer
//
//  Created by Cao Mai on 7/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import CoreData
import CoreML
import Vision

class CoreMLVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let coreDataStack = CoreDataStack()
    
    let produceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupImage()
    }
    
    @objc func cameraButtonTapped(){
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func configureNavBar() {
        self.title = "CORE ML"
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonTapped))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupImage() {
        view.addSubview(produceImage)
        
        NSLayoutConstraint.activate([
            produceImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            produceImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            produceImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            produceImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            produceImage.image = image
            imagePicker.dismiss(animated: true, completion: nil)
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            detect(image: ciImage)
        }
    }
    
    private func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            let confidencePercentage = formatter.string(from: results.first!.confidence * 100 as NSNumber)!
            
            self.imageResultAlert(name: topResult.identifier.capitalized, confidence: confidencePercentage)
            
            self.navigationController?.navigationBar.barTintColor = UIColor.green
            self.navigationItem.title = "\(confidencePercentage)% \(results.first!.identifier.capitalized)"
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    private func imageResultAlert(name: String, confidence: String) {
        let plu = getPLUCodeFromCoreData(for: name)
        var pluCode = ""
        if plu != nil {
            pluCode = plu!
        } else {
            pluCode = "Not found in database"
        }
        
        let alert = UIAlertController(title: "Top ML Match", message: "\(name) \(confidence)% \n PLU: \(pluCode)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getPLUCodeFromCoreData(for produceName: String) -> String? {
        let request: NSFetchRequest<Produce> = Produce.fetchRequest()
        request.predicate = NSPredicate(format: "( name contains[cd] %@ )", produceName)
        do {
            let fetchResults = try coreDataStack.managedContext.fetch(request)
            if fetchResults == [] {
                return nil
            }else {
                return fetchResults.first?.plu
            }
        } catch {
            print("error fetching")
        }
        
        return nil
    }
    
    
}
