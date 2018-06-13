//
//  ImageUrl.swift
//  LampaFeedNews
//
//  Created by Tarasenko Jurik on 08.06.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit
import SDWebImage

final class CustomImageView: UIImageView {
    
    private let baseImageUrl = "https://image.tmdb.org/t/p/original"
    private var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: baseImageUrl + urlString) else { return }
        
        image = nil
        
        self.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "empty"))
    }
}
