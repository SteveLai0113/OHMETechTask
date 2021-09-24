//
//  OHMETechTaskTests.swift
//  OHMETechTaskTests
//
//  Created by Steve Lai on 20/9/2021.
//

import XCTest
import HandyJSON

@testable import OHMETechTask

class OHMETechTaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testConsumptionDailyRecords() throws{
        let data = OHMETechTaskTests.loadModel(fileName: "unittest_daily_record", fileExt: "json", type: OTDailyConsumptionRecord.self)
        
        XCTAssert(data?.totalConsumption() == 10, "Unit Test - Daily Records totalConsumption falied")
        XCTAssert(data?.consumptionProportion(withId: "001") == 0.1, "Unit Test - Daily Records consumptionProportion falied")
        XCTAssert(data?.consumptionProportion(withId: "002") == 0.2, "Unit Test - Daily Records consumptionProportion falied")
        XCTAssert(data?.consumptionProportion(withId: "005") == 0.4, "Unit Test - Daily Records consumptionProportion falied")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    static func loadModel<T : HandyJSON>(fileName: String, fileExt: String, type: T.Type) -> T? {
        let bundle = Bundle(for: self)
        if let filepath = bundle.path(forResource: fileName, ofType: fileExt) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let response = T.deserialize(from: contents)
                return response
            } catch {
                // contents could not be loaded
                assertionFailure("Mock Utils load model \(type.self) failed with fileName \(fileName)")
            }
        } else {
            assertionFailure("Mock Utils model file not exist")
        }
        return nil
    }
    
}
