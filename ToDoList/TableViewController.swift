//
//  TableViewController.swift
//  ToDoList
//
//  Created by delfi526 on 19/07/2019.
//  Copyright © 2019 delfi526. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    // Кномпка Eddit
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
        self.tableView.reloadData()}
    }
    // Кнопка +
    @IBAction func pushAddAction(_ sender: Any) {
        // Создание строки ввода
          let alertController =  UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "New item name" // Текст подсказка когдастрока пустая
                
        }
            let aletrAction1 = UIAlertAction(title: "Cancel", style: .default) // Кнопка ничего не возвращает работает как закрыть
        
 
            let aletrAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
                //Добавить новую запись
               let newItem = alertController.textFields![0].text
               addItem(nameItem: newItem!)
                self.tableView.reloadData()
                
        }
            
            alertController.addAction(aletrAction1)
            alertController.addAction(aletrAction2)
            present(alertController, animated: false, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() // Убирает лишние пустые строки в таблице
        tableView.backgroundColor = UIColor.groupTableViewBackground // Задник таблицы слегка серый
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.count
    }
    
    // Дейсвие со строкой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String // Задаем строковое значение лейблу
        
        if (currentItem["isCompleted"] as? Bool)! { // меняет try это check картинка и наоборот
            cell.imageView?.image = #imageLiteral(resourceName: "check")
            cell.imageView?.alpha = 0.6
            cell.textLabel?.alpha = 0.6
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "uncheck")
            cell.imageView?.alpha = 1
            cell.textLabel?.alpha = 1
        }
        
      /*  if tableView.isEditing {
            cell.textLabel?.alpha = 0.6
            cell.imageView?.alpha = 0.6
            
        } else {
            cell.textLabel?.alpha = 1
            cell.imageView?.alpha = 1
        } */ // вариант с затухание в режиме Edit

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view. В режиме Edit дейсвие с кнопками
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{ // Если кнопка Удалить то
            // Delete the row from the data source
            removeItem(at: indexPath.row) // удалить элемент
            tableView.deleteRows(at: [indexPath], with: .fade) // Удалить строку из талбицы
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // Обработка нажатий на строку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // отменяет выделение строки (Эффект нажатия)
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check")
            tableView.cellForRow(at: indexPath)?.imageView?.alpha = 0.6
            tableView.cellForRow(at: indexPath)?.textLabel?.alpha = 0.6
        }else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "uncheck")
            tableView.cellForRow(at: indexPath)?.imageView?.alpha = 1
            tableView.cellForRow(at: indexPath)?.textLabel?.alpha = 1
        }
    }
   
    
    // Override to support rearranging the table view. В режиме Edit меняет строки местами
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
      
    }
    
    // В режиме Edit справа иконки удаление / добавление / ничего
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
        return .none
        } else {
            return .delete
        }
    }
     // Смещение лейбл строки в право в режиме Edit да/нет
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
       
        return false
    }

}
