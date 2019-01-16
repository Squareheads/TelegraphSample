//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import XCTest
@testable import TelegraphSample

class ReviewListPresenterTests: XCTestCase {

    private var presenter: ReviewListPresenter!
    private var mockView: MockReviewListView!

    override func setUp() {
        super.setUp()
        mockView = MockReviewListView()
        presenter = ReviewListPresenter(view: mockView)
    }

    override func tearDown() {
        mockView  = nil
        presenter = nil
        super.tearDown()
    }

    func testPresenter_PresentError_SendsErrorToView() {
        presenter.presentError(error: ReviewListEntityStoreError.unableToAcquireData)

        guard case .error(let title, let message)? = mockView.viewModel else { return XCTFail("Expected Error View Model") }

        XCTAssertEqual(title, "Error")
        XCTAssertEqual(message, "Something went wrong while fetching the movie reviews. Please check your internet connection and try again.")
    }

    func testPresenter_PresentEntities_SendsItemsViewModelToView() {
        let entities: [ReviewListEntity] = createTestEntities()

        presenter.presentEntities(entities)

    }


    private func createTestEntities() -> [ReviewListEntity] {
        return [
            ReviewListEntity(ID: 0, websiteURL: "a", headline: "b", description: "c", articleBody: "d", ratings: 1, pictureURL: "e", videoURL: "f", actors: ["g"], director: "h", genre: ["i"], synopsis: "j", releaseDate: "k", duration: "l", publishedDate: "m", author: ReviewListAuthor(name: "aa", headshot: "bb", twitter: "cc")),
            ReviewListEntity(ID: 1, websiteURL: "aa", headline: "bb", description: "cc", articleBody: "dd", ratings: 11, pictureURL: "ee", videoURL: "ff", actors: ["gg"], director: "hh", genre: ["ii"], synopsis: "jj", releaseDate: "kk", duration: "ll", publishedDate: "mm", author: ReviewListAuthor(name: "aabb", headshot: "bbcc", twitter: "ccdd"))
        ]
    }
}
