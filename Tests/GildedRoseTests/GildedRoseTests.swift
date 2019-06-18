import XCTest
import class Foundation.Bundle
@testable import GildedRose

final class GildedRoseTests: XCTestCase {
    
    func testConjuredAgesTwiceAsFast() {
        let app = itemWithSellinAndQuality(name: "Conjured Mana Cake", sellIn: 10, quality: 10)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 9, quality: 8)
    }

    func testConjuredAgesTwiceAsFast2() {
        let app = itemWithSellinAndQuality(name: "Conjured Mana Cake", sellIn: 10, quality: 1)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 9, quality: 0)
    }

    func testSystemLowersBothValuesForEveryItem() {
        let app = itemWithSellinAndQuality(name: "foo", sellIn: 10, quality: 10)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 9, quality: 9)
    }
    
    func testQualityIsNeverNegative() {
        let app = itemWithSellinAndQuality(name: "foo", sellIn: 10, quality: 0)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 9, quality: 0)
    }
    
    func testOnceTheSellByDatePassedQualityDegradesTwiceAsFast() {
        let app = itemWithSellinAndQuality(name: "foo", sellIn: 0, quality: 10)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: -1, quality: 8)
    }
    
    func testOnceTheSellByDatePassedQualityDegradesTwiceAsFast2() {
        let app = itemWithSellinAndQuality(name: "foo", sellIn: 0, quality: 1)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: -1, quality: 0)
    }
    
    func testAgedBrieIncreasesInQuality() {
        let app = itemWithSellinAndQuality(name: "Aged Brie", sellIn: 10, quality: 10)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 9, quality: 11)
    }

    func testAgedBrieIncreasesInQuality2() {
        let app = itemWithSellinAndQuality(name: "Aged Brie", sellIn: 1, quality: 10)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 0, quality: 11)
    }
    
    func testQualityIsNeverMoreThan50() {
        let app = itemWithSellinAndQuality(name: "Aged Brie", sellIn: 10, quality: 50)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 9, quality: 50)
    }
    
    
    func testSulfurasNeverSoldOrDecreasesInQuality() {
        let app = itemWithSellinAndQuality(name: "Sulfuras, Hand of Ragnaros",
                                           sellIn: 10,
                                           quality: 80)
        self.updateQuality(app)
        thenItemBecomes(app: app, sellIn: 10, quality: 80)
    }
    
    func testBackstagePassesIncreasesInQuality() {
        self.backstagePassQuality(sellIn: 20, startQuality: 10, expectedQuality: 11)
        self.backstagePassQuality(sellIn: 11,startQuality: 10, expectedQuality:  11)
        self.backstagePassQuality(sellIn: 10,startQuality: 10, expectedQuality:  12)
        self.backstagePassQuality(sellIn: 9, startQuality: 10, expectedQuality: 12)
        self.backstagePassQuality(sellIn: 6, startQuality: 10, expectedQuality: 12)
        self.backstagePassQuality(sellIn: 5, startQuality: 10, expectedQuality: 13)
        self.backstagePassQuality(sellIn: 4, startQuality: 10, expectedQuality: 13)
        self.backstagePassQuality(sellIn: 1, startQuality: 10, expectedQuality: 13)
        self.backstagePassQuality(sellIn: 0, startQuality: 10, expectedQuality: 0)
        self.backstagePassQuality(sellIn: -1,startQuality: 10, expectedQuality:  0)
        self.backstagePassQuality(sellIn: 20,startQuality:  50,expectedQuality:  50)
        self.backstagePassQuality(sellIn: 9, startQuality: 50, expectedQuality: 50)
        self.backstagePassQuality(sellIn: 3, startQuality: 50, expectedQuality: 50)
    }
    
    func backstagePassQuality(sellIn: Int, startQuality: Int, expectedQuality: Int) {
        let backstagePass = "Backstage passes to a TAFKAL80ETC concert"
        let app = itemWithSellinAndQuality(name: backstagePass,
                                           sellIn:sellIn,
                                           quality:startQuality)
        self.updateQuality(app)
        XCTAssertEqual(expectedQuality, app.items.first?.quality);
        XCTAssertEqual(sellIn - 1, app.items.first?.sellIn);
    }
    
    func updateQuality(_ app: GildedRose) {
        app.updateQuality()
    }
    
    func itemWithSellinAndQuality(name: String, sellIn: Int, quality: Int) -> GildedRose {
        return GildedRose(items: [Item(name: name, sellIn: sellIn, quality: quality)])
    }
    
    func thenItemBecomes(app: GildedRose, sellIn: Int, quality: Int) {
        XCTAssertEqual(sellIn, app.items.first?.sellIn)
        XCTAssertEqual(quality, app.items.first?.quality)
    }
    
    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testSystemLowersBothValuesForEveryItem", testSystemLowersBothValuesForEveryItem),
            ("testQualityIsNeverNegative", testQualityIsNeverNegative),
            ("testOnceTheSellByDatePassedQualityDegradesTwiceAsFast", testOnceTheSellByDatePassedQualityDegradesTwiceAsFast),
            ("testOnceTheSellByDatePassedQualityDegradesTwiceAsFast2", testOnceTheSellByDatePassedQualityDegradesTwiceAsFast2),
            ("testAgedBrieIncreasesInQuality", testAgedBrieIncreasesInQuality),
            ("testQualityIsNeverMoreThan50", testQualityIsNeverMoreThan50),
            ("testSulfurasNeverSoldOrDecreasesInQuality", testSulfurasNeverSoldOrDecreasesInQuality),
            ("testBackstagePassesIncreasesInQuality", testBackstagePassesIncreasesInQuality)
        ]
    }
}
