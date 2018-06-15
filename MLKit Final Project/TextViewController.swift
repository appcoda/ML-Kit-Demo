//
//  TextViewController.swift
//  MLKit Starter Project
//
//  Created by Sai Kambampati on 5/20/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class TextViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultView: UITextView!
    let imagePicker = UIImagePickerController()
    lazy var vision = Vision.vision()
    var textDetector: VisionTextDetector?

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        textDetector = vision.textDetector()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            
            let visionImage = VisionImage(image: pickedImage)
            textDetector?.detect(in: visionImage, completion: { (features, error) in
                guard error == nil, let features = features, !features.isEmpty else {
                    self.resultView.text = "Could not recognize any text"
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                
                self.resultView.text = "Detected Text Has \(features.count) Blocks:\n\n"
                for block in features {
                    self.resultView.text = self.resultView.text + "\(block.text)\n\n"
                }
            })
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
