//
//  ProductDetailView.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine

// MARK: - ProductDetailView
///상품 상세 정보를 WKWebView로 표시 및 로딩 진행률 표현하는 뷰
struct ProductDetailView : View {
    let product: Product // 표시할 상품 정보
    @StateObject private var coordinator = WebViewCoordinator() // WKWebView 상태 관리 객체

    var body: some View {
        VStack(spacing: 0) {
            if coordinator.progress > 0.0 && coordinator.progress < 1.0 {
                // 로딩 중일 때 ProgressView 표시
                ProgressView(value: coordinator.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .brand))
                    .frame(height: 2)
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: coordinator.progress
                    )
            } else {
                // 로딩이 완료되었거나 시작되지 않았을 때 안보이게 처리
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 2)
            }
                 
            //url로 WebView 로드
            WebView(url: product.link)
                .environmentObject(coordinator) // 코디네이터를 환경 객체로 주입
        }
        .navigationTitle(product.name) // 상품명을 네비게이션 타이틀로 설정
        .toolbarRole(.editor) //텍스트 없이 백버튼만 표시
    }
}
