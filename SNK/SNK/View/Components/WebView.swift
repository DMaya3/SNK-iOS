//
//  WebView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: self.url)
        uiView.load(request)
    }
}
