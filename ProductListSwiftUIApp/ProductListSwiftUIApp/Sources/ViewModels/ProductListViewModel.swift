//
//  ProductListViewModel.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine

// MARK: - ProductListViewModel
@MainActor
class ProductListViewModel: ObservableObject {
    
    /// 화면에 표시될 상품 목록 - @Published로 값이 변경되면 뷰 업데이트
    @Published var products: [Product] = []

    /// 상품 데이터 서비스
    private let productService: ProductServiceProtocol
    
    /// Combine 구독을 관리 Set
    private var cancellables = Set<AnyCancellable>()

    /// 의존성 주입을 통한 서비스 설정
    /// *ViewModel을 초기화하고 상품 데이터를 바로 로드
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
        fetchProducts()
    }
    
    /// 상품 목록 가져오기
    func fetchProducts() {
        productService.fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { products in
                self.products = products
            }.store(in: &cancellables)
    }
}

