
import UIKit
import AVFoundation

class FavouritesTableViewController: UIViewController {

//MARK: - ================================== ViewITEMs ==================================

    var photos = [Photo]()
    
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
        _ = tableView.indexPathsForSelectedRows?.reduce([], { (photosss, indexPath) -> [Photo] in
            var mutablePhotos = photosss
            let photo = photos[indexPath.item]
            mutablePhotos.append(photo)
            index1 = indexPath.item
            return mutablePhotos
        })
        let alert = UIAlertController(title: "ACHTUNG!", message: "Вы уверены, что хотите удалить это восхитительное фото из нашей коллекции?!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Мое мнение тверже гороху!", style: .default) { _ in
            self.photos.remove(at: index1)
            self.tableView.reloadData()
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
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    
//MARK: - ==================================== INITs ====================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        showProfileTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    
//MARK: - =================================== METHODs ===================================

    private func closeOpenedPhoto() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
            self.buttonX.alpha = 0.0
        } completion: { _ in
            self.buttonX.isHidden = true
        }
        UIView.transition(with: tableView, duration: 1.0, options: .transitionFlipFromBottom, animations: { [self] in
            tableView.isUserInteractionEnabled = true
            myView.removeFromSuperview()
        }, completion: nil)
    }
    
    func showViewWithPhotoOnTap(_ image: Photo)  {
        UIView.transition(with: tableView, duration: 3.0, options: .transitionFlipFromBottom, animations: { [self] in
            tableView.addSubview(myView)
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
    
    private func showProfileTable() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
    
//MARK: UITableViewDataSource
extension FavouritesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as! FavouritesTableViewCell
        let photo = photos[indexPath.item]
        cell.unsplashPhoto = photo
        return cell
    }
}

//MARK: высота ячейки в таблице.
extension FavouritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 6
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = photos[indexPath.row]
        showViewWithPhotoOnTap(image)
    }
}
