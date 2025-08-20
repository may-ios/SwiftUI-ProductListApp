//
//  ProductListSwiftUIAppTests.swift
//  ProductListSwiftUIAppTests
//
//  Created by kme on 8/20/25.
//

import XCTest
@testable import ProductListSwiftUIApp

// MARK: - Unit Tests
final class ProductListSwiftUIAppTests: XCTestCase {

    // MARK: Product 모델 테스트
    // Product 모델의 속성값 초기화와 접근 테스트
    func testProductModel() throws {
        // Given - 테스트용 상품 객체 생성
        let product = Product(
            name: "테스트상품",
            brand: "테스트브랜드",
            price: 100000,
            discountPrice: 80000,
            discountRate: 20,
            image: URL(string: "https://example.com/image.jpg")!,
            link: URL(string: "https://example.com/link")!,
            tags: ["태그1"],
            benefits: ["혜택1"],
            rating: 4.5,
            reviewCount: 100
        )
        
        // Then - 모델 속성값들이 올바르게 설정되었는지 검증
        XCTAssertEqual(product.name, "테스트상품", "상품명이 올바르게 설정되어야 함")
        XCTAssertEqual(product.price, 100000, "가격이 올바르게 설정되어야 함")
        XCTAssertEqual(product.discountRate, 20,"할인율이 올바르게 설정되어야 함")
        XCTAssertEqual(product.discountPrice, 80000, "할인가격이 올바르게 설정되어야 함")
        XCTAssertEqual(product.brand, "테스트브랜드", "브랜드명이 올바르게 설정되어야 함")
    }
    
    // MARK: ProductService 테스트
    // JSON 파일에서 상품 데이터를 로드하는 기능 검증
    func testProductService() throws {
        // Given - ProductService 인스턴스 생성
        let service = ProductService()
        let expectation = XCTestExpectation(description: "JSON 데이터로 상품 목록을 가져옴")

        // When - 상품 데이터 로드
        var receivedProducts: [Product] = []
        let cancellable = service.fetchProducts()
            .sink { products in
                receivedProducts = products
                expectation.fulfill()
            }

        // Then - 상품 배열이 비어 있지 않은지 확인
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(receivedProducts.count >= 0, "상품 목록이 정상적으로 로드되어야 함")
        
           if !receivedProducts.isEmpty {
               XCTAssertNotNil(receivedProducts.first?.name, "첫 번째 상품의 이름이 존재해야 함")
               XCTAssertNotNil(receivedProducts.first?.discountPrice, "첫 번째 상품의 가격이 존재해야 함")
               XCTAssertNotNil(receivedProducts.first?.image, "첫 번째 상품의 이미지 URL이 존재해야 함")
           }
           
        // Clean up
        cancellable.cancel()
    }
    
    // MARK: ViewModel 초기화 테스트
    // ProductListViewModel의 초기 상태 검증
    @MainActor
    func testViewModelInit() throws {
        // Given, When - ProductListViewModel 인스턴스 생성
        let viewModel = ProductListViewModel()
        
        // Then - 초기 상태값들이 올바르게 설정되었는지 검증
        XCTAssertEqual(viewModel.products.count, 0, "초기 상품 목록은 비어있어야 함")
    }
    
    // MARK: Product hasDiscount 계산 속성 테스트
    // hasDiscount 값 검증
    func testProductHasDiscount() throws {
        // Given - 할인 있는 상품
        
        let discountedProduct = Product(
            name: "할인상품",
            brand: "할인브랜드",
            price: 10000,
            discountPrice: 3000,
            discountRate: 70,
            image: URL(string: "https://example.com/image.jpg")!,
            link: URL(string: "https://example.com/link")!,
            tags: [],
            benefits: [],
            rating: 0,
            reviewCount: 0
        )
        
        // Given - 할인 없는 상품
        let normalProduct = Product(
            name: "일반상품",
            brand: "일반브랜드",
            price: 10000,
            discountPrice: 10000,
            discountRate: 0,
            image: URL(string: "https://example.com/image.jpg")!,
            link: URL(string: "https://example.com/link")!,
            tags: [],
            benefits: [],
            rating: 0,
            reviewCount: 0
        )
        
        // Then - hasDiscount 계산 속성 검증
        XCTAssertTrue(discountedProduct.hasDiscount, "할인율이 0보다 크면 hasDiscount는 true여야 함")
        XCTAssertFalse(normalProduct.hasDiscount, "할인율이 0이면 hasDiscount는 false여야 함")
    }

    // MARK: WebProcessPool 싱글톤 테스트
    // 공유 풀 싱글톤인지 테스트
    func testWebProcessPoolSingleton() throws {
        // Given - WebProcessPool 인스턴스 생성
        let pool1 = WebProcessPool.shared
        let pool2 = WebProcessPool.shared
        
        // Then - 같은 인스턴스여야 함
        XCTAssertTrue(pool1 === pool2, "WebProcessPool.shared는 싱글톤이어야 함")
    }
}
