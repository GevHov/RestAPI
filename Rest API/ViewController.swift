//
//  ViewController.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import UIKit

class ViewController: UIViewController  {

    private var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - API EndPoint
        let urlString = "https://randomuser.me/api/?"
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            debugPrint("URL is nil")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { ( data, respose, error ) in
            if error == nil && data != nil {
                //Pars JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    let user = try decoder.decode(User.self, from: data!)
                    print("This is Json result -->\(user)")
                    
                } catch {
                    
                    debugPrint("Error is JSON parsing!")
                    print()
                }
            }
        }
        //MARK: - API Call
        dataTask.resume()
    }
}

