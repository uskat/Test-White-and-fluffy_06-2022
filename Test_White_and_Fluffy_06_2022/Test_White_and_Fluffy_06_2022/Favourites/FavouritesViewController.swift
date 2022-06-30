
import UIKit

class FavouritesViewController: UIViewController {

//MARK: - ================================== ViewITEMs ==================================

    var photos = [Photo]()

    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        $0.dataSource = self
        $0.delegate = self
        $0.register(FavouritesViewCell.self, forCellWithReuseIdentifier: FavouritesViewCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let removeFromFavouritesButton: CustomButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .systemGray
        $0.setTitle("Remove photo from Favourites", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapRemoveFromFavouritesButton), for: .touchUpInside)
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        return $0
    }(CustomButton())

    @objc private func tapRemoveFromFavouritesButton() {
        print(#function)
        var index1: Int = 0
        _ = collectionView.indexPathsForSelectedItems?.reduce([], { (photosss, indexPath) -> [Photo] in
            var mutablePhotos = photosss
            let photo = photos[indexPath.item]
            mutablePhotos.append(photo)
            index1 = indexPath.item
            return mutablePhotos
        })
        let alert = UIAlertController(title: "ACHTUNG!", message: "Вы уверены, что хотите удалить это восхитительное фото из нашей коллекции?!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Мое мнение тверже гороху!", style: .default) { _ in
            self.photos.remove(at: index1)
            self.collectionView.reloadData()
            print("Ок")
            self.closeOpenedPhoto()
        }
        let cancel = UIAlertAction(title: "Ни в коем случае!", style: .cancel) { _ in
            print("Отмена")
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
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
        closeOpenedPhoto()
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
    
    
//MARK: - ==================================== INITs ====================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = "Favourites"
        view.backgroundColor = .systemGray6
        showCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
    
//MARK: =================================== METHODs ===================================
    
    private func closeOpenedPhoto() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.alpha = 0.0
        } completion: { _ in
            self.buttonX.isHidden = true
        }
        UIView.transition(with: collectionView, duration: 1.0, options: .transitionFlipFromBottom, animations: { [self] in
            collectionView.isUserInteractionEnabled = true
            myView.removeFromSuperview()
        }, completion: nil)
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
     
    func showViewWithPhotoOnTap(_ image: Photo)  {
        UIView.transition(with: collectionView, duration: 3.0, options: .transitionFlipFromBottom, animations: { [self] in
            collectionView.addSubview(myView)
            myImageView.sd_setImage(with: URL(string: image.urls["regular"]!), completed: nil)
            [myImageView, buttonX, removeFromFavouritesButton].forEach { myView.addSubview($0) }
            
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
                
                removeFromFavouritesButton.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -16),
                removeFromFavouritesButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
                removeFromFavouritesButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
                removeFromFavouritesButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.isHidden = false
            self.buttonX.alpha = 1.0
        } completion: { _ in  }
    }
}

//MARK: - UICollectionViewDataSource
extension FavouritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesViewCell.identifier, for: indexPath) as! FavouritesViewCell
        let photo = photos[indexPath.item]
        cell.unsplashPhoto = photo
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    
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
        let image = photos[indexPath.row]
        showViewWithPhotoOnTap(image)
    }
}




