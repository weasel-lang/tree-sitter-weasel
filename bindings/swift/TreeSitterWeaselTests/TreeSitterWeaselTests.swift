import XCTest
import SwiftTreeSitter
import TreeSitterWeasel

final class TreeSitterWeaselTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_weasel())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loadingWeasel grammar")
    }
}
