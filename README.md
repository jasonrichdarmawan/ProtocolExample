# Contents

1. [Component Oriented Design](#component-oriented-design)
2. [LoFi, HiFi, Prototype in Figma](https://www.figma.com/file/YYsNa16jRdHbOHHMoPREeP/MRT-Jakarta-Navigation?type=design&node-id=0%3A1&mode=design&t=mVYUCc8HBF6CJfJz-1)
3. [Protocol Orineted Programming](#protocol-oriented-programming)
4. [Use Case Oriented Programming](#use-case-oriented-programming)
5. [Clean Architecture](#clean-architecture-programming)

# Component Oriented Design

User Stories:
```
1. User gets vibration and/or sound notification when arrive in destination.
2. User gets vibration and/or sound notification when near any station when in initial mode and app in background mode (Have not started navigation).
3. User gets vibration and/or sound notification when a train arrive in departure station when in commuting mode (Have started navigation)
4. User gets vibration and/or sound notification when arrive in a transit station when in commuting mode.
```

Workflow:
1. Project Manager do vertical development by slicing the 1st user story into 3 use cases.
```
User Story:
1. User gets vibration and/or sound notification when arrive in destination.

Use Cases:
1. User able to start navigation by selecting departure station and destination (High priority).
2. Notify user when arrived in destination when app in background mode (High priority).
3. Notify user when arrived in destination when app in foreground mode (High priority).
```

2. UI/UX Designer creates the LoFi by defining what user can do and what user can see in a specific Screen. Use Shape and Text tools in Figma. No local variables, no local styles, no components.
```
What user can see:
1. Departure station and destination.

What user can do:
1. Change the departure station and destination by clicking the buttton.
```

3. UI/UX Designer creates the design style guide.

Primitives Color
```
red/0 = #FF000000, red/10 = #8B0000, red/20 = #800000
blue/0 = #0000FF, blue/10 = #0000CD, blue/20 = #00008B
green/0 = #008000, green/10 = #006400, green/20 = #ADFF2F.
white/0 = #FFFFFF
black/0 = #000000
```

Tokenized Color
```
clickableButtonBackground: Any = blue/0, Dark = blue/0
clickableButtonText: Any = white/0, Dark = white/0

focusedButtonText: Any = blue/0, Dark = blue/0
focusedButtonStroke: Any = black/0, Dark = black/0
```

4. Software Engineer register the tokenized colors
```
clickableButtonBackground: Any = #0000FF, Dark = #0000FF
clickableButtonText: Any = #FFFFFF, Dark = #FFFFFF

focusedButtonText: Any = #0000FF, Dark = #0000FF
focusedButtonStroke: Any = #000000, Dark = #000000
```

5. UI/UX Designer creates the HiFi component for the departure and arrival button using components.
```
What departure and arrival button looks like in clickable and focused mode.
```

6. Software Engineer creates the component's code.

Component's coding style guide:
1. Use `@Binding` / `@ObservedObject`
2. Use `#if DEBUG #endif` for the preview.
3. The preview is not just to preview the component. But to preview how to use the component in a screen.

DepartureArrivalView.swift
```swift
struct DepartureArrivalView: View {
    @ObservedObject private var viewModel: DepartureArrivalViewModel
    
    init(viewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            DepartureOrArrivalButtonView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            DepartureOrArrivalButtonView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
        }
    }
}
```

DepartureArrivalView+DepartureArrivalButtonView.swift
```swift
extension DepartureArrivalView {
    struct DepartureOrArrivalButtonView: View {
        @Binding var value: Station
        @Binding var selected: Bool
        
        var body: some View {
            Button {
                selected = true
            } label: {
                Text("\(value.name) Station")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
            }
            .selectedButtonStyle(selected)
            .padding(16)
        }
    }
}
```

Use ViewModel if you have more than 1 variable to observe.

Important: 1 ViewModel per responsibility i.e. a View used 2 ViewModels:
1. a ViewModel `to handle the departure, arrival variables`
2. a ViewModel `to handle the nearest schedule at departure and estimated time arrival at destination variables`

DepartureArrivalViewModel.swift
```swift
final class DepartureArrivalViewModel: ObservableObject {
    @Published var departure: Station
    @Published var arrival: Station
    
    @Published var departureSelected: Bool
    var arrivalSelected: Bool {
        get {
            return !departureSelected
        }
        set {
            departureSelected = !newValue
        }
    }
    
    init(departure: Station = MRT.LebakBulusGrab.station, arrival: Station = MRT.DukuhAtasBNI.station, departureSelected: Bool = false) {
        self.departure = departure
        self.arrival = arrival
        self.departureSelected = departureSelected
    }
    
    func updateDepartureArrival(value: Station) {
        switch departureSelected {
        case true:
            // swap
            if arrival == value {
                arrival = departure
            }
            
            departure = value
        case false:
            // swap
            if departure == value {
                departure = arrival
            }
            
            arrival = value
        }
    }
}
```

The preview
```swift
private struct DepartureArrivalViewExample: View {
    @StateObject private var viewModel: DepartureArrivalViewModel
    
    init(viewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(viewModel: viewModel)
            
            VStack(alignment: .leading, spacing: 0) {
                Button("\(MRT.LebakBulusGrab.station.name) Station") {
                    viewModel.updateDepartureArrival(value: MRT.LebakBulusGrab.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.FatmawatiIndomaret.station.name) Station") {
                    viewModel.updateDepartureArrival(value: MRT.FatmawatiIndomaret.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("\(MRT.CipeteRaya.station.name) Station") {
                    viewModel.updateDepartureArrival(value: MRT.CipeteRaya.station)
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
    }
}

struct DepartureArrivalViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalViewExample()
            .environment(\.locale, .init(identifier: "id-ID"))
    }
}
```

# Protocol Oriented Programming

Workflow:
1. Software Engineer creates protocol for every use cases of the 1st story.
```
1. NotifyWhenNearMRTStationAndSpecificMRTStationOnce, requires:
a. NotifyWhenNearMRTStationWithGPS
b. NotifyWhenNearMRTstationWithBluetooth
c. AlarmManager (able to vibrate and/or play audio in background and foreground mode)

2. NotifyWhenNearMRTStationOnce, requires:
a. NotifyWhenNearMRTStationWithGPS
b. NotifyWhenNearMRTStationWithBluetooth

3. NotifyWhenNearMRTStationWhenInBackground, requires:
a. NotifyWhenNearMRTStationWithGPS
b. NotifyWhenNearMRTStationWithBluetooth
c. NotificationManager

4. NotifyWhenNearMRTStationWithGPS, requires:
a. LocationFinder

5. NotifyWhenMRTStationWithBluetooth, requires:
a. BeaconFinder

6. BeaconBroadcaster (to simulate)
```

Use Case protocol's coding style guide:
1. use delegate pattern if you wish to return a result asynchronously.

NotifyWhenNearMRTStationWithGPS.swift
```swift
protocol NotifyWhenNearMRTStationWithGPS {
    var delegate: NotifyWhenNearMRTStationWithGPSDelegate? { get set }
    
    func start() -> NotifyWhenNearMRTStationWithGPSStartEvent
    func stop() -> NotifyWhenNearMRTStationWithGPSStopEvent
}

protocol NotifyWhenNearMRTStationWithGPSDelegate {
    /// will notify once per station.
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithGPS, didFind: Station)
}

protocol NotifyWhenNearMRTStationWithGPSEvent {}

enum NotifyWhenNearMRTStationWithGPSStartEvent: NotifyWhenNearMRTStationWithGPSEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationWithGPSStopEvent: NotifyWhenNearMRTStationWithGPSEvent { case IS_STOPPING }
```

2. a function should return an actionable result i.e. `Bool` or `enum`.

3. If function can't return a result, use completion pattern i.e. `func start(completionHandler: @escaping (Bool) -> Void)`

NotificationManager.swift
```swift
protocol NotificationManager {
    /// please show alert in view if return false
    func isAuthorizedOrRequestAuthorization(completionHandler: @escaping (Bool) -> Void)
    
    func push(title: String, subtitle: String, sound: UNNotificationSound?, completionHandler: @escaping (Bool) -> Void)
    func reset() -> NotificationManagerResetEvent
}

protocol NotificationManagerEvent {}

enum NotificationManagerPushEvent: NotificationManagerEvent { case IS_PUSHING, NOT_AUTHORIZED }

enum NotificationManagerResetEvent: NotificationManagerEvent { case IS_RESETTING }
```
4. a function should have documentation comments if the behavior is peculiar i.e. `the finder stop after finding any station once`. 

NotifyWhenNearMRTStationWithBluetooth.swift
```swift
protocol NotifyWhenNearMRTStationWithBluetooth {
    var delegate: NotifyWhenNearMRTStationWithBluetoothDelegate? { get set }
    
    func start() -> NotifyWhenNearMRTStationWithBluetoothStartEvent
    func stop() -> NotifyWhenNearMRTStationWithBluetoothStopEvent
}

protocol NotifyWhenNearMRTStationWithBluetoothDelegate {
    // will update once per station
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithBluetooth, didFind: Station)
}

protocol NotifyWhenNearMRTStationWithBluetoothEvent {}

enum NotifyWhenNearMRTStationWithBluetoothStartEvent: NotifyWhenNearMRTStationWithBluetoothEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationWithBluetoothStopEvent: NotifyWhenNearMRTStationWhenInBackgroundEvent { case IS_STOPPING }
```

5. a function should use delegate pattern if the behavior is peculiar to return actionable result i.e. `.FINDER_GRACEFULLY_STOP` event.

NotifyWhenNearMRTStationAndSpecificMRTStationOnce.swift
```swift
protocol NotifyWhenNearMRTStationAndSpecificMRTStationOnce {
    var delegate: NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegate? { get set }
    
    /// will stop when found specific MRT station
    func start(arrival: Station) -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStartEvent
    /// for abrupt stop.
    func stop() -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStopEvent
}

enum NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegateEvent { case FOUND, ARRIVED }

protocol NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationAndSpecificMRTStationOnce, didFind station: Station, didEvent event: NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegateEvent)
}

protocol NotifyWhenNearMRTStationAndSpecificMRTStationOnceEvent {}

enum NotifyWhenNearMRTStationAndSpecificMRTStationOnceStartEvent: NotifyWhenNearMRTStationAndSpecificMRTStationOnceEvent { case IS_STARTING, NOT_AUTHORIZED }

enum NotifyWhenNearMRTStationAndSpecificMRTStationOnceStopEvent: NotifyWhenNearMRTStationAndSpecificMRTStationOnceEvent { case IS_STOPPING }
```

# Use Case Oriented Programming

Use Case Oriented Programming enables you to focus on 1 specific business logic (i.e. `NotifyWhenNearMRTStationWithGPS.swift` and `NotifyWhenNearMRTStationWithBluetooth.swift`). Then, you can write a business logic to do "if Bluetooth is not available, use GPS" in a dedicated use case `NotifyWhenNearMRTStationAndSpecificMRTStationOnce.swift`

Protocol implementation's coding style guide:
1. `init` function should have default value.
2. if `init` use static variable as default value, the implementation should have `deinit` closure.
3. the static variable should live in a final class Manager. By doing so, when you want to change the implementation logic, you can replace the shared variable's value.

NotificationManager.swift
```swift
final class NotificationManager {
    static var shared: Notification = NotificationImpl()
}
```

NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl.swift
```swift
final class NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl: NotifyWhenNearMRTStationAndSpecificMRTStationOnce {
    var delegate: NotifyWhenNearMRTStationAndSpecificMRTStationOnceDelegate?
    
    private var notifyWhenNearMRTStationWithBluetooth: NotifyWhenNearMRTStationWithBluetooth
    private var notifyWhenNearMRTStationWithGPS: NotifyWhenNearMRTStationWithGPS
    
    private var currentStation: Station?
    
    private var arrival: Station?
    
    init(
        notifyWhenNearMRTStationWithBluetooth: NotifyWhenNearMRTStationWithBluetooth = NotifyWhenNearMRTStationWithBluetoothImpl(),
        notifyWhenNearMRTStationWithGPS: NotifyWhenNearMRTStationWithGPS = NotifyWhenNearMRTStationWithGPSImpl()
    ) {
        self.notifyWhenNearMRTStationWithBluetooth = notifyWhenNearMRTStationWithBluetooth
        self.notifyWhenNearMRTStationWithGPS = notifyWhenNearMRTStationWithGPS
        
        self.notifyWhenNearMRTStationWithBluetooth.delegate = self
        self.notifyWhenNearMRTStationWithGPS.delegate = self
    }
    
    func start(arrival: Station) -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStartEvent {
        self.arrival = arrival
        return .IS_STARTING
    }
    
    func stop() -> NotifyWhenNearMRTStationAndSpecificMRTStationOnceStopEvent {
        return .IS_STOPPING
    }
}

extension NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl: NotifyWhenNearMRTStationWithBluetoothDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithBluetooth, didFind station: Station) {
        if currentStation == station { return }
        
        currentStation = station
        
        if arrival == station { _ = stop() }
        
        delegate?.notifyManager(self, didFind: station, didEvent: arrival == station ? .ARRIVED : .FOUND)
    }
}

extension NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl: NotifyWhenNearMRTStationWithGPSDelegate {
    func notifyManager(_ manager: NotifyWhenNearMRTStationWithGPS, didFind station: Station) {
        if currentStation == station { return }
        
        currentStation = station
        
        if arrival == station { _ = stop() }
        
        delegate?.notifyManager(self, didFind: station, didEvent: arrival == station ? .ARRIVED : .FOUND)
    }
}
```

# Clean Architecture Programming

1. Code is split into 3 layers: the Presentation layer, the Domain layer and the Data layer.
2. The Presentation layer splitted into 3 layers: the Components layer, the ViewModel layer and the Pages layer.
```
The Components layer is used by the Pages layer.
The ViewModel layer is used by the Pages layer. The purpose is to provide data to the Pages layer.
The Pages layer should be as simple as it can.
```

a. The Pages layer

DepartureArrivalPage.swift
```swift
struct DepartureArrivalPage: View {
    @StateObject private var viewModel: DepartureArrivalV2ViewModel
    
    init(viewModel: DepartureArrivalV2ViewModel = DepartureArrivalV2ViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalV2View(viewModel: viewModel)
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}
```

b. The ViewModels layer

DepartureArrivalV2ViewModel.swift
```swift
final class DepartureArrivalV2ViewModel: ObservableObject {
    @Published var departure: Station
    @Published var arrival: Station?
    
    @Published var departureSelected: Bool
    var arrivalSelected: Bool {
        get {
            return !departureSelected
        }
        set {
            departureSelected = !newValue
        }
    }
    
    init(departure: Station = MRT.LebakBulusGrab.station, arrival: Station? = nil, departureSelected: Bool = false) {
        self.departure = departure
        self.arrival = arrival
        self.departureSelected = departureSelected
    }
    
    func updateDepartureArrival(value: Station) {
        switch departureSelected {
        case true:
            // swap
            if arrival == value {
                arrival = departure
            }
            
            departure = value
        case false:
            // swap
            if departure == value {
                if let arrival {
                    departure = arrival
                }
            }
            
            arrival = value
        }
    }
}
```

c. The Components layer

DepartureArrivalView.swift
```swift
struct DepartureArrivalView: View {
    @ObservedObject private var viewModel: DepartureArrivalViewModel
    
    init(viewModel: DepartureArrivalViewModel = DepartureArrivalViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            DepartureOrArrivalButtonView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            DepartureOrArrivalButtonView(value: $viewModel.arrival, selected: $viewModel.arrivalSelected)
        }
    }
}
```

use `+` to indicate the use of the extension keyword. In this case, a subcomponent of a component.

DepartureArrivalView+DepartureArrivalButtonView.swift
```swift
extension DepartureArrivalView {
    struct DepartureOrArrivalButtonView: View {
        @Binding var value: Station
        @Binding var selected: Bool
        
        var body: some View {
            Button {
                selected = true
            } label: {
                Text("\(value.name) Station")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
            }
            .selectedButtonStyle(selected)
            .padding(16)
        }
    }
}
```

4. The Domain layer splitted into 3 layers: the Entities layer, the Repositories layer the UseCases layer.
```
The Entities layer is used by the Components and the ViewModel layer. i.e. `struct Station {}`
The UseCases layer is used by the ViewModel layer.
The Repositories layer is used by the UseCases layer and the DataSource layer. The purpose it to convert Data layer's model to Domain layer's entity.
```

5. The Data layer splitted into 2 layers: the Models layer and the DataSource layer.
```
The Models layer is used by the Repositories layer and the DataSource layer. The purpose is to define what is expected result from the DataSource layer. i.e. a API response.
The DataSource layer is used by the Repositories layer. The purpose it to get data from somewhere. i.e. from local storage or from an API.
```

Important: the Repositories layer and the Data layer is optional if the data can be hard coded, then hard code it.
