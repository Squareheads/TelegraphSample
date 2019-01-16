//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import XCTest
@testable import TelegraphSample

class ReviewListResponseTests: XCTestCase {

    func testReviewListResponse_WithValidData_ParsesFields() throws {
        let data = jsonData(forFileNamed: "validJSON")
        let reviewListResponse = try JSONDecoder().decode(ReviewListResponse.self, from: data)
        XCTAssertEqual(reviewListResponse.collection.count, 10)

        XCTAssertEqual(reviewListResponse.collection[0].ID, 1)
        XCTAssertEqual(reviewListResponse.collection[0].websiteURL, "http://www.telegraph.co.uk/film/the-revenant/")
        XCTAssertEqual(reviewListResponse.collection[0].headline, "The revenant")
        XCTAssertEqual(reviewListResponse.collection[0].description, "Leo's beautiful endurance test")
        XCTAssertEqual(reviewListResponse.collection[0].articleBody, "")
        XCTAssertEqual(reviewListResponse.collection[0].ratings, 4)
        XCTAssertEqual(reviewListResponse.collection[0].pictureURL, "http://www.telegraph.co.uk/content/dam/film/the revenant/leo-xlarge.jpg")
        XCTAssertEqual(reviewListResponse.collection[0].videoURL, "")
        XCTAssertEqual(reviewListResponse.collection[0].actors, ["Leonardo DiCaprio", "Tom Hardy", "Domhnall Gleeson", "Will Poulter"])
        XCTAssertEqual(reviewListResponse.collection[0].director, "Alejandro G. IÃ±Ã¡rritu")
            XCTAssertEqual(reviewListResponse.collection[0].genre, [  "Action", "Drama"])
        XCTAssertEqual(reviewListResponse.collection[0].synopsis, "In the 1820s, a frontiersman, Hugh Glass, sets out on a path of vengeance against those who left him for dead after a bear mauling")
        XCTAssertEqual(reviewListResponse.collection[0].releaseDate, "15-01-2015")
        XCTAssertEqual(reviewListResponse.collection[0].duration, "156 mins")
        XCTAssertEqual(reviewListResponse.collection[0].publishedDate, "14 January 2016 â€¢ 12:00pm")
        XCTAssertEqual(reviewListResponse.collection[0].author.headshot, "http://www.telegraph.co.uk/content/dam/film/team/robbie-collin-byline0-USE-small.jpg")
        XCTAssertEqual(reviewListResponse.collection[0].author.name, "Robbie Collin")
        XCTAssertEqual(reviewListResponse.collection[0].author.twitter, "@robbiereviews")

        //I would normally test the other entries in the array, but they are being omitted for brevity
    }

    private func jsonData(forFileNamed jsonFile: String) -> Data {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: jsonFile, ofType: "json")!
        let url = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: url)
        return data
    }
}
