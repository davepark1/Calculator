//
//  Node.swift
//  Calculator
//
//  Created by David Park on 8/16/19.
//  Copyright © 2019 David Park. All rights reserved.
//

import Foundation

class Node{
    var calculation : String!
    var next : Node?
    
    init(calculation : String){
        self.calculation = calculation;
        self.next = nil;
    }
}
