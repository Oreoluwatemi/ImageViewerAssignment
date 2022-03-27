//
//  URLViewController.swift
//  ImageViewer
//
//  Created by Oreoluwa Lawal on 2022-03-18.
//

import UIKit

protocol AddImageURLDelegate{
    func UrlVCDidFinishWithImage(titleImg: String, img : UIImage);
    func UrlVCDidFinishWithCancel();
}
class URLViewController: UIViewController {

    @IBOutlet weak var imageURL: UITextField!
    @IBOutlet weak var imageTitle: UITextField!
    var delegate: AddImageURLDelegate?
    var imagesCollection : ImagesCollection?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelClicked(_ sender: Any) {
        delegate?.UrlVCDidFinishWithCancel();
        //dismiss(animated: true, completion: nil)
    
        let currVC = self.presentingViewController ?? self.navigationController?.presentingViewController
        let checkVC1 = currVC as? UINavigationController
        let checkVC2 = currVC?.navigationController
        if let navVC = checkVC1 ?? checkVC2  {
            navVC.popToRootViewController(animated: false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func saveClicked(_ sender: Any) {
        let titleImg = imageTitle.text!
        let url : String = imageURL.text!
        let q = DispatchQueue.init(label: "myQ")
        if(titleImg == ""){
            dispError()
            return
        }
        guard let iUrl = URL(string: url) else {self.dispError(); return}
        
                q.async {
                    let data = try?  Data(contentsOf: iUrl)
                    
                    DispatchQueue.main.async {
                        let imgUI = UIImage(data: data!)
                        self.delegate?.UrlVCDidFinishWithImage(titleImg: titleImg, img: imgUI!)
                           }
                }
                
        let currVC = self.presentingViewController ?? self.navigationController?.presentingViewController
        let checkVC1 = currVC as? UINavigationController
        let checkVC2 = currVC?.navigationController
        if let navVC = checkVC1 ?? checkVC2  {
            navVC.popToRootViewController(animated: false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func dispError(){
        let alert = UIAlertController(title: "Error!!", message: "Missing Info", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
               
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
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
