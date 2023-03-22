//
//  TableController.swift
//  ImagePicker Bundle. Sandbox. FileManager
//
//  Created by Олеся on 20.03.2023.
//

import UIKit

class TableController: UITableViewController {
    
    private var counter =  1
    
    //    берём путь дериктории
    var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    //    достаем контент из этой дериктории
    var content: [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path)
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        counter += 1
        ImageManager.defaultManager.setPicker(in: self)
        
        ImageManager.defaultManager.saveData = {
            data, urlImage in
            
            do {
                let urlFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "image.jpeg")
                //                + String(self.counter)
                //      let urlDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                //                print(urlDirectory)
                
                try? data.write(to: urlFile)
                //              try  FileManager.default.copyItem(at: urlImage, to: urlDirectory)
                print(urlFile)
                self.tableView.reloadData()
            } catch {
                print("addAction error \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return content.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = content[indexPath.row]
        cell.textLabel?.text = item.description
        cell.detailTextLabel?.text = "Item \(indexPath.row + 1)"
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let path =  path + "/" + content[indexPath.row]
            try?  FileManager.default.removeItem(atPath: path)
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}