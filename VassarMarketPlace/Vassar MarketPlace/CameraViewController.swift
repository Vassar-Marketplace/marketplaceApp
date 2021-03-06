//
//  CameraViewController.swift
//  Vassar MarketPlace
//
//  Created by Riik Acharya on 5/5/22.
//

import UIKit
import Parse
import AlamofireImage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var addedItem: UIImageView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")

        post["itemPrice"] = priceField.text
        post["itemDescription"] = descriptionField.text
        post["user"] = PFUser.current()!

        let imageData = addedItem.image!.pngData()

        let file = PFFileObject(name: "itemImage", data: imageData!)
        
        post["itemImage"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "feedSegue", sender: nil)
                print("saved")
            } else {
                print("error")
                
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        addedItem.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
}
