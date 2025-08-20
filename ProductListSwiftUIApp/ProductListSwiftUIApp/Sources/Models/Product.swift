//
//  Models.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import Foundation

// MARK: - Product
/// 상품 데이터를 나타내는 구조체 모델
struct Product: Codable, Identifiable {
    var id = UUID()  // 자동으로 고유 ID 생성
    let name: String
    let brand: String
    let price: Int
    let discountPrice: Int
    let discountRate: Int
    let image: URL
    let link: URL
    let tags: [String]
    let benefits: [String]
    let rating: Double
    let reviewCount: Int
    
    var hasDiscount: Bool {
        discountRate > 0
    }
    
    // id는 CodingKeys에서 제외 => 중복되는 id들이 존재하여 매핑에서 제외하고 UUID로 사용
      enum CodingKeys: String, CodingKey {
          case name, brand, price, discountPrice, discountRate
          case image, link, tags, benefits, rating, reviewCount
      }
}
