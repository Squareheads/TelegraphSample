//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

final class ReviewListInteractor: ReviewListInteractorType {
    private let entityStore: ReviewListEntityStoreType
    private let presenter: ReviewListPresenterType

    init(entityStore: ReviewListEntityStoreType, presenter: ReviewListPresenterType) {
        self.entityStore = entityStore
        self.presenter = presenter
    }

    func fetchReviews() {
        entityStore.fetchData { result in

            switch result {
            case .failure(let reason):
                self.presenter.presentError(error: reason)
            case .success(let entities):
                self.presenter.presentEntities(entities)
            }
        }
    }
}
