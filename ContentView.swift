//
//  ContentView.swift
//  TryHealthKit
//
//  Created by Jonathan Ricky Sandjaja on 07/10/22.
//

import SwiftUI
import EventKit
import EventKitUI


struct ContentView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @StateObject var eventKitManager = EventKitManager()
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if vm.isAuthorized {
                    VStack {
                        Text("Today's Step Count")
                            .font(.title3)
                            Text("\(vm.userStepCount)")
                            .font(.title3)
                            .fontWeight(.bold)
                        if var myInt1 = Int(vm.userStepCount), myInt1 > 1000{
                            Text("You are doing a great job!")
                                .font(.title3)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("You are not walking enough")
                                .font(.title3)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            Text("I have scheduled a workout time at your first availability")
                                .font(.title3)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                        }
                    }
                } else {
                    VStack {
                        Text("Please Authorize Health!")
                            .font(.title3)
                        
                        Button {
                            vm.healthRequest()
                        } label: {
                            Text("Authorize HealthKit")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(width: 320, height: 55)
                        .background(Color(.orange))
                        .cornerRadius(10)
                    }
                }
                
            }
            .padding()
            .onAppear {
                vm.readStepsTakenToday()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HealthKitViewModel())
    }
}
