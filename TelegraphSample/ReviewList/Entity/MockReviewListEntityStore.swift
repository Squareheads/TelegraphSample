//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation
@testable import TelegraphSample

final class MockReviewListEntityStore: ReviewListEntityStoreType {

    var fetchDataCallCount: Int = 0
    var resultToReturn: (Result<[ReviewListEntity], ReviewListEntityStoreError>)?

    func fetchData(completion: ((Result<[ReviewListEntity], ReviewListEntityStoreError>) -> ())) {
        fetchDataCallCount += 1
        if let result = resultToReturn {
            completion(result)
        }
    }
}
