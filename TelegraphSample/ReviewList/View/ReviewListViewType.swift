//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

protocol ReviewListViewType: class {
    var viewModel: ReviewListViewModel? { get set }
    var interactor: ReviewListInteractorType? { get set }
}
