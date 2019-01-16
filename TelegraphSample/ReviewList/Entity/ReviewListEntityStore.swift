//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

protocol URLSessionType {

    func createDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionType {
    func createDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {

        return dataTask(with:request, completionHandler: completionHandler)
    }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}


final class ReviewListEntityStore: ReviewListEntityStoreType {
    private let session: URLSessionType

    init(session: URLSessionType) {
        self.session = session
    }

    func fetchData(completion: @escaping ((Result<[ReviewListEntity], ReviewListEntityStoreError>) -> ())) {
        let request = URLRequest(url: URL(string: "http://s.telegraph.co.uk/tmgmobilepub/articles.json")!)

        let task = session.createDataTask(with: request) { (data, response, error) in

            DispatchQueue.main.async {


                // There are many types of error that can populate the error value from datatask, e.g. network and connectivity errors, but for simplicity we will handle them here as a simple 'Could Not Connect'
                if let _ = error {
                    completion(.failure(ReviewListEntityStoreError.unableToAcquireData))
                    return
                }

                //Again, there are numerous ways that this request could fail, and each should be handled accordingly... but for time purposes we will check for a valid status code and valid data for our successes, anything else will be classed as an error
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    completion(.failure(ReviewListEntityStoreError.unableToAcquireData))
                    return
                }


                if let data = data {
                    do {
                        let reviewListResponse = try JSONDecoder().decode(ReviewListResponse.self, from: data)
                        completion(.success(reviewListResponse.collection))
                    }
                    catch {
                        completion(.failure(ReviewListEntityStoreError.unableToParseData))

                    }
                    return
                }

                completion(.failure(ReviewListEntityStoreError.unableToAcquireData))

            }
        }

        task.resume()

    }
}
