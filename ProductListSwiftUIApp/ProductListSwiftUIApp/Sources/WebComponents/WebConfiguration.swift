//
//  WebConfiguration.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import WebKit

// MARK: - WebConfiguration
/// WKWebViewConfiguration을 래핑하는 설정 클래스
final class WebConfiguration: ObservableObject {
    let configuration: WKWebViewConfiguration
    
    init() {
        configuration = WKWebViewConfiguration()
        
        // 인라인 미디어 재생 허용
        configuration.allowsInlineMediaPlayback = true
        
        // JavaScript로 새 창 열기 허용
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        // 공유 프로세스 풀 사용으로 메모리 효율성 향상
        configuration.processPool = WebProcessPool.shared.processPool
    }
}
