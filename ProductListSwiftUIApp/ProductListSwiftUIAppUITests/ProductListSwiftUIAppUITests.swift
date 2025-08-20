//
//  ProductListSwiftUIAppUITests.swift
//  ProductListSwiftUIAppUITests
//
//  Created by kme on 8/20/25.
//

import XCTest

final class ProductListSwiftUIAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    // MARK: 테스트 설정
    override func setUpWithError() throws {
        continueAfterFailure = false // 테스트 실패 시 다음 테스트 중단하지 않음
        app = XCUIApplication()
        app.launch()
    }

    // MARK: 앱 실행 테스트
    // 앱이 정상적으로 실행되는지 확인
    func testAppLaunch() throws {
        // Then - 앱이 존재하고 실행되었는지 검증
        XCTAssertTrue(app.exists, "앱이 정상적으로 실행되어야 함")
    }
    
    // MARK: 메인 화면 요소 테스트
    // 메인 화면의 필수 UI 요소들이 올바르게 표시되는지 확인
    func testMainScreen() throws {
        // When, Then - 리스트가 존재하고 표시되는지 확인
        
        let list = app.primaryList()
        XCTAssertTrue(list.exists, "List가 존재 해야 함")

        // 네비게이션 바와 로고 이미지 확인
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.exists, "네비게이션바가 존재해야 함")

        let logoImage = app.images["logo_cj_enm"]
        XCTAssertTrue(logoImage.exists, "CJ ENM logo가 존재해야 함")
    }

    // MARK: 상품 선택 테스트
    // 상품 셀을 탭하여 상세 화면으로 이동하는지 확인
    func testProductTap() throws {
        // Given - 리스트가 로드될 때까지 대기
        
        let list = app.primaryList()
        XCTAssertTrue(list.exists, "List가 존재 해야 함")

        // When - 첫 번째 상품 셀 탭
        let firstCell = list.cells.firstMatch
        if firstCell.waitForExistence(timeout: 2) {
            firstCell.tap()

            // Then - 상세 화면으로 전환되었는지 확인 (네비게이션 타이틀 또는 뒤로가기 버튼)
            let backButton = app.navigationBars.buttons.element(boundBy: 0)
            XCTAssertTrue(backButton.waitForExistence(timeout: 3),"상세화면 이동 후 뒤로가기 버튼이 나타나야 함")
        } else {
            XCTFail("테스트할 셀이 존재하지 않음")
        }
    }

    // MARK: 웹뷰 로딩 테스트
    // 상품 상세 화면에서 웹뷰가 로드되는지 확인
    func testWebViewLoading() throws {
        // Given - 리스트가 로드되고 첫 번째 셀을 탭
        
        let list = app.primaryList()
        XCTAssertTrue(list.exists, "List가 존재 해야 함")

        let firstCell = list.cells.firstMatch
        if firstCell.waitForExistence(timeout: 2) {
            firstCell.tap()

            // When, Then - 웹뷰의 프로그레스 바가 나타났다가 사라지는지 확인
            let progressView = app.progressIndicators.firstMatch
            XCTAssertTrue( progressView.waitForExistence(timeout: 3), "로딩 중 프로그래스 뷰가 3초 내에 나타나야 함")

            // 프로그레스 바가 사라질 때까지 대기 (웹뷰 로딩 완료)
            let predicate = NSPredicate(format: "exists == false")
            expectation(
                for: predicate,
                evaluatedWith: progressView,
                handler: nil
            )
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertFalse( progressView.exists,"로딩 완료 후 프로그래스 뷰가 사라져야 함")
        } else {
            XCTFail("No product cell found to test")
        }
    }

    // MARK: 스크롤 동작 테스트
    // 리스트 스크롤 테스트
    func testScrolling() throws {
        // Given - 리스트가 로드될 때까지 대기
        let list = app.primaryList()
        XCTAssertTrue(list.exists, "List가 존재 해야 함")

        // When - 스크롤 동작 수행
        list.swipeUp()

        // Then - 스크롤이 정상적으로 동작했는지 확인 (크래시 없이 리스트가 여전히 존재)
        XCTAssertTrue(list.exists, "스크롤 후에도 컬렉션뷰가 존재해야 함")
    }

    // MARK: 앱 실행 성능 테스트
    // 앱 실행 시간 측정
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // 앱 실행 시간 측정
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    /// SwiftUI List가 table 또는 collectionView로 표현되는 둘 다를 커버
    func primaryList(timeout: TimeInterval = 5) -> XCUIElement {
        let table = tables.firstMatch
        if table.waitForExistence(timeout: timeout) { return table }
        let collection = collectionViews.firstMatch
        _ = collection.waitForExistence(timeout: max(1, timeout - 1))
        return collection
    }
}
