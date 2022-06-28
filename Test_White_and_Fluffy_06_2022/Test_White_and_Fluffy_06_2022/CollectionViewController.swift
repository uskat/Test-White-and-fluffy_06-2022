
import UIKit

class CollectionViewController: UIViewController {
    
    //var photos = Photo.addPhotos()
    var networkDataFetcher = NetworkDataFetcher()
    private var photos = [Photo]()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Gallery"
        view.backgroundColor = .systemGray6
        showCollection()
        //addNavigationBarButton()
        addSearchBar()
    }
    
    override func viewWillLayoutSubviews() {
        checkOrientation()
    }
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        $0.dataSource = self
        $0.delegate = self
        $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let addToFavoritesButton: CustomButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .systemGray
        $0.setTitle("Add photo to Favorites", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapFavoritesButton), for: .touchUpInside)
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        return $0
    }(CustomButton())

    @objc private func tapFavoritesButton() {
        
    }
    
    private let buttonX: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .systemGray
        $0.setImage(UIImage(systemName: "x.circle"), for: .normal)
        $0.tintColor = .white
        $0.alpha = 0.0
        $0.isHidden = true
        $0.addTarget(self, action: #selector(tapButtonX), for: .touchUpInside)
        return $0
    }(UIButton())
    @objc private func tapButtonX() {
        print("tap x")
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.alpha = 0.0
        } completion: { _ in
            self.buttonX.isHidden = true
        }
        UIView.transition(with: collectionView, duration: 1.0, options: .transitionFlipFromBottom, animations: { [self] in
            //profileHeaderView.blurBackgroundEffect().removeFromSuperview()
            collectionView.isUserInteractionEnabled = true
            myView.removeFromSuperview()
        }, completion: nil)
    }

    private var myImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .none
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private var myView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        return $0
    }(UIView())

    
    /*private lazy var navigationBarButton: UIBarButtonItem = {
        return $0
    }(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapNavBar)))
    
    @objc private func tapNavBar() {
        print("hgfddfgdfgdf")
    }*/
    
    
//MARK: =================================== METHODs ===================================
    
    /*private func addNavigationBarButton() {
        navigationItem.rightBarButtonItem = navigationBarButton
    }*/
    
    private func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    
    private func showCollection() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
     
    func showViewWithPhotoOnTap(_ image: UIImage)  {
        UIView.transition(with: collectionView, duration: 3.0, options: .transitionFlipFromBottom, animations: { [self] in
            collectionView.addSubview(myView)
            myImageView.image = image
            [myImageView, buttonX, addToFavoritesButton].forEach { myView.addSubview($0) }
            
            NSLayoutConstraint.activate([
                myView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                myView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                myView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                myView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

                myImageView.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
                myImageView.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
                myImageView.widthAnchor.constraint(equalToConstant: absoluteWidth),
                myImageView.heightAnchor.constraint(equalToConstant: absoluteWidth),

                buttonX.topAnchor.constraint(equalTo: myView.topAnchor, constant: 20),
                buttonX.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -20),
                buttonX.widthAnchor.constraint(equalToConstant: 24),
                buttonX.heightAnchor.constraint(equalToConstant: 24),
                
                addToFavoritesButton.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -16),
                addToFavoritesButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
                addToFavoritesButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
                addToFavoritesButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.isHidden = false
            self.buttonX.alpha = 1.0
        } completion: { _ in  }
    }
}

//MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let photo = photos[indexPath.item]
        cell.setupCell(photos[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    private var inSpace: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (absoluteWidth - 4 * inSpace) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inSpace, left: inSpace, bottom: inSpace, right: inSpace)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = photos[indexPath.row].imageName
        showViewWithPhotoOnTap(image)
    }
}
//MARK: - UIBarSearchDelegate
extension CollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImage(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
            }
        })
    }
}

