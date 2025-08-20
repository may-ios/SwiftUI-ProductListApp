//
//  ProductService.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine


// MARK: - ProductServiceProtocol
/// 상품 서비스 추상화 프로토콜
protocol ProductServiceProtocol {
    func fetchProducts() -> AnyPublisher<[Product], Never>
}

// MARK: - ProductService
/// 상품 데이터 로딩 서비스
class ProductService: ProductServiceProtocol {
    func fetchProducts() -> AnyPublisher<[Product], Never> {
        // 번들에 포함된 products.json 파일에서 데이터 로딩
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let products = try? JSONDecoder().decode([Product].self, from: data) else {
            return Just([]).eraseToAnyPublisher()
        }
        
        return Just(products).eraseToAnyPublisher()
    }
}
