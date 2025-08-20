//
//  ProductCompactRow.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine

// MARK: - ProductCompactRow
/**
 * 상품을 가로형 컴팩트 레이아웃으로 표시하는 뷰 컴포넌트
 *
 *  UI 구성: (필수 표현 요건 위주로 간단히 표시)
 * - 좌측: 상품 이미지 (120x120 고정 크기)
 * - 우측: 브랜드명, 상품명, 가격 정보
 *
 * NavigationLink로 감싸져 탭 시 상품 상세 화면으로 이동
 */
struct ProductCompactRow : View {
    let product: Product

    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink { // 투명한 네비게이션 링크 (전체 영역 터치 가능)
            } label: {
                EmptyView()
            }.opacity(0)
            HStack(alignment: .center, spacing: 0) {
                
                // 상품 이미지 영역
                AsyncImage(url: product.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill )
                        .frame(width: 120, height: 120)
                        .cornerRadius(4)
                } placeholder: {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.2))
                        .frame(width: 120, height: 120)
                        .cornerRadius(4)
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
                        if product.hasDiscount { // 할인 중인 상태인지 체크 후 할인율 표시
                            Text("\(product.discountRate)%")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                        
                        Text("\(product.discountPrice.formatted())원")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        
                        if product.hasDiscount { // 할인 중인 상태인지 체크 후 원래 가격 표시
                            Text("\(product.price.formatted())원")
                                .font(.caption)
                                .strikethrough()
                                .foregroundStyle(.secondary)
                        }
                    }
                }.padding(10)
               
            }.padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        }
    }
}
