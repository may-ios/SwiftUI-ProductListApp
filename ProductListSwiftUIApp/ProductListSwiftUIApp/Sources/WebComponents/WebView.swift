//
//  WebView.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import Foundation
import SwiftUI
import WebKit

// MARK: - WebView
/// SwiftUI에서 WKWebView를 사용하기 위한 UIViewRepresentable 구현체
struct WebView: UIViewRepresentable {
    let url: URL
    @StateObject private var configuration = WebConfiguration() // WKWebView 설정 객체
    
    // MARK: - UIViewRepresentable Protocol
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView( frame: .zero, configuration: configuration.configuration)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
