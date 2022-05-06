//
//  CreateProfileViewController.swift
//  Vassar MarketPlace
//
//  Created by Karan Pandya on 5/6/22.
//

import UIKit
import AlamofireImage
import Parse

class CreateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var user: PFUser = PFUser.current()!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var paymentField: UITextField!
    
    @IBAction func onDoneButton(_ sender: Any) {
        let post = PFObject(className: "Profile")
        
        post["Name"] = nameField.text
        post["User"] = PFUser.current()!
        post["Payment"] = paymentField.text
        user["payment"] = paymentField.text
        user["name"] = nameField.text
        
        
        let imageData = imageView.image?.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["ProfilePic"] = file
        user["profilePic"] = file
        
        post.saveInBackground{ (success,error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "profileToFeedView", sender: nil)
                print("saved!")
            } else{
                print("error!")
            }
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 100, height: 100)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
