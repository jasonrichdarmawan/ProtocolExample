//
//  GIFImage.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 21/08/23.
//

import SwiftUI

// https://github.com/globulus/swiftui-gif/tree/main
public struct GIFImage: UIViewRepresentable {
    private let data: Data?
    private let name: String?
    
    public init(data: Data) {
        self.data = data
        self.name = nil
    }
    
    public init(name: String) {
        self.data = nil
        self.name = name
    }
    
    public func makeUIView(context: Context) -> UIGIFImage {
        if let data = data {
            return UIGIFImage(data: data)
        } else {
            return UIGIFImage(name: name ?? "")
        }
    }
    
    public func updateUIView(_ uiView: UIGIFImage, context: Context) {
        if let data = data {
            uiView.updateGIF(data: data)
        } else {
            uiView.updateGIF(name: name ?? "")
        }
    }
}
