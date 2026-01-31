import Foundation

final class SharedCache {
    static let appGroupId = "group.com.mPetrov.PragueDepartures"

    private var defaults: UserDefaults {
        UserDefaults(suiteName: Self.appGroupId)!
    }

    func set(_ value: Data, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func data(forKey key: String) -> Data? {
        defaults.data(forKey: key)
    }
}
