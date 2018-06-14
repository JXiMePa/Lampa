//
//  TopNewsCell.swift
//  LampaFeedNews
//
//  Created by Tarasenko Jurik on 07.06.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

final class FirstCellForTopFilms: UICollectionViewCell  {
    
    private let topFilmsCellId = "topFilmsCellId"
    private let voteAverageToTop: Double = 7.5
    private let minVoteCountToTop = 50
    
    var films:[Film]? {
        didSet {
            onlyTopFilms = (films?.filter({ $0.vote != nil && $0.voteCount != nil }).filter { $0.vote! >= voteAverageToTop && $0.voteCount! > minVoteCountToTop })!
        }
    }
    
    private var onlyTopFilms:[Film] = [] {
        didSet {
            pageControl.numberOfPages = onlyTopFilms.count
            self.collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return pc
    }()
    
    private let hotLabel: UILabel = {
        let label = UILabel()
        let atribute:[NSAttributedStringKey : Any] =
            [.strokeWidth: 5, .font: UIFont.systemFont(ofSize: 16),
             .foregroundColor: UIColor.red]
        label.textAlignment = .left
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1
        label.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.6031410531)
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(string: "  TOP 🔥", attributes: atribute)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopFilmsViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setupTopFilmsViews() {
        
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(hotLabel)
        
        _ = collectionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = pageControl.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = hotLabel.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: -13, widthConstant: 80, heightConstant: 30)
        
        collectionView.isPagingEnabled = true
        collectionView.register( TopFilmsCell.self, forCellWithReuseIdentifier: topFilmsCellId)
    }
}

extension FirstCellForTopFilms : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onlyTopFilms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: topFilmsCellId, for: indexPath) as! TopFilmsCell
        
        cell.topFilm = onlyTopFilms[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height - 54)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumbers = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumbers
    }
}
