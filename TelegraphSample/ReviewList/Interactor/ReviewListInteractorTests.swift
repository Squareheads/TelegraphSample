//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import XCTest
@testable import TelegraphSample

class ReviewListInteractorTests: XCTestCase {

    private var interactor: ReviewListInteractor!
    private var mockEntityStore: MockReviewListEntityStore!
    private var mockPresenter: MockReviewListPresenter!

    override func setUp() {
        super.setUp()
        mockPresenter = MockReviewListPresenter()
        mockEntityStore = MockReviewListEntityStore()
        interactor = ReviewListInteractor(entityStore: mockEntityStore, presenter: mockPresenter)
    }

    override func tearDown() {
        interactor = nil
        mockEntityStore = nil
        super.tearDown()
    }

    func testInteractor_FetchReviews_FetchesDataFromReviewEntityStore() {
        XCTAssertEqual(mockEntityStore.fetchDataCallCount, 0)

        interactor.fetchReviews()

        XCTAssertEqual(mockEntityStore.fetchDataCallCount, 1)
    }

    func testInteractorAskedToFetch_DataStoreReturnsError_PresenterIsSentError() {
        mockEntityStore.resultToReturn = .failure(ReviewListEntityStoreError.unableToAcquireData)

        interactor.fetchReviews()

        XCTAssertEqual(mockPresenter.capturedErrorToPresent, ReviewListEntityStoreError.unableToAcquireData)
        XCTAssertEqual(mockPresenter.presentErrorCallCount, 1)
    }

    func testInteractorAskedToFetch_EntityStoreReturnsEntities_PresenterIsSentEntities() {
        mockEntityStore.resultToReturn = .success([])

        interactor.fetchReviews()

        guard let capturedEntities = mockPresenter.capturedEntitiesToPresent else { return XCTFail("Expected captured entities but found nil")}

        XCTAssertEqual(capturedEntities, [ReviewListEntity]())
        XCTAssertEqual(mockPresenter.presentEntitiesCallCount, 1)
    }

}
