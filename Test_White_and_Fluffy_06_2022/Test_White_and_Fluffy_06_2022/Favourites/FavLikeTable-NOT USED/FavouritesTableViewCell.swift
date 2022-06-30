
import UIKit

class FavouritesTableViewCell: UITableViewCell {

//MARK: - ================================== ViewITEMs ==================================

    var unsplashPhoto: Photo! {
        didSet {
            let photoURL = unsplashPhoto.urls["regular"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else { return }
            imageView1.sd_setImage(with: url, completed: nil)
        }
    }
    
    var imageView1: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    
//MARK: - ==================================== INITs ====================================
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView1.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        showImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//MARK: - =================================== METHODs ===================================
    
    func showImageView() {
        contentView.addSubview(imageView1)
        
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
