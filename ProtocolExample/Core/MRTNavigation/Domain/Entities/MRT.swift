//
//  MRT.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 24/07/23.
//

import Foundation

struct MRT {
    static let stations = [
        MRT.LebakBulusGrab.station,
        MRT.FatmawatiIndomaret.station,
        MRT.CipeteRaya.station,
        MRT.HajiNawi.station,
        MRT.BlokA.station,
        MRT.BlokMBCA.station,
        MRT.ASEAN.station,
        MRT.Senayan.station,
        MRT.IstoraMandiri.station,
        MRT.BendunganHilir.station,
        MRT.SetiabudiAstra.station,
        MRT.DukuhAtasBNI.station,
        MRT.BundaranHI.station
    ]
    
    struct LebakBulusGrab {
        static let station = Station(name: "Lebak Bulus Grab", acronym: "LBB")
    }
    
    struct FatmawatiIndomaret {
        static let station = Station(name: "Fatmawati Indomaret", acronym: "FTM")
    }
    
    struct CipeteRaya {
        static let station = Station(name: "Cipete Raya", acronym: "CPR")
    }
    
    struct HajiNawi {
        static let station = Station(name: "Haji Nawi", acronym: "HJN")
    }
    
    struct BlokA {
        static let station = Station(name: "Blok A", acronym: "BLA")
    }
    
    struct BlokMBCA {
        static let station = Station(name: "Blok M BCA", acronym: "BLM")
    }
    
    struct ASEAN {
        static let station = Station(name: "ASEAN", acronym: "SSM")
    }
    
    struct Senayan {
        static let station = Station(name: "Senayan", acronym: "SNY")
    }
    
    struct IstoraMandiri {
        static let station = Station(name: "Istora Mandiri", acronym: "IST")
    }
    
    struct BendunganHilir {
        static let station = Station(name: "Bendungan Hilir", acronym: "BNH")
    }
    
    struct SetiabudiAstra {
        static let station = Station(name: "Setiabudi Astra", acronym: "STB")
    }
    
    struct DukuhAtasBNI {
        static let station = Station(name: "Dukuh Atas BNI", acronym: "DKA")
    }
    
    struct BundaranHI {
        static let station = Station(name: "Bundaran HI", acronym: "BHI")
    }
}