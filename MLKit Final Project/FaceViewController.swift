//
//  FaceViewController.swift
//  MLKit Starter Project
//
//  Created by Sai Kambampati on 5/20/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class FaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultView: UITextView!
    let imagePicker = UIImagePickerController()
    let options = VisionFaceDetectorOptions()
    lazy var vision = Vision.vision()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        options.modeType = .accurate
        options.landmarkType = .all
        options.classificationType = .all
        options.minFaceSize = CGFloat(0.1)
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
            
            let faceDetector = vision.faceDetector(options: options)
            let visionImage = VisionImage(image: pickedImage)
            
            self.resultView.text = ""
            faceDetector.detect(in: visionImage) { (faces, error) in
                guard error == nil, let faces = faces, !faces.isEmpty else {
                    self.dismiss(animated: true, completion: nil)
                    self.resultView.text = "No Face Detected"
                    return
                }
                self.resultView.text = self.resultView.text + "I see \(faces.count) face(s).\n\n"
                
                for face in faces {
                    if face.hasLeftEyeOpenProbability {
                        if face.leftEyeOpenProbability < 0.4 {
                            self.resultView.text = self.resultView.text + "The left eye is not open!\n"
                        } else {
                            self.resultView.text = self.resultView.text + "The left eye is open!\n"
                        }
                    }
                    
                    if face.hasRightEyeOpenProbability {
                        if face.rightEyeOpenProbability < 0.4 {
                            self.resultView.text = self.resultView.text + "The right eye is not open!\n"
                        } else {
                            self.resultView.text = self.resultView.text + "The right eye is open!\n"
                        }
                    }
                    
                    if face.hasSmilingProbability {
                        if face.smilingProbability < 0.3 {
                            self.resultView.text = self.resultView.text + "This person is not smiling.\n\n"
                        } else {
                            self.resultView.text = self.resultView.text + "This person is smiling.\n\n"
                        }
                    }
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
