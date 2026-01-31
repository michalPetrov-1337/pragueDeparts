import SwiftUI

struct ContentView: View {
    @StateObject private var vm = DeparturesDebugViewModel()

    var body: some View {
        NavigationStack {
           
            VStack(spacing: 12) {

                // BUTTON
                Button("Fetch departures") {
                    Task { await vm.fetchByName() }
                }
                .buttonStyle(.borderedProminent)

                // STATUS TEXT
                Text(vm.statusText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // ERROR TEXT
                if let error = vm.errorText {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // 👉 THIS IS YOUR DEPARTURES BLOCK
                if let board = vm.board,
                   let stopWithDeps = board.stops.first(where: { ($0.departures?.isEmpty == false) }),
                   let departures = stopWithDeps.departures {

                    // STOP NAME
                    Text(stopWithDeps.stop_name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // LIST OF DEPARTURES
                    List(Array(departures.prefix(10))) { dep in
                        HStack {

                            Text(dep.route?.short_name ?? "?")
                                .bold()
                                .frame(width: 44, alignment: .leading)

                            Text(dep.trip?.headsign ?? dep.direction ?? "Unknown")
                                .font(.subheadline)

                            Spacer()

                            if let delay = dep.delay, delay > 0 {
                                Text("+\(delay) min")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .listStyle(.plain)

                } else {
                    Text("No departures found in this response")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer(minLength: 0)

            } // 👈 VStack ENDS HERE
            .padding()
            .navigationTitle("Departures")
        }
    }
}

#Preview {
    ContentView()
}
