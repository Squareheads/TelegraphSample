//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation


enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
