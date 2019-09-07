//
//  Queue.swift
//  Calculator
//
//  Created by David Park on 8/16/19.
//  Copyright © 2019 David Park. All rights reserved.
//

import Foundation

class Queue{
    
    var head : Node?
    var tail : Node?
    var count : Int!
    
    init() {
        self.count = 0;
    }
    
    func enqueue(data: Node){
        if (count == 3){
            print("Queue full. Please dequeue first for good practice.");
            return;
        }
        
        if (count == 0){
            self.head = data;
            self.tail = data;
            self.count += 1;
        }else{
            self.tail!.next = data;
            self.tail! = data;
            self.count += 1;
        }
        return;
    }
    
    func dequeue() -> Bool{
        if (self.count == 0){
            print("Queue is already empty.");
            return false;
        }else if(self.count == 1){
            self.head = nil;
            self.tail = nil;
            count -= 1;
        }else{
            var tmp = head;
            self.head = self.head!.next;
            tmp = nil;
            count -= 1;
        }
        return true;
    }
}
