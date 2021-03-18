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
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
