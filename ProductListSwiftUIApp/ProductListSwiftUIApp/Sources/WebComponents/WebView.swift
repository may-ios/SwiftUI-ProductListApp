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
/// UIKit의 WKWebView를 SwiftUI 뷰 시스템에 통합
struct WebView: UIViewRepresentable {
    let url: URL
    @EnvironmentObject var coordinator: WebViewCoordinator // WKWebView 상태 관리 코디네이터
    @StateObject private var configuration = WebConfiguration() // WKWebView 설정 객체
    
    // MARK: - UIViewRepresentable Protocol
    
    ///SwiftUI에서 뷰가 처음 생성될 때 한 번 호출, 설정이 완료된 WKWebView 인스턴스 리턴
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView( frame: .zero, configuration: configuration.configuration)
        coordinator.setWebView(webView)
        coordinator.loadURL(url)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
