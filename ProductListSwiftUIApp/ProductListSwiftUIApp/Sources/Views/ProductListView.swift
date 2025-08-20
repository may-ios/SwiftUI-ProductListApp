//
//  ProductListView.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import SwiftUI

// MARK: - ProductListView
struct ProductListView: View {

    var body: some View {
        NavigationView {
            VStack {
            }
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
