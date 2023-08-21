//
//  UIGIFImage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 21/08/23.
//

import UIKit

// https://github.com/globulus/swiftui-gif/tree/main
public class UIGIFImage: UIView {
    private let imageView = UIImageView()
    private var data: Data?
    private var name: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
        initView()
    }
    
    convenience init(data: Data) {
        self.init()
        self.data = data
        initView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        self.addSubview(imageView)
    }
    
    func updateGIF(data: Data) {
        updateWithImage {
            UIImage.gifImage(data: data)
        }
    }
    
    func updateGIF(name: String) {
        updateWithImage {
            UIImage.gifImage(name: name)
        }
    }
    
    private func updateWithImage(_ getImage: @escaping () -> UIImage?) {
        DispatchQueue.global(qos: .userInteractive).async {
            let image = getImage()
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    private func initView() {
        imageView.contentMode = .scaleAspectFit
    }
}
