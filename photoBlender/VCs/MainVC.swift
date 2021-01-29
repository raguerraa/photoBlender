//
//  ViewController.swift
//  photoBlender
//
//  Created by Owner on 1/20/21.
//

import UIKit

class MainVC: UIViewController {

    
    @IBOutlet weak var firstPhoto: UIButton!
    @IBOutlet weak var secondPhoto: UIButton!
    
    var isFirstPhoto: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoVCDestination = segue.destination as! PhotoVC
        photoVCDestination.delegate = self
       
        if segue.identifier == "photoSegue1" {
            isFirstPhoto = true
        }else{
            isFirstPhoto = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    @IBAction func disTapPhotoLibrary1(_ sender: Any) {
        isFirstPhoto = true
        didTapPhotoLibrary()
    }
    @IBAction func didTapPhotoLibrary2(_ sender: Any) {
        isFirstPhoto = false
        didTapPhotoLibrary()
    }
    func didTapPhotoLibrary() {
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        
        imagePickerVC.allowsEditing = true
        present(imagePickerVC, animated: true)
    }
    
}

extension MainVC: ImageDelegate{
    func showImage(image: UIImage) {
        DispatchQueue.main.async {
          
            if self.isFirstPhoto {
                self.firstPhoto.setImage(image, for: .normal)
            }else {
                self.secondPhoto.setImage(image, for: .normal)
            }
        }
    }
}

extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            if self.isFirstPhoto {
                self.firstPhoto.setImage(image, for: .normal)
            }else {
                self.secondPhoto.setImage(image, for: .normal)
            }            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
