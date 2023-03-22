//
//  ImageManager.swift
//  ImagePicker Bundle. Sandbox. FileManager
//
//  Created by Олеся on 21.03.2023.
//

import UIKit


class ImageManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private  var imagePecker = UIImagePickerController()
    static let defaultManager = ImageManager()
    var saveData: ((_ data: Data, _ url: URL)-> Void)?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] ) {
        guard  let image = (info[.originalImage] as! UIImage).pngData() else {
            print("image = nil")
            return
        }
        guard let url =  info[.imageURL] as? URL else {
            print("Url Image is nil")
            return
        }
        saveData?(image, url)
        picker.dismiss(animated: true)
    }
    
    func setPicker(in viewController: UIViewController){
        imagePecker.delegate = self
        imagePecker.sourceType = .photoLibrary
        viewController.present(imagePecker, animated: true)
    }
}
