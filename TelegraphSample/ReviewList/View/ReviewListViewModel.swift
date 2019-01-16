//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

enum ReviewListViewModel {
    case error(title: String, message: String)
    case items(title: String, items: [ReviewListEntity])
}
