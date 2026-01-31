import Foundation

// Root response
struct DepartureBoardResponse: Codable {
    let stops: [Stop]
}

// Stop (platform / node)
struct Stop: Codable, Identifiable {
    let stop_id: String
    let stop_name: String
    let stop_lat: Double
    let stop_lon: Double
    let asw_id: ASWId?
    let departures: [Departure]?

    var id: String { stop_id }
}

// ASW identifier used for querying departures later
struct ASWId: Codable {
    let node: Int?
    let stop: Int?
}

// Individual departure
struct Departure: Codable, Identifiable {
    let departure_timestamp: String?
    let arrival_timestamp: String?
    let delay: Int?
    let platform_code: String?
    let direction: String?
    let route: Route?
    let trip: Trip?

    var id: String {
        departure_timestamp ?? UUID().uuidString
    }
}

// Line info
struct Route: Codable {
    let short_name: String?
    let type: Int?
}

// Destination info
struct Trip: Codable {
    let headsign: String?
}
