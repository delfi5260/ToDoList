//
//  Model.swift
//  ToDoList
//
//  Created by delfi526 on 19/07/2019.
//  Copyright © 2019 delfi526. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
var ToDoItems:[[String:Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
        
    } get {
        if let array =  UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String:Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false){
    ToDoItems.append(["Name": nameItem,"isCompleted": isCompleted])
    setBade()
}
func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
    setBade()
}
// Меняет значек строки на противоположный (Выполнено / Не выполнено)
func changeState(at item: Int) -> Bool{
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    setBade()
    return ToDoItems[item]["isCompleted"] as! Bool
}
// Меняет строки местами
func moveItem (fromIndex: Int, toIndex: Int) {
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}
func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnable, error) in
        if isEnable {
            print("Согласие получено")
        } else {
            print("Получен отказ")
        }
    }
}
func setBade() {
    var totalBadneNumber = 0
    for item in ToDoItems {
        if  !(item["isCompleted"] as! Bool){
            totalBadneNumber += 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadneNumber
}
