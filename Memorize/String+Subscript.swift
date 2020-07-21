//
//  String+Subscript.swift
//  Memorize
//
//  Created by Zhe Liu on 7/18/20.
//  Copyright © 2020 Zhe Liu. All rights reserved.
//

import Foundation

extension String {
    public subscript(x: Int) -> String {
        String(self[index(startIndex, offsetBy: x)])
    }
}
