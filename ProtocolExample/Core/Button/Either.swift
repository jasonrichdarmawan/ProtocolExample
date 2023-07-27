//
//  Either.swift
//  ProtocolExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/07/23.
//

import Foundation

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}
