//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation
@testable import TelegraphSample

final class MockURLSession: URLSessionType {

    var capturedRequest: NSURLRequest?
    var dataTaskCallCount: Int = 0
    var createdTasks: [MockURLSessionDataTask] = []
    var valuesToCompleteWith: (data: Data?, response: URLResponse?, error: Error?)?

    func dataTask(with request: NSURLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        capturedRequest = request
        dataTaskCallCount += 1

        let task = MockURLSessionDataTask()
        createdTasks.append(task)

        if let values = valuesToCompleteWith {
            completionHandler(values.data, values.response, values.error)
        }
        
        return task
    }
}

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {

    var resumeCallCount: Int = 0
    
    func resume() {
        resumeCallCount += 1
    }
}

