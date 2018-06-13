//
//  TopCell.swift
//  LampaFeedNews
//
//  Created by Tarasenko Jurik on 07.06.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

class TopFilmsCell: BaseCell {
    
    var topFilm: Film? {
        didSet {
            setupTitle()
            setupImage()
            setupReleaseDate()
            setupVoteCount()
        }
    }
    
    var setTitle: NSAttributedString {
        get { return NSAttributedString() }
        set { titleLabel.attributedText = newValue }
    }
    var setVote: String {
        get { return String() }
        set { voteLabel.text = newValue }
    }
    var setRelease: String {
        get { return String() }
        set { releaseLabel.text = newValue }
    }
    var setImage: String {
        get { return String() }
        set { filmImageView.loadImageUsingUrlString(urlString: newValue)}
    }
    
   private let titleLabel: UILabel = {
        let label = UILabel()
        label.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.447854238)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
   private let voteLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6027664812)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
   private let releaseLabel: UILabel = {
        let label = UILabel()
        label.text = "---"
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6027664812)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
   private let filmImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "empty")
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()

   private let favoriteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        button.setTitle("☆", for: .normal)
        return button
    }()

    override func setupViews() {
        
        addSubview(filmImageView)
        filmImageView.addSubview(titleLabel)
        filmImageView.addSubview(voteLabel)
        filmImageView.addSubview(releaseLabel)
        addSubview(favoriteButton)
        
        _ = titleLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 48, rightConstant: 15, widthConstant: 0, heightConstant: 50)
        
        _ = filmImageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = voteLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: centerXAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 15, rightConstant: 5, widthConstant: 0, heightConstant: 30)
        
        _ = releaseLabel.anchor(nil, left: centerXAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 15, rightConstant: 5, widthConstant: 0, heightConstant: 30)
    }
    
    func setupTitle() {
        
        let atribute: [NSAttributedStringKey : Any] =
            [.font: UIFont.monospacedDigitSystemFont(ofSize: 26, weight: UIFont.Weight.bold),
             .foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) ]
        
        if let title = topFilm?.title {
            setTitle = NSAttributedString(string: title, attributes: atribute)
        }
    }
    
    func setupImage() {
        if let ImageUrl = topFilm?.image {
            setImage = ImageUrl
        }
    }
    
    func setupReleaseDate() {
        if let release = topFilm?.release, let language = topFilm?.language {
            setRelease = String("Release: \(release), \(language)".capitalized)
        }
    }
    
    func setupVoteCount() {
        if let voteCount = topFilm?.voteCount, let vote = topFilm?.vote {
            setVote = String("Vote: \(voteCount), Avarage: \(vote)".capitalized)
        }
    }
}
