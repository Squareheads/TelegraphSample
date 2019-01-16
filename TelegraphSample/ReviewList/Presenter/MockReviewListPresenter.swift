//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation
@testable import TelegraphSample

final class MockReviewListPresenter: ReviewListPresenterType {
    var capturedErrorToPresent: ReviewListEntityStoreError?
    var presentErrorCallCount: Int = 0

    func presentError(error: ReviewListEntityStoreError) {
        capturedErrorToPresent = error
        presentErrorCallCount += 1
    }

    var presentEntitiesCallCount: Int = 0
    var capturedEntitiesToPresent: [ReviewListEntity]?

    func presentEntities(_ entities: [ReviewListEntity]) {
        presentEntitiesCallCount += 1
        capturedEntitiesToPresent = entities
    }

}
