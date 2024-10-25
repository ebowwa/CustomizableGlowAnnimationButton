// CustomizableButton+WebsocketActivationButtonApp.swift
import SwiftUI

@main
struct WebsocketActivationButton: App {
    @StateObject private var viewModel = ButtonViewModel()
    
    var body: some Scene {
        WindowGroup {
            CustomView(viewModel: viewModel)
        }
    }
}

import SwiftUI

class ButtonViewModel: ObservableObject {
    @Published var isButtonPressed: Bool = false
    @Published var isSocketReadyForAudio: Bool = false // Bool to track socket readiness
    
    func toggleButtonState() {
        isButtonPressed.toggle()
    }
    
    // Function to simulate AI socket readiness
    func setSocketReady() {
        isSocketReadyForAudio = true
    }
    
    func resetSocketReady() {
        isSocketReadyForAudio = false
    }
}

// -------- EXAMPLE VIEW --------------

import SwiftUI

struct CustomView: View {
    @ObservedObject var viewModel: ButtonViewModel
    @State private var showToast: Bool = false // Control the toast visibility
    
    var body: some View {
        ZStack {
            // Background content
            Color.gray.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer() // Pushes the button to the right
                    CustomizableButton(
                        icon: "ear.badge.waveform",
                        gradientStart: .blue,
                        gradientEnd: .purple,
                        borderColor: .blue,
                        iconColor: .white,
                        buttonSize: 120,
                        iconSize: 50,
                        isSFSymbol: true
                    )
                    .onTapGesture {
                        viewModel.toggleButtonState()
                    }
                }
                Spacer() // Pushes the button to the top
            }
            
            // Toast Notification at the bottom when socket is ready
            if showToast {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("AI Socket is ready!")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        Spacer()
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(), value: showToast)
                    Spacer().frame(height: 50) // Adds space from the bottom edge
                }
            }
        }
        .onAppear {
            // Simulate socket readiness after a delay (for demonstration purposes)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.setSocketReady()
                showToast = true
                // Auto-hide toast after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showToast = false
                }
            }
        }
    }
}
