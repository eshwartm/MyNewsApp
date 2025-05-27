import UIKit
import SwiftUI
import Combine

class Battery: ObservableObject {
    @Published var percentage: Int = 100
    
    func drain() {
        if percentage > 0 {
            percentage -= 10
        }
    }
    
    func charge() {
        if percentage < 100 {
            percentage += 10
        }
    }
}

struct BatteryStatusView: View {
    @ObservedObject var battery: Battery // passed in from the parent
    
    var body: some View {
        VStack {
            Text("Battery percentage: \(battery.percentage)")
                .font(.largeTitle)
            HStack {
                Button("Drain") {
                    self.battery.drain()
                }
                
                Button("Charge") {
                    self.battery.charge()
                }
            }
            .padding()
        }
    }
}

struct BatteryManagerView: View {
    
    @StateObject var battery = Battery()
    
    var body: some View {
        VStack {
            Text("Battery Manager")
                .font(.headline)
            BatteryStatusView(battery: battery)
        }
    }
}



