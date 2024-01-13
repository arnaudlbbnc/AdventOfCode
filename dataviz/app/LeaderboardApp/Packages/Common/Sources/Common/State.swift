//
//  State.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 13/11/2023.
//

import Foundation

public enum State<T> {
    case loading
    case error
    case loaded(T)
}
