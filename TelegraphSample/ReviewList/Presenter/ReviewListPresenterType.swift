//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

protocol ReviewListPresenterType {
    func presentError(error: ReviewListEntityStoreError)
    func presentEntities(_ entities: [ReviewListEntity])
}
