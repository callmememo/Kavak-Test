//
//  GnomeCollectionViewCell.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import UIKit
import Kingfisher
import SnapKit

class GnomeCollectionViewCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    var gnome: Gnome? {
        didSet {
            if let gnome = gnome {
                imageView.kf.setImage(
                    with: URL(string: gnome.thumbnail),
                    options: [
                        .transition(.fade(0.25)),
                    ]
                )

                nameLabel.text = gnome.name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        
        [imageView,
         nameLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(contentView).inset(5)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(containerView).offset(10)
            $0.height.width.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.bottom.equalTo(containerView).offset(-10)
        }
        
        containerView.backgroundColor = UIColor.secondarySystemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textColor = UIColor.secondaryLabel
        nameLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
