//
//  ViewController.swift
//  LampaFeedNews
//
//  Created by Tarasenko Jurik on 06.06.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

final class HomeController: UICollectionViewController  {
    
    private let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=f910e2224b142497cc05444043cc8aa4&language=en-US&page=1"
    
    private var searchResultFilms: [Film] = []
    private var filmsData: [Film] = []
    
    private let topBarHight: CGFloat = 40.0
    
    private let filmCellId = "newsCellId"
    private let topFilmCellId = "topNewsCellId"
 
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.isHidden = true
        sb.barTintColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        sb.alpha = 0.65
        sb.enablesReturnKeyAutomatically = true
        return sb
    }()
    
    private let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private let spiner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let toTopButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        button.setAttributedTitle(NSMutableAttributedString(string: "⇧", attributes: [.font : UIFont.preferredFont(forTextStyle: .headline).withSize(28), .foregroundColor: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1) ]), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8788076563, green: 0.9254902005, blue: 0.8932802395, alpha: 0.6036226455)
        button.addTarget(self, action: #selector(toTopAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupNavBarButtons()
        setupMenuBar()
        fetchRequest()
        setupAdditionalViews()

        self.spiner.startAnimating()
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        collectionView?.register(FilmsCell.self, forCellWithReuseIdentifier: filmCellId)
        collectionView?.register(FirstCellForTopFilms.self, forCellWithReuseIdentifier: topFilmCellId)
    }
    
     @objc private func toTopAction() {
        collectionView?.setContentOffset(.zero, animated: true)
    }
    
    private func setupAdditionalViews() {
        
        view.addSubview(searchBar)
        view.addSubview(toTopButton)
        
        _ = searchBar.anchor(menuBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 55)
        
        _ = toTopButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 10, widthConstant: 45, heightConstant: 45)
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    private func filterContextForSearchText(_ searchText: String) {

            searchResultFilms = filmsData.filter { $0.title != nil }.filter { $0.title!.capitalized.contains(searchText.capitalized) }
        
            self.collectionView?.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return !searchBarIsEmpty() && !searchBar.isHidden }
    
    private func fetchRequest() {
        
        ApiService.sharedInstance.fetchRequest(urlString: urlString) { [weak self] (data, error) in

            guard error == nil else {
                self?.alert(message: "Please check your internet connection and try again.", title: "Error 😓")
                return
            }
            
            guard let data = data else { return }
            self?.filmsData = data
            self?.spiner.stopAnimating()
            self?.collectionView?.reloadData()
        }
    }
    
    private func setupNavBar() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                               width: view.frame.width - 150,
                                               height: view.frame.height))
        titleLabel.text = "Release"
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationItem.titleView = titleLabel
    }
    
    private func setupNavBarButtons() {
        
        let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        let moreBarButtonItem = UIBarButtonItem(image:  #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItem = searchBarButtonItem
        navigationItem.leftBarButtonItem = moreBarButtonItem
    }
    
    @objc private func handleSearch() {
        searchBar.isHidden = !searchBar.isHidden
    }
    
    @objc private func handleMore() {
       // moreButton Action.
    }
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        let backView = UIView()
        backView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        
        view.addSubview(backView)
        view.addSubview(menuBar)
        view.addSubview(spiner)
        
        _ = backView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: topBarHight)
        
        _ = menuBar.anchor(view.safeAreaLayoutGuide.topAnchor , left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: topBarHight)
        
        spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func alert(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContextForSearchText(searchText)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if searchBarIsEmpty() {
            searchBar.isHidden = true
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering() {
            return searchResultFilms.count + 1
            
        } else {
            return filmsData.count + 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 0 {
            identifier = topFilmCellId
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FirstCellForTopFilms
            
            cell.films = filmsData

            return cell
            
        } else {
            identifier = filmCellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FilmsCell
        
        if isFiltering() {
            cell.film = searchResultFilms[indexPath.item - 1]
        } else {
            cell.film = filmsData[indexPath.item - 1]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 350)
    }
}
