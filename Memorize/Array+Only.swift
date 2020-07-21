//
//  Array+Only.swift
//  Memorize
//
//  Created by Zhe Liu on 7/16/20.
//  Copyright © 2020 Zhe Liu. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
