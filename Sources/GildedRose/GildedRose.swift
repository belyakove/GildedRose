
public class GildedRose {
    var items:[Item]
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        
        for item in items {
            
            switch item.name {
            case "Aged Brie":
                self.updateBrie(item: item)
            case "Sulfuras, Hand of Ragnaros":
                continue
            case "Backstage passes to a TAFKAL80ETC concert":
                self.updateTickets(item: item)
            case "Conjured Mana Cake":
                self.updateConjured(item: item)
            default:
                self.updateGenericItem(item: item)
            }
        }
    }
    
    func updateGenericItem(item: Item) {
        if (item.sellIn > 0) {
            item.quality = max(0, item.quality - 1)
        } else {
            item.quality = max(0, item.quality - 2)
        }
        item.sellIn -= 1
    }
    
    func updateBrie(item: Item) {
        if (item.sellIn > 0) {
            item.quality = min(50, item.quality + 1)
        } else {
            item.quality = min(50, item.quality + 2)
        }
        item.sellIn -= 1
    }
    
    func updateConjured(item: Item) {
        if (item.sellIn > 0) {
            item.quality = max(0, item.quality - 2)
        } else {
            item.quality = max(0, item.quality - 4)
        }
        item.sellIn -= 1
    }
    
    func updateTickets(item: Item) {
        switch item.sellIn {
        case Int.min...0:
            item.quality = 0
        case 1...5:
            item.quality = min(50, item.quality + 3)
        case 6...10:
            item.quality = min(50, item.quality + 2)
        default:
            item.quality = min(50, item.quality + 1)
        }
        item.sellIn -= 1
    }
}
