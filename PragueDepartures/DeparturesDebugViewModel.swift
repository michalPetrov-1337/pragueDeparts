import Foundation
import Combine

@MainActor
final class DeparturesDebugViewModel: ObservableObject {
    @Published var board: DepartureBoardResponse?
    @Published var errorText: String?
    @Published var statusText: String = "Idle"

    func fetchByName() async {
        statusText = "Fetching…"
        errorText = nil

        do {
            // Muzeum platform example (works reliably)
            let data = try await GolemioClient.shared.departureBoard(
                aswIds: ["400_101"],
                limit: 12
            )

            let decoded = try JSONDecoder().decode(
                DepartureBoardResponse.self,
                from: data
            )

            board = decoded
            statusText = "OK (\(decoded.stops.count) stops)"

            print("Decoded:", decoded)

        } catch {
            board = nil
            statusText = "Failed"
            errorText = "Error: \(error)"
            print("Error:", error)
        }
    }

}
