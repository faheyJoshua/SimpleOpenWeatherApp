//
//  JFImageLoader.swift
//  Metal Demo
//
//  Created by Joshua Fahey on 11/17/20.
//  Our Lady of Logic, ora pro nobis

import UIKit


class ImageFetch: ObservableObject {
    
    @Published var image: UIImage?

    func loadImage(with url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let data = (try? Data(contentsOf: url)) ?? Data()
            let img = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.image = img
            }
        }
    }
}
