//
//  ProductListView.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI
import Combine

// MARK: - ProductListView
/// 상품 목록을 리스트 형태로 표시하는 뷰 (메인)
struct ProductListView: View {
    /// 상품 목록 데이터와 비즈니스 로직을 관리하는 ViewModel
    @StateObject private var viewModel = ProductListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                compactListView // 현재 활성화된 레이아웃, ProductFullRow 교체 가능
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo_cj_enm") 
                }
            }
        }
    }
   
    // MARK: - compact List 레이아웃 : 사용
    private var compactListView: some View {
        List(viewModel.products) { product in
            ProductCompactRow(product: product)
                .listRowInsets(EdgeInsets())      // 기본 리스트 인셋 제거
                .listRowSeparator(.hidden)        // 리스트 항목 간 구분선 숨김
                .listRowBackground(Color.clear)   // 리스트 행 배경을 투명하게 설정
        }
        .listStyle(.plain) // 플레인 리스트 스타일
    }
        
    // MARK: - full List 레이아웃 : 미사용
    private var fullListView: some View {
        List(viewModel.products) { product in
            ProductFullRow(product: product)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ProductListView()
}
