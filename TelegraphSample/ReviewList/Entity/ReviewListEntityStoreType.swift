//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

enum ReviewListEntityStoreError: Error {
    case unableToAcquireData
    case unableToParseData
}


protocol ReviewListEntityStoreType {
    func fetchData(completion:  @escaping ((Result<[ReviewListEntity], ReviewListEntityStoreError>) ->()))
}
