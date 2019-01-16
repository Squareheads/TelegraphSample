//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import XCTest
@testable import TelegraphSample

class ReviewListEntityStoreTests: XCTestCase {

    private var mockSession: MockURLSession!
    private var store: ReviewListEntityStore!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        store = ReviewListEntityStore(session: mockSession)
    }

    override func tearDown() {
        mockSession = nil
        store = nil
        super.tearDown()
    }

    func testStore_FetchData_MakesNetworkRequest() {


        store.fetchData { _ in }

        guard let request = mockSession.capturedRequest else { return XCTFail("Expected to capture a URLRequest but did not find one.")}

        XCTAssertEqual(request.url?.absoluteString, "http://s.telegraph.co.uk/tmgmobilepub/articles.json")
        XCTAssertEqual(mockSession.dataTaskCallCount, 1)

        guard let task = mockSession.createdTasks.first, mockSession.createdTasks.count == 1 else { return XCTFail("Expected one and only one captured data task bbut recieved zero or > 1")}

        XCTAssertEqual(task.resumeCallCount, 1)

    }

    func testStoreBeingFetched_URLSessionReturnsValidData_ReturnsSuccess() {
        mockSession.valuesToCompleteWith = createSessionValues(withJSONDataFromFileNamed: "validJSON",
                                                               fromURLWithString: "http://s.telegraph.co.uk/tmgmobilepub/articles.json")

        let expect = expectation(description: "fetchData completion should be called")

        store.fetchData { result in
            expect.fulfill()
            guard case .success = result else { return XCTFail("Expected a success result but did not receive one") }
        }

        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testStoreBeingFetched_URLSessionReturnsInValidData_ReturnsFailure() {
        mockSession.valuesToCompleteWith = createSessionValues(withJSONDataFromFileNamed: "invalidJSON",
                                                               fromURLWithString: "http://s.telegraph.co.uk/tmgmobilepub/articles.json")

        let expect = expectation(description: "fetchData completion should be called")

        store.fetchData { result in
            expect.fulfill()
            guard case .failure(let reason) = result else { return XCTFail("Expected a failure result but did not receive one") }
            XCTAssertEqual(reason, .unableToParseData)
        }

        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testStoreBeingFetched_URLSessionReturnsNon200StatusCode_ReturnsFailure() {
        mockSession.valuesToCompleteWith = createSessionValues(withJSONDataFromFileNamed: "invalidJSON",
                                                               fromURLWithString: "http://s.telegraph.co.uk/tmgmobilepub/articles.json",
                                                               response: HTTPURLResponse(url: URL(string: "http://s.telegraph.co.uk/tmgmobilepub/articles.json")!, statusCode: 404, httpVersion: nil, headerFields: nil))

        let expect = expectation(description: "fetchData completion should be called")

        store.fetchData { result in
            expect.fulfill()
            guard case .failure(let reason) = result else { return XCTFail("Expected a failure result but did not receive one") }
            XCTAssertEqual(reason, .unableToAcquireData)
        }

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    

    private func createSessionValues(withJSONDataFromFileNamed jsonName: String, fromURLWithString urlString: String, response: URLResponse? = nil) -> (data: Data?, response: URLResponse?, error: Error?) {

        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: jsonName, ofType: "json")!
        let url = URL(fileURLWithPath: filePath)

        let data = try! Data(contentsOf: url)
        return (data: data,
         response: response ?? URLResponse(url: URL(string: urlString)!, mimeType: nil, expectedContentLength: 1, textEncodingName: nil),
         error: nil)
    }

}
