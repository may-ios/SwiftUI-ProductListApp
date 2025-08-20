//
//  WebProcessPool.swift
//  ProductListSwiftUIApp
//
//  Created by kme on 8/20/25.
//

import WebKit


// MARK: - WebProcessPool
/// 여러 웹뷰가 같은 프로세스 풀을 공유하여 메모리 사용량 최적화
final class WebProcessPool {
    static let shared = WebProcessPool()
      let processPool = WKProcessPool()
      private init() {}
}
