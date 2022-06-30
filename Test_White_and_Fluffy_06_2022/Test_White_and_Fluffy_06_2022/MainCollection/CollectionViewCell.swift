
import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {

//MARK: - ================================== ViewITEMs ==================================
    
    var unsplashPhoto: Photo! {
        didSet {
            let photoURL = unsplashPhoto.urls["regular"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else { return }
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    
//MARK: - ==================================== INITs ====================================
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        showImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - =================================== METHODs ===================================

    private func showImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
