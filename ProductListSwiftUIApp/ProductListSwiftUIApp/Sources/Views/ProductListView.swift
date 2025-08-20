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
                fullListView
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo_cj_enm") 
                }
            }
        }
    }
   
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
