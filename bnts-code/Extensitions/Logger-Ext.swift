//
//  Logger-Ext.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation
import os

extension Logger {
    init(for className: AnyClass) {
        self.init(subsystem: "com.bnts-code", category: className.description())
        info("Logger init for \(className.description())")
    }
}
