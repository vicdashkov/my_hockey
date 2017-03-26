//
//  Utils.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-29.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
