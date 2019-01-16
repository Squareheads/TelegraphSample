//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

final class ReviewListPresenter: ReviewListPresenterType {

    //The view reference is weak, otherwise we would have a retain cycle.
    private weak var view: ReviewListViewType?

    init(view: ReviewListViewType?) {
        self.view = view
    }

    func presentEntities(_ entities: [ReviewListEntity]) {
        self.view?.viewModel = createItemsViewModel(from: entities)
    }

    func presentError(error: ReviewListEntityStoreError) {
        switch error {
        //We could display different messages for errors, but for now we are displaying a single one.
        case .unableToAcquireData, .unableToParseData:
            view?.viewModel = ReviewListViewModel.error(title: "Error", message: "Something went wrong while fetching the movie reviews. Please check your internet connection and try again.")
        }
    }

    private func createItemsViewModel(from entities: [ReviewListEntity]) -> ReviewListViewModel {

        return .items(title: "Reviews", items: entities)
    }
}
