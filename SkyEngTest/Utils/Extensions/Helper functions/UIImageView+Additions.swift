//
//  UIImageView+Additions.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import UIKit

extension UIImageView {
    func load(url: URL, targetSize: CGSize) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
