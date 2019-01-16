//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation
@testable import TelegraphSample

final class MockReviewListInteractor: ReviewListInteractorType {
    var fetchReviewsCallCount: Int = 0

    func fetchReviews() {
        fetchReviewsCallCount += 1
    }
}
