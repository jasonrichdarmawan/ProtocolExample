[LoFi, HiFi, Prototype](https://www.figma.com/file/YYsNa16jRdHbOHHMoPREeP/MRT-Jakarta-Navigation?type=design&node-id=0%3A1&mode=design&t=mVYUCc8HBF6CJfJz-1)

# Component Oriented Design

User Stories:
```
1. User gets vibration and/or sound notification when arrive in destiantion.
2. User gets vibration and/or sound notification when near any station when in initial mode and app in background mode (Have not started navigation).
3. User gets vibration and/or sound notification when a train arrive in departure station when in commuting mode (Have started navigation)
4. User gets vibration and/or sound notification when arrive in a transit station when in commuting mode.
```

Workflow:
1. Project Manager do vertical slicing by selecting the 1st user story.
```
1. User able to start navigation by selecting departure station and destination (High priority).
2. Notify user when arrived in destination when app in background mode (High priority).
3. Notify user when arrived in destination when app in foreground mode (High priority).
```

2. UI/UX Designer creates LoFi by defining what user can do and what user can see in a specific Screen. Use Shape and Text tools in Figma. No local variables, no local styles, no components.
```
What user can see:
1. Departure station and destination.

What user can do:
1. Change the departure station and destination by clicking the buttton.
```

3. UI/UX Designer creates design style guide.

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

5. UI/UX Designer creates HiFi component for the departure and arrival button using components.
```
What departure and arrival button looks like in clickable and focused mode.
```

6. Software Engineer creates the component's code.

Component's coding style guide:
1. Use Binding.
2. Use `#if DEBUG #endif` for the preview.
3. The preview is not just to preview the component. But to preview how to use the component in a screen.

DepartureArrivalView.swift
```swift
struct DepartureArrivalView: View {
    @Binding var value: String
    @Binding var selected: Bool
    
    var body: some View {
        Button {
            selected = true
        } label: {
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
        }
        .selectedButtonStyle(selected)
        .padding(16)
    }
}
```

The screen's view model example
```swift
private final class DepartureArrivalViewModel_Example: ObservableObject {
    @Published var departure = "Departure"
    @Published var arrival = "Arrival"
    @Published var departureSelected = false
    
    func updateDepartureArrival(value: String) {
        if departureSelected {
            departure = value
        } else {
            arrival = value
        }
    }
}
```

The screen's view example
```swift
private struct DepartureArrivalViewExample: View {
    @StateObject private var viewModel = DepartureArrivalViewModel_Example()
    
    var body: some View {
        VStack(spacing: 0) {
            DepartureArrivalView(value: $viewModel.departure, selected: $viewModel.departureSelected)
            DepartureArrivalView(
                value: $viewModel.arrival,
                selected: Binding(
                    get: { return !viewModel.departureSelected },
                    set: { newValue in viewModel.departureSelected = !newValue }))
            
            VStack(alignment: .leading, spacing: 0) {
                Button("Stasiun Lebak Bulus Grab") {
                    viewModel.updateDepartureArrival(value: "Stasiun Lebak Bulus Grab")
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
                
                Button("Stasiun Fatmawati Indomaret") {
                    viewModel.updateDepartureArrival(value: "Stasiun Fatmawati Indomaret")
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
    }
}
```

The preview
```swift
struct DepartureArrivalViewExample_Previews: PreviewProvider {
    static var previews: some View {
        DepartureArrivalViewExample()
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
b. BeaconBroadcaster (to simulate)
```

Use Case protocol's coding style guide:
1. use delegate pattern if you wish to return a result asynchronously.
2. a function should return an actionable result i.e. `Bool` or `enum`.
3. If function can't return a result, use completion pattern i.e. `func start(completionHandler: @escaping (Bool) -> Void)`
4. a function should have documentation comments if the behavior is peculiar i.e. `the finder stop after finding any station once`. 
5. a function should use delegate pattern if the behavior is peculiar to return actionable result i.e. `.FINDER_GRACEFULLY_STOP` event.

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

How to use `NotifyWhenNearMRTStationWithGPS` and `NotifyWhenNearMRTStationWithBluetooth` in `NotifyWhenNearMRTStationAndSpecificMRTStationOnce`?

NotifyWhenNearMRTStationAndSpecificMRTStationOnceImpl.swift

Protocol implementation's coding style guide:
1. `init` function should have default value.
2. if `init` use static default value, the implementation should have `deinit` closure.

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
4. The Domain layer splitted into 3 layers: the Entities layer, the Repositories layer the UseCases layer.
```
The Entities layer is used by the Components and the ViewModel layer. i.e. `struct Station {}`
The UseCases layer is used by the ViewModel layer.
The Repositories layer is used by the UseCases layer and the DataSource layer. The purpose it to convert Data layer's model to Domain layer's entity.
```
4. The Data layer splitted into 2 layers: the Models layer and the DataSource layer.
```
The Models layer is used by the Repositories layer and the DataSource layer. The purpose is to define what is expected result from the DataSource layer. i.e. a API response.
The DataSource layer is used by the Repositories layer. The purpose it to get data from somewhere. i.e. from local storage or from an API.
```

Important: the Repositories layer and the Data layer is optional if the data can be hard coded, then hard code it.