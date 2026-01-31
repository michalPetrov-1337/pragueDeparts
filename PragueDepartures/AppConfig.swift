import Foundation

enum AppConfig {
    static var golemioToken: String {
        let token = ProcessInfo.processInfo.environment["GOLEMIO_TOKEN"] ?? ""
        return token
    }
}
