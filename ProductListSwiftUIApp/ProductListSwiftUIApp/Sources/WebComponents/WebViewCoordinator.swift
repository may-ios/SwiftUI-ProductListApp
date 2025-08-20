//
//  WebViewCoordinator.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import WebKit

// MARK: - WebViewCoordinator
/// WKWebView의 델리게이트 처리 및 상태를 관리하는 코디네이터
class WebViewCoordinator: NSObject, ObservableObject {
    @Published var progress: Double = 0.0 // webView 로딩 진행률
    
    private weak var webView: WKWebView? // 관리할 webView (weak으로 순환참조 방지)
    private var progressObservation: NSKeyValueObservation? // progress 관찰자
    
    ///webView를 설정하고 델리게이트를 연결
    func setWebView(_ webView: WKWebView) {
        self.webView = webView
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        // 진행률 관찰
        progressObservation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            DispatchQueue.main.async {
                self?.progress = webView.estimatedProgress
            }
        }
    }
    
    ///지정된 URL을 webView에 로드
    func loadURL(_ url: URL) {
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        webView?.load(request)
    }
    
    /// 메모리 해제 시 옵저버 정리
    deinit {
        progressObservation?.invalidate()
    }
}

// MARK: - WKNavigationDelegate
///webView 네비게이션 델리게이트 - 프로그레스 바 상태는 progressObservation에서 업데이트
extension WebViewCoordinator: WKNavigationDelegate {
    /// 웹페이지 로딩 시작
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    /// 웹페이지 로딩 완료
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    /// 웹페이지 네비게이션 중 오류 발생
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load: \(error.localizedDescription)")
    }
    
    /// 웹페이지 로딩 초기 단계 실패 - 에러 로깅
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed to load: \(error.localizedDescription)")
    }
}

// MARK: - WKUIDelegate
extension WebViewCoordinator: WKUIDelegate {
    /// 새 창 열기 요청 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
