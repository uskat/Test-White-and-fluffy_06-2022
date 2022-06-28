
import UIKit

class CollectionViewCell: UICollectionViewCell {

//MARK: - ================================== ViewITEMs ==================================
    
    var unsplashPhoto: Photo! {
        didSet {
            let photoURL = unsplashPhoto.urls["regular"]
        }
    }
    
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    /*private let marker: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alpha = 0
        return $0
    }(UIImageView(image: UIImage(named: "checkmark")))
    
    override var isSelected: Bool {
        didSet {
            checkIsSelectedState()
        }
    }*/
    
    
    
//MARK: - ==================================== INITs ====================================
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    /*private func checkIsSelectedState() {
        imageView.alpha = isSelected ? 0.65 : 1
        marker.alpha = isSelected ? 1 : 0
    }*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showImageView()
        //showMarker()
        //checkIsSelectedState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - =================================== METHODs ===================================
    func setupCell(_ photo: Photo) {
        imageView.image = photo.imageName
    }
    
    private func showImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    /*private func showMarker() {
        addSubview(marker)
        
        NSLayoutConstraint.activate([
            marker.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            marker.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            marker.heightAnchor.constraint(equalToConstant: 20),
            marker.widthAnchor.constraint(equalToConstant: 20)
        ])
    }*/
    
}
