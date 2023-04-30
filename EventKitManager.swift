//
//  EventStoreAccess.swift
//  TryHealthKit
//
//  Created by Reggie Easton on 4/29/23.
//
/*
import EventKit
import Foundation
import SwiftUI

class EventKitManager: ObservableObject {

    var store = EKEventStore()
    var events: [EKEvent] = []

    init() {
        requestAccessToCalendar()
        todaysEvents()
    }

    func requestAccessToCalendar() {
        store.requestAccess(to: .event) { success, error in

        }
    }

    func todaysEvents() {
        let calendar = Calendar.autoupdatingCurrent
        let startDate = Date.now
        var onDayComponents = DateComponents()
        onDayComponents.day = 1
        let endDate = calendar.date(byAdding: onDayComponents, to: .now)!
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        events = store.events(matching: predicate)

    }
}
*/
//
//  EventKitStore.swift
//  TryHealthKit
//
//  Created by Reggie Easton on 4/30/23.
//


/* second attempt
import Foundation
import EventKit
import SwiftUI


class EventKitManager: ObservableObject {
    // create an instance of EKEventStore
    
    init() {
        requestAccessToCalendar()
        
    }
    
    // request access to the user's calendar
    func requestAccessToCalendar() {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                // create a calendar object for the current date and time zone
                let calendar = Calendar.current
                let timeZone = TimeZone.current
                let startDate = Date()
                let endDate = calendar.date(byAdding: .day, value: 7, to: startDate)!
                
                // create a predicate for searching events within the time range
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
                
                // fetch events that occur within the time range
                let events = eventStore.events(matching: predicate)
                
                // create an array of busy time ranges
                var busyRanges: [DateInterval] = []
                for event in events {
                    let busyRange = DateInterval(start: event.startDate, end: event.endDate)
                    busyRanges.append(busyRange)
                }
                
                // set the desired meeting duration (in minutes)
                var meetingduration = 0
                
                if myInt1 < 1000 {
                    meetingduration = 45 // 45 minutes
                } else if myInt1 < 3000 {
                    meetingduration = 30 // 0.5 hour
                }
                else if myInt1 < 5000 {
                    meetingduration = 10 // 10 minutes
                }
                else {
                    meetingduration = 00 //
                }
                
                let busyStart1 = Date().addingTimeInterval(3600) // 1 hour from now
                let busyEnd1 = busyStart1.addingTimeInterval(7200) // 2 hours meeting
                let busyStart2 = busyEnd1.addingTimeInterval(3600) // 1 hour break
                let busyEnd2 = busyStart2.addingTimeInterval(10800) // 3 hours meeting
                let calendar = Calendar.current
                let searchStart = calendar.date(byAdding: .day, value: 1, to: Date())!
                let searchEnd = calendar.date(byAdding: .day, value: 7, to: searchStart)!
                
                // create a DateInterval for finding free time
                let busyRanges = [DateInterval(start: busyStart1, end: busyEnd1), DateInterval(start: busyStart2, end: busyEnd2)]
                let searchRange = DateInterval(start: searchStart, end: searchEnd)

                var freeRanges: [DateInterval] = []

                for busyRange in busyRanges {
                    // Get the intersection between the search range and the busy range
                    let intersection = searchRange.intersection(with: busyRange)

                    // If there is no intersection, the entire search range is free
                    if intersection == nil {
                        freeRanges.append(searchRange)
                    } else {
                        // Get the free time before the busy interval
                        let start = searchRange.start
                        let end = intersection!.start
                        let freeBefore = DateInterval(start: start, end: end)

                        // Get the free time after the busy interval
                        let start = intersection!.end
                        let end = searchRange.end
                        let freeAfter = DateInterval(start: start, end: end)

                        // Add the free time to the list
                        if freeBefore.duration >= meetingduration {
                            freeRanges.append(freeBefore)
                        }
                        if freeAfter.duration >= meetingduration {
                            freeRanges.append(freeAfter)
                        }
                    }
                }

                // Filter out free time periods that are too short for the meeting duration
                freeRanges = freeRanges.filter { $0.duration >= Double(meetingduration * 60) }

      
                // find free time intervals that are at least the desired meeting duration
                
                // if there are free time intervals, create an event at the first available interval
                if let firstFreeRange = freeRanges.first {
                    let event = EKEvent(eventStore: eventStore)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    event.title = "Meeting"
                    event.startDate = firstFreeRange.start
                    event.endDate = firstFreeRange.start.addingTimeInterval(TimeInterval(meetingduration * 60))

                    do {
                        try eventStore.save(event, span: .thisEvent)
                        print("Event added to calendar")
                    } catch let error as NSError {
                        print("Error adding event to calendar: \(error.localizedDescription)")
                    }
                } else {
                    print("No free time available")
                }
            } else {
                print("Access to calendar denied")
            }
        }
    }
}*/

import Foundation
import EventKit
import SwiftUI
import EventKitUI

 class EventKitManager: ObservableObject {
    // create an instance of EKEventStore



    init() {
        requestAccessToCalendar()
    }
    
    // request access to the user's calendar
    func requestAccessToCalendar() {
        
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                // create a calendar object for the current date and time zone
                let calendar = Calendar.current
                //let timeZone = TimeZone.current
                let startDate = Date()
                let endDate = calendar.date(byAdding: .day, value: 7, to: startDate)!
                
                // create a predicate for searching events within the time range
                let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
                
                // fetch events that occur within the time range
                let events = eventStore.events(matching: predicate)
                
                // create an array of busy time ranges
                var busyRanges: [DateInterval] = []
                let startTime = Date()
                let endTime = startDate.addingTimeInterval(3 * 60 * 60)
                let busyRange = DateInterval(start: startTime, end: endTime)
                    busyRanges.append(busyRange)
                
                // set the desired meeting duration (in minutes)
                var meetingDuration = 30
                
                
                // create a DateInterval for finding free time
                let searchRange = DateInterval(start: startDate, end: endDate)
                // find free time intervals that are at least the desired meeting duration
                var freeRanges: [DateInterval] = []
                var start = searchRange.start
                for busyRange in busyRanges {
                    let end = busyRanges[0].start
                    let freeInterval = DateInterval(start: start, end: end)
                    if freeInterval.duration >= Double(meetingDuration * 60) {
                        freeRanges.append(freeInterval)
                    }
                    start = busyRange.end
                }
                let end = searchRange.end
                let lastFreeInterval = DateInterval(start: start, end: end)
                if lastFreeInterval.duration >= Double(meetingDuration * 60) {
                    freeRanges.append(lastFreeInterval)
                }
                
                // if there are free time intervals, create an event at the first available interval
                if let firstFreeRange = freeRanges.first {
                    let event = EKEvent(eventStore: eventStore)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    event.title = "Workout"
                    
                    event.startDate = firstFreeRange.start
                    event.endDate = firstFreeRange.start.addingTimeInterval(Double(meetingDuration * 60))
                    
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        print("Event added to calendar")
                    } catch let error as NSError {
                        print("Error adding event to calendar: (error.localizedDescription)")
                    }
                    
                } else {
                    print("No free time available")
                }
            } else {
                print("Access to calendar denied")
            }
        }
    }
}
