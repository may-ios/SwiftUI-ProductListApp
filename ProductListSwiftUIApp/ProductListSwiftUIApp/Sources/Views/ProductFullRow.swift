//
//  ProductFullRow.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine

// MARK: - ProductFullRow
/**
 * 상품을 가로 너비 기준 풀 레이아웃으로 표시하는 뷰 컴포넌트
 *
 * UI 구성: (필수 표현 요건 위주로 간단히 표시)
 * - 상단: 상품 이미지(1:1 비율, 화면 너비에 맞게 표시)
 * - 하단: 브랜드명, 상품명, 가격 정보
 *
 * 현재는 미사용 상태, 레이아웃 변경 시 확인 가능 
 */
struct ProductFullRow : View {
    let product: Product

    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink { // 투명한 네비게이션 링크 (전체 영역 터치 가능)
                ProductDetailView(product: product)
            } label: {
                EmptyView()
            }.opacity(0)
            VStack(alignment: .leading, spacing: 0) {
                // 상품 이미지 영역
                AsyncImage(url: product.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.2))
                        .aspectRatio(1, contentMode: .fit)
                }
                
                //상품 정보 영역
                VStack(alignment: .leading , spacing: 4) {
                    Text(product.brand)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    Text(product.name)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                    
                    // 가격 정보 표시
                    HStack(spacing: 4){
                        if product.hasDiscount {
                            Text("\(product.discountRate)%")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                        
                        Text("\(product.discountPrice.formatted())원")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        
                        if product.hasDiscount {
                            Text("\(product.price.formatted())원")
                                .font(.caption)
                                .strikethrough()
                                .foregroundStyle(.secondary)
                        }
                    }
                }.padding(10)
                Spacer(minLength: 10)
            }
        }
    }
}
