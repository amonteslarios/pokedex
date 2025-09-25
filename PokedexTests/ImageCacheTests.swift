import XCTest
@testable import Pokedex

final class ImageCacheTests: XCTestCase {

    func test_cache_insertsAndReads() {
        // If your project has an ImageCache type, adapt the test to it.
        class ImageCache<Key: Hashable, Value> {
            private let cache = NSCache<WrappedKey, Entry>()
            func insert(_ value: Value, forKey key: Key) {
                cache.setObject(Entry(value), forKey: WrappedKey(key))
            }
            func value(forKey key: Key) -> Value? {
                cache.object(forKey: WrappedKey(key))?.value
            }
            final class WrappedKey: NSObject {
                let key: Key
                init(_ key: Key) { self.key = key }
                override var hash: Int { key.hashValue }
                override func isEqual(_ object: Any?) -> Bool {
                    guard let value = object as? WrappedKey else { return false }
                    return value.key == key
                }
            }
            final class Entry {
                let value: Value
                init(_ value: Value) { self.value = value }
            }
        }

        let cache = ImageCache<String, Data>()
        let data = Data([0,1,2,3])
        cache.insert(data, forKey: "bulbasaur")

        XCTAssertEqual(cache.value(forKey: "bulbasaur"), data)
        XCTAssertNil(cache.value(forKey: "pikachu"))
    }
}
