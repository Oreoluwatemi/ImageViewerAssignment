//
//  ViewController.swift
//  ImageViewer
//
//  Created by Oreoluwa Lawal on 2022-03-18.
//

import UIKit

class ViewController: UIViewController, SelectVCDidFinishWithData, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    
    var imgCollection : ImagesCollection?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //imgCollection?.allImages.delegate = self
        picker.delegate = self
        picker.dataSource = self
        imgCollection = (UIApplication.shared.delegate as! AppDelegate).imagesCollection
    
    }

    func SelectVCDidFinishWithImage(titleImg: String, img: UIImage) {
        imgCollection?.addImages(t: titleImg, i: img)
        imgView.image = imgCollection?.allImages[0].img
        picker.reloadAllComponents()
        let alert = UIAlertController(title: "Image Added!!", message: "Thank You", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { action in
                                   
                        }
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
    }
    
    func SelectVCDidFinishWithCancel() {
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (imgCollection?.allImages.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let imgs = imgCollection?.allImages[row].title
            return imgs
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let rowSelected = picker.selectedRow(inComponent: 0)
        let img = imgCollection?.allImages[rowSelected].img
        
        imgView.image = img;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SelectViewController
               vc.delegate = self
    }
}

