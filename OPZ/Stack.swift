//
//  Stack.swift
//  OPZ
//
//  Created by lazarenko_lo on 26.06.2021.
//

import Foundation
class Stack<T>
{
    private var list = [T?]()
    public func push(element: T)
    {
        list.append(element)
    }
    public func pop() -> T?
    {
        if list[list.count - 1] == nil {
            return nil
        }
        return list[list.count - 1]
    }
    public func isEmpty() -> Bool
    {
       return list[list.count - 1] == nil ?  true :  false
    }
    public func Back() -> T?
    {
        return list[list.count - 1]
    }
    public func Length() -> Int
    {
        return list.count
    }
}
