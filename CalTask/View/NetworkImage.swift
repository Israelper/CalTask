//
//  NetworkImage.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import UIKit
import SDWebImage

class NetworkImage: UIView {

    private let thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(thumbImageView)
        
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func loadImage(from url: URL) {
        thumbImageView.sd_setImage(with: url,
                                    placeholderImage: UIImage(named: "placeholder"))

    }
}
