import Foundation

enum GolemioError: Error {
    case badStatus(Int)
    case invalidURL
}

final class GolemioClient {
    static let shared = GolemioClient()
    private init() {}

    private let base = "https://api.golemio.cz/v2/pid/departureboards"

    /// Use `aswIds` when you have them (best for favorites).
    func departureBoard(aswIds: [String], limit: Int = 10) async throws -> Data {
        guard var comps = URLComponents(string: base) else { throw GolemioError.invalidURL }
        comps.queryItems = [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "aswIds", value: aswIds.joined(separator: ";"))
        ]

        var req = URLRequest(url: comps.url!)
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue(AppConfig.golemioToken, forHTTPHeaderField: "X-Access-Token")

        let (data, resp) = try await URLSession.shared.data(for: req)
        let status = (resp as? HTTPURLResponse)?.statusCode ?? -1
        guard (200..<300).contains(status) else { throw GolemioError.badStatus(status) }
        return data
    }

    /// Handy for quick testing: the API also supports querying by stop name.
    /// Example shown in slides: `?names=Masarykovo nádraží` :contentReference[oaicite:2]{index=2}
    func departureBoard(names: [String], limit: Int = 10) async throws -> Data {
        guard var comps = URLComponents(string: base) else { throw GolemioError.invalidURL }
        comps.queryItems = [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "names", value: names.joined(separator: ";"))
        ]

        var req = URLRequest(url: comps.url!)
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue(AppConfig.golemioToken, forHTTPHeaderField: "X-Access-Token")

        let (data, resp) = try await URLSession.shared.data(for: req)
        let status = (resp as? HTTPURLResponse)?.statusCode ?? -1
        guard (200..<300).contains(status) else { throw GolemioError.badStatus(status) }
        return data
    }
}
