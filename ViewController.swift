//
//  ViewController.swift
//  shek11
//
//  Created by greens technology on 22/10/21.
//  Copyright © 2021 greens technology. All rights reserved.
//

import UIKit
import AMDots

    //class Event {
    struct Root: Codable {
        let login : String?
        let id : Int?
        let node_id : String?
        let url : String?
    }
    //init(dic: [String: Any]) {
    //if let id = dic["id"] as? String {
    //    self.id = id
    //}
    //}
    //}


    class ViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
        @IBOutlet weak var tableview: UITableView!
        

        
        private var dotsView: AMDots!
        
        
        let link = "https://api.github.com/users/hadley/orgs"
        var arr = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dotsView = AMDots(frame: CGRect(x: 100, y: 350, width: 150, height: 70),
                                      colors: [.red, .blue, .yellow, .green])
                dotsView.backgroundColor = UIColor.white
             dotsView.animationType = .shake
                view.addSubview(dotsView)

                dotsView.start()
                
                getData()
                // Do any additional setup after loading the view.
            }
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 100
            }

             override func didReceiveMemoryWarning() {
                 super.didReceiveMemoryWarning()
                 // Dispose of any resources that can be recreated.
             }
             
             
             func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                 print(self.arr.count)
                 return self.arr.count
             }
             
             func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! TableViewCell
                cell.label.text = "\(self.arr[indexPath.row])"
                 return cell
             }
             
             func getData(){
                
                 
        //               dotsView = AMDots(frame: CGRect(x: 100, y: 350, width: 150, height: 70),
        //                                     colors: [.red, .blue, .yellow, .green])
        //               dotsView.backgroundColor = UIColor.white
        //               dotsView.animationType = .scale
        //               view.addSubview(dotsView)
        //
        //               dotsView.start()
                
                 guard let url = URL(string: link) else {return}
                 let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                   
                     guard error == nil else { return }
                     guard let dat = data else {return}
                    
        //           self.dotsView.stop()
                    
                     do{
                         let content = try JSONDecoder().decode([Root].self, from: dat)
                   print(content)
                         for items in content {
                         self.arr.append(items.login!)
                         self.arr.append(items.node_id!)
                             self.arr.append(items.id!)
                            self.arr.append(items.url!)
                         }
                         DispatchQueue.main.async {
                            self.dotsView.stop()
                        
                            self.tableview.reloadData()
                         }
                         
                     }catch{
                         print(error)
                     }
                     
                 }
                 task.resume()
        // Do any additional setup after loading the view.
    }


}


