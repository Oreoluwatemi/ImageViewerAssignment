//
//  SelectViewController.swift
//  ImageViewer
//
//  Created by Oreoluwa Lawal on 2022-03-18.
//

import UIKit
protocol SelectVCDidFinishWithData{
    func SelectVCDidFinishWithImage(titleImg: String, img : UIImage);
    func SelectVCDidFinishWithCancel();
}
class SelectViewController: UIViewController, AddImageURLDelegate, AddImagePhotoDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UrlVC"{
        let vc = segue.destination as! URLViewController
               vc.delegate = self
        }
        if segue.identifier == "CameraVC"{
            let vc = segue.destination as! CameraViewController
            vc.delegate = self
        }
    }
    
    func PhotoVCDidFinishWithImage(titleImg: String, img: UIImage) {
        delegate?.SelectVCDidFinishWithImage(titleImg: titleImg, img: img)
    }
    
    func PhotoVCDidFinishWithCancel() {
        
    }
    
    
    var delegate: SelectVCDidFinishWithData?
    
    func UrlVCDidFinishWithImage(titleImg: String, img: UIImage) {
        delegate?.SelectVCDidFinishWithImage(titleImg: titleImg, img: img)
    }
    
    func UrlVCDidFinishWithCancel() {
        
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
