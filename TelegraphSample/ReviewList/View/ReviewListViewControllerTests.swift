//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import XCTest
@testable import TelegraphSample

class ReviewListViewControllerTests: XCTestCase {

    private var view: ReviewListViewController!
    private var mockInteractor: MockReviewListInteractor!

    override func setUp() {
        super.setUp()
        view = ReviewListViewController()
        mockInteractor = MockReviewListInteractor()
        view.interactor = mockInteractor
    }

    override func tearDown() {
        view = nil
        mockInteractor = nil
        super.tearDown()
    }

    func testView_DidLoad_AsksForData() {
        XCTAssertEqual(mockInteractor.fetchReviewsCallCount, 0)

        _ = view.view

        XCTAssertEqual(mockInteractor.fetchReviewsCallCount, 1)
    }
}
