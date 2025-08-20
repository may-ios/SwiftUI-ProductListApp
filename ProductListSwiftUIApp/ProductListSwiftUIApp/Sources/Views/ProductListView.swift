//
//  ProductListView.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI

// MARK: - ProductListView
struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()

    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                ZStack(alignment: .leading) {
                    NavigationLink {
                    } label: {
                        EmptyView()
                    }.opacity(0)
                    VStack(alignment: .leading, spacing: 0) {
                        AsyncImage(url: product.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.secondary.opacity(0.2))
                                .aspectRatio(1, contentMode: .fit)
                        }
                        
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
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain) 
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo_cj_enm") 
                }
            }
        }
    }
}

#Preview {
    ProductListView()
}
