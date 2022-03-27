//
//  CameraViewController.swift
//  ImageViewer
//
//  Created by Oreoluwa Lawal on 2022-03-18.
//

import UIKit
protocol AddImagePhotoDelegate{
    func PhotoVCDidFinishWithImage(titleImg: String, img : UIImage);
    func PhotoVCDidFinishWithCancel();
}

class CameraViewController: UIViewController,UIImagePickerControllerDelegate ,
                            UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    var delegate : AddImagePhotoDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        let img : UIImage = imgView.image!;
        let imgTitle : String = "Local Image"
        
        delegate?.PhotoVCDidFinishWithImage(titleImg: imgTitle, img: img)
        let currVC = self.presentingViewController ?? self.navigationController?.presentingViewController
        let checkVC1 = currVC as? UINavigationController
        let checkVC2 = currVC?.navigationController
        if let navVC = checkVC1 ?? checkVC2  {
            navVC.popToRootViewController(animated: false)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func cancelClicked(_ sender: Any) {
        delegate?.PhotoVCDidFinishWithCancel();
        let currVC = self.presentingViewController ?? self.navigationController?.presentingViewController
        let checkVC1 = currVC as? UINavigationController
        let checkVC2 = currVC?.navigationController
        if let navVC = checkVC1 ?? checkVC2  {
            navVC.popToRootViewController(animated: false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func photoClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                        self.goToCamera()
                }))

                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                            self.goToGallery()
                }))
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }
    func goToCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let cameraImg = UIImagePickerController()
            cameraImg.delegate = self
            cameraImg.sourceType = UIImagePickerController.SourceType.camera
            cameraImg.allowsEditing = false
                self.present(cameraImg, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Camera", message: "You don't have camera on your phone", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func goToGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let galleryImg = UIImagePickerController()
            galleryImg.delegate = self
            galleryImg.allowsEditing = true
            galleryImg.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(galleryImg, animated: true, completion: nil)
        
        }else{
            let alert  = UIAlertController(title: "Gallery", message: "You don't have gellery on your phone.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
    }
    func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            if let i = info[.originalImage] as? UIImage{
                imgView.image = i
            }
            dismiss(animated: true, completion: nil)
        }
        

        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            dismiss(animated: true, completion: nil)
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
