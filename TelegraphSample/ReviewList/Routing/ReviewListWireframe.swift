//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

final class ReviewListWireframe {
    static func Configure(_ view: ReviewListViewController) {
        let entityStore = ReviewListEntityStore(session: URLSession.shared)
        let presenter = ReviewListPresenter(view: view)
        let interactor = ReviewListInteractor(entityStore: entityStore, presenter: presenter)

        view.interactor = interactor
    }
}
