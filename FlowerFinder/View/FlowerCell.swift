//
//  FlowerCell.swift
//  FlowerFinder
//
//  Created by User on 07/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class FlowerCell: UITableViewCell {
    
    var flower: Flower? {
        didSet{
            textLabel?.text = flower?.name
            detailTextLabel?.text = String(flower!.date!.description)
            profileImageView.loadImageUsingCatchWithUrlString(URLString: flower!.imageUrl!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y-2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y+2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageAnchor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func profileImageAnchor() {
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8) .isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImageUsingCatchWithUrlString(URLString: String){
        
        self.image = nil
        
        if let chachedImage = imageCache.object(forKey: URLString as AnyObject) as? UIImage {
            self.image = chachedImage
            return
        }
        
        let url = URL(string: URLString)
        
        guard let url2 = url else {print("cantuplaodImageWith?url") ; return}
        
        URLSession.shared.dataTask(with: url2) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: URLString as AnyObject)
                    self.image = downloadedImage
                }
            }
            }.resume()
    }
    
}
