//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import UIKit

final class ReviewListViewController: UIViewController, ReviewListViewType, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .items(_, let items)? = viewModel else {
            return 0
        }

        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }

    var interactor: ReviewListInteractorType?
    var viewModel: ReviewListViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchReviews()
    }

    private func applyTitle() {
        guard let viewModel = viewModel else { return }

        switch viewModel {
        case .error(let title, _):
            self.title = title
        case .items(let title, _):
            self.title = title
        }
    }
}

