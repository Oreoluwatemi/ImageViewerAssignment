//
//  ImagesCollection.swift
//  ImageViewer
//
//  Created by Oreoluwa Lawal on 2022-03-18.
//

import Foundation
import UIKit
class ImagesCollection{
    var allImages : [Images] = [Images]()
    
    func addImages(t : String, i : UIImage){
        allImages.append(Images(t: t, i: i))
    }
}
