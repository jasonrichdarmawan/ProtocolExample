//
//  MRT.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

struct MRT {
    static let beaconUUID = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
    
    static let stations = [
        LebakBulusGrab.station,
        FatmawatiIndomaret.station,
        CipeteRaya.station,
        HajiNawi.station,
        BlokA.station,
        BlokMBCA.station,
        ASEAN.station,
        Senayan.station,
        IstoraMandiri.station,
        BendunganHilir.station,
        SetiabudiAstra.station,
        DukuhAtasBNI.station,
        BundaranHI.station
    ]
    
    struct LebakBulusGrab {
        static let station = Station(
            name: "Lebak Bulus Grab",
            acronym: "LBB",
            major: 0
        )
    }
    
    struct FatmawatiIndomaret {
        static let station = Station(
            name: "Fatmawati Indomaret",
            acronym: "FTM",
            major: 1
        )
    }
    
    struct CipeteRaya {
        static let station = Station(
            name: "Cipete Raya",
            acronym: "CPR",
            major: 2
        )
    }
    
    struct HajiNawi {
        static let station = Station(
            name: "Haji Nawi",
            acronym: "HJN",
            major: 3
        )
    }
    
    struct BlokA {
        static let station = Station(
            name: "Blok A",
            acronym: "BLA",
            major: 4
        )
    }
    
    struct BlokMBCA {
        static let station = Station(
            name: "Blok M BCA",
            acronym: "BLM",
            major: 5
        )
    }
    
    struct ASEAN {
        static let station = Station(
            name: "ASEAN",
            acronym: "SSM",
            major: 6
        )
    }
    
    struct Senayan {
        static let station = Station(
            name: "Senayan",
            acronym: "SNY",
            major: 7
        )
    }
    
    struct IstoraMandiri {
        static let station = Station(
            name: "Istora Mandiri",
            acronym: "IST",
            major: 8
        )
    }
    
    struct BendunganHilir {
        static let station = Station(
            name: "Bendungan Hilir",
            acronym: "BNH",
            major: 9
        )
    }
    
    struct SetiabudiAstra {
        static let station = Station(
            name: "Setiabudi Astra",
            acronym: "STB",
            major: 10
        )
    }
    
    struct DukuhAtasBNI {
        static let station = Station(
            name: "Dukuh Atas BNI",
            acronym: "DKA",
            major: 11
        )
    }
    
    struct BundaranHI {
        static let station = Station(
            name: "Bundaran HI",
            acronym: "BHI",
            major: 12
        )
    }
}
