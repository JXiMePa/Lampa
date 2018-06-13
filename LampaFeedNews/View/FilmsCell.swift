//
//  NewsCell.swift
//  LampaFeedNews
//
//  Created by Tarasenko Jurik on 07.06.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

final class FilmsCell: TopFilmsCell {
    
    var film: Film? {
        didSet {
            setupImage()
            setupTitle()
            setupReleaseDate()
            setupVoteCount()
        }
    }
    
    override func setupTitle() {
        
        let atribute: [NSAttributedStringKey : Any] =
            [.font: UIFont.monospacedDigitSystemFont(ofSize: 26, weight: UIFont.Weight.bold),
             .foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) ]
        
        if let title = film?.title {
            setTitle = NSAttributedString(string: title, attributes: atribute)
        }
    }
    
    override func setupImage() {
        if let ImageUrl = film?.image {
            setImage = ImageUrl
        }
    }
    
    override func setupReleaseDate() {
        if let release = film?.release, let language = film?.language {
            setRelease = String( "Release: \(release), \(language)".capitalized )
        }
    }
    
    override func setupVoteCount() {
        if let voteCount = film?.voteCount, let vote = film?.vote {
            setVote = String( "Vote: \(voteCount), Avarage: \(vote)".capitalized )
        }
    }
}
