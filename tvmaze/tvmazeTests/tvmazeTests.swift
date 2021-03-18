//
//  tvmazeTests.swift
//  tvmazeTests
//
//  Created by David Adell Echevarria on 07/03/2021.
//

import XCTest
@testable import tvmaze

class tvmazeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Tests
    func testTvShowViewModel () {
        let rating = Rating.init(average: 8.5)
        let fakeTvShow = DBtvshow(id: 0,
                                  url: "https://www.fakeurl.com/",
                                  name: "Test tv show",
                                  language: "Spanish",
                                  rating: rating,
                                  image: Image.init(medium: "ImageMedium", original: "ImageOriginal"),
                                  summary: "This is the summary")
        let tvShowViewModel = TvShowViewModel(tvShow: fakeTvShow)
        // Test objects
        XCTAssertNotNil(fakeTvShow)
        XCTAssertNotNil(tvShowViewModel)
        // Test values
        XCTAssertEqual(fakeTvShow.name, tvShowViewModel.name)
        XCTAssertEqual(fakeTvShow.language, tvShowViewModel.language)
        XCTAssertEqual(fakeTvShow.image?.medium, tvShowViewModel.image)
        XCTAssertEqual(fakeTvShow.rating?.average, tvShowViewModel.rating)
        XCTAssertEqual(fakeTvShow.summary, tvShowViewModel.summary)
    }
    
    func testListViewModel() {
        // Test Firts
        ListVM.shared.fetchFirtsTvShows { (tvShowItmes) in
            XCTAssert(!tvShowItmes.isEmpty, "The expected array of Tv shows are empty")
        } failure: { (error) in
            XCTAssertNil(error, "Service call failure")
        }
        // Test fetch next pages
        ListVM.shared.fetchNextTvShows { (tvShowItemsNexPage) in
            XCTAssert(!tvShowItemsNexPage.isEmpty, "The expected array of Tv shows are empty")
        } failure: { (error) in
            XCTAssertNil(error, "Service call failure")
        }
    }
    
    func testServiceFetchData() {
        // Test Firts
        Service.shared.fetchFirtsTvShows { (tvShowItmes) in
            XCTAssert(!tvShowItmes.isEmpty, "The expected array of Tv shows are empty")
        } failure: { (error) in
            XCTAssertNil(error, "Service call failure")
        }
        // Test fetch next pages
        Service.shared.fetchNextTvShows { (tvShowItemsNexPage) in
            XCTAssert(!tvShowItemsNexPage.isEmpty, "The expected array of Tv shows are empty")
        } failure: { (error) in
            XCTAssertNil(error, "Service call failure")
        }
    }
    
    func testServiceGetImages() {
        let imageUrlString = "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg"
        Service.shared.getImageWithUrl(urlString: imageUrlString) { (image) in
            XCTAssertNotNil(image, "The expected image should not be nil")
        } failure: { (error) in
            XCTAssertNil(error, "Download image failure")
        }
    }
    
    func testServerShowsAPI() throws {
        let endOfTestExpectation = expectation(description: "RestServerAPI")
        
        let page = 1
        let urlString = baseURL+showsIndexURL+"?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, "The expected data should not be nil")
            XCTAssertNil(error, "The expected error should be nil")
            
            guard let data = data else { return }
            do {
                XCTAssertNoThrow(try JSONDecoder().decode([DBtvshow].self, from: data), "")
                let tvShows = try JSONDecoder().decode([DBtvshow].self, from: data)
                XCTAssertNotNil(tvShows)
                endOfTestExpectation.fulfill()
            } catch let jsonError {
                XCTAssertNil(jsonError, "Download image failure")
                endOfTestExpectation.fulfill()
            }
        }.resume()
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "We got timeout")
        }
    }
    
    //MARK: - test Performance
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
