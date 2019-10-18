//
//  XCTestManifests.swift
//  NFCPassportReaderAppTests
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Mac. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NFCPassportReaderTests.allTests),
        testCase(DataGroupParsingTests.allTests),
    ]
}
#endif
