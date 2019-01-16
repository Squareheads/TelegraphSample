//
//  Copyright © 2019 Owen Worley. All rights reserved.
//

import Foundation

enum ReviewListEntityKeys: String, CodingKey {
    case ID = "id"
    case websiteURL = "website-url"
    case headline = "headline"
    case description = "description"
    case articleBody = "article-body"
    case ratings = "ratings"
    case pictureURL  = "picture-url"
    case videoURL = "video-url"
    case actors = "actors"
    case director = "director"
    case genre = "genre"
    case synopsis = "synopsis"
    case releaseDate = "release-date"
    case duration = "duration"
    case publishedDate = "published-date"
    case author = "author"

}

struct ReviewListEntity: Equatable, Decodable {
    let ID: Int
    let websiteURL: String
    let headline: String
    let description: String
    let articleBody: String
    let ratings: Int
    let pictureURL: String
    let videoURL: String
    let actors: [String]
    let director: String
    let genre: [String]
    let synopsis: String
    let releaseDate: String
    let duration: String
    let publishedDate: String
    let author: ReviewListAuthor

    init(ID: Int,
         websiteURL: String,
         headline: String,
         description: String,
         articleBody: String,
         ratings: Int,
         pictureURL: String,
         videoURL: String,
         actors: [String],
         director: String,
         genre: [String],
         synopsis: String,
         releaseDate: String,
         duration: String,
         publishedDate: String,
         author: ReviewListAuthor) {
        self.ID = ID
        self.websiteURL = websiteURL
        self.headline = headline
        self.description = description
        self.articleBody = articleBody
        self.ratings = ratings
        self.pictureURL = pictureURL
        self.videoURL = videoURL
        self.actors = actors
        self.director = director
        self.genre = genre
        self.synopsis = synopsis
        self.releaseDate = releaseDate
        self.duration = duration
        self.publishedDate = publishedDate
        self.author = author
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReviewListEntityKeys.self)
        let ID: Int = try container.decode(Int.self, forKey: .ID)
        let websiteURL: String = try container.decode(String.self, forKey: .websiteURL)
        let headline: String = try container.decode(String.self, forKey: .headline)
        let description: String = try container.decode(String.self, forKey: .description)
        let articleBody: String = try container.decode(String.self, forKey: .articleBody)
        let ratings: Int = try container.decode(Int.self, forKey: .ratings)
        let pictureURL: String = try container.decode(String.self, forKey: .pictureURL)
        let videoURL: String = try container.decode(String.self, forKey: .videoURL)
        let actors: [String] = try container.decode([String].self, forKey: .actors)
        let director: String = try container.decode(String.self, forKey: .director)
        let genre: [String] = try container.decode([String].self, forKey: .genre)
        let synopsis: String = try container.decode(String.self, forKey: .synopsis)
        let releaseDate: String = try container.decode(String.self, forKey: .releaseDate)
        let duration: String = try container.decode(String.self, forKey: .duration)
        let publishedDate: String = try container.decode(String.self, forKey: .publishedDate)
        let author: ReviewListAuthor = try container.decode(ReviewListAuthor.self, forKey: .author)

        self.init(ID: ID,
                  websiteURL: websiteURL,
                  headline: headline,
                  description: description,
                  articleBody: articleBody,
                  ratings: ratings,
                  pictureURL: pictureURL,
                  videoURL: videoURL,
                  actors: actors,
                  director: director,
                  genre: genre,
                  synopsis: synopsis,
                  releaseDate: releaseDate,
                  duration: duration,
                  publishedDate: publishedDate,
                  author: author)
    }

}
