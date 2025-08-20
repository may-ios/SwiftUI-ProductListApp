//
//  ProductDetailView.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine

// MARK: - ProductDetailView
///상품 상세 정보를 WKWebView로 표시
struct ProductDetailView : View {
    let product: Product // 표시할 상품 정보

    var body: some View {
        VStack {
            
        }
        .navigationTitle(product.name) // 상품명을 네비게이션 타이틀로 설정
    }
}
