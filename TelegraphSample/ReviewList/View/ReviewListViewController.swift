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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.Constants.ReuseIdentifier, for: indexPath) as? ReviewListTableViewCell else { fatalError() }

        if case .items(_, let items)? = self.viewModel {
            cell.headlineLabel.text = items[indexPath.row].headline
            cell.descriptionLabel.text = items[indexPath.row].description
            cell.synopsisLabel.text = items[indexPath.row].synopsis
            if let url = URL(string: items[indexPath.row].pictureURL) {
                cell.pictureImageView.kf.setImage(with: url)
            }
        }

        return cell
    }

    var interactor: ReviewListInteractorType?
    var viewModel: ReviewListViewModel? {
        didSet {

            if case .items? = viewModel {
                tableView.isHidden = false
                tableView.reloadData()
                reloadButton.isHidden = true
                errorLabel.isHidden = true
            }

            if case .error(_, let message)? = viewModel {
                tableView.isHidden = true
                reloadButton.isHidden = false
                errorLabel.isHidden = false
                showError(message: message)
            }

            applyTitle()
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var reloadButton: UIButton!

    @IBAction func reload(_ sender: Any) {
        interactor?.fetchReviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Normally In a VIPER application, I would have a module loader, which would be responsible for vending already confogured UIViewControllers for navigation, but as this is currently a single viewcontroller app, this view must configure itself :(
        if interactor == nil {
            ReviewListWireframe.Configure(self)
        }

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

    private func showError(message: String) {
        errorLabel.text = message
    }
}

