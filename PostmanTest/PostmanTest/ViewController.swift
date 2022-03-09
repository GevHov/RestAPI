//
//  ViewController.swift
//  PostmanTest
//
//  Created by Gevorg Hovhannisyan on 23.11.21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
        
    var result: [Welcome] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        return tableView

    }()
    
    private var data = [String]()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTE0MDE4NjAsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.bVgiJVd9ZUOKqAfxcyOPjdfUuyINEbO6LYUHZrt21o0"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]

        
        AF.request("https://api.malls.team/api/General/MainPage",method: .get, encoding: JSONEncoding.default, headers: headers) .responseJSON { response in
            
            print(response)
            debugPrint(response)
            
            switch response.result {
                
            case .success(_):
                do {
                    let responsee = try JSONDecoder().decode(Welcome.self, from: response.data!)
                    responsee.adsWithCategories.forEach {
                        print($0.ads.first?.name as Any)
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key \(key) not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value \(value) not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type \(type) mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            case .failure(_):
                print("Error")
            }
        }
    }
}

//MARK: - Extensions
extension ViewController: UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if result.count - 2 == indexPath.row {
            
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

  










//    func getWelcome() {
//
//        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTE0MDE4NjAsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.bVgiJVd9ZUOKqAfxcyOPjdfUuyINEbO6LYUHZrt21o0", forHTTPHeaderField: "Authorization")
//        let session = URLSession.shared
//        let url = URL(string: "https://api.malls.team/api/General/MainPage")
//        let task = session.dataTask(with: url!) { (data, response, error) in
//            if error != nil || data == nil {
//                print("Client Error!")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200...299) .contains(response.statusCode) else {
//                print("Server Error!")
//                return
//            }
//            guard let mime = response.mimeType, mime == "application/json" else {
//                print("Wrong MIME Type")
//                return
//            }
//            do {
//
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(json)
//
//            }catch{
//
//                print("JSON error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//}



/*
 //MARK: - Func getAdsWithCategories()
 func getWelcome(url: String) {
     AF.request(url, method: .get)
         .responseJSON {
             response in
             switch response.result {
             case .success(_):
                 do {
                     let responsee = try JSONDecoder().decode(Welcome.self, from: response.data!)
//                        print("response", responsee)
                     responsee.adsWithCategories.forEach {
                         print($0.ads)
                     }
                 } catch let DecodingError.dataCorrupted(context) {
                     print(context)
                 } catch let DecodingError.keyNotFound(key, context) {
                     print("Key \(key) not found:", context.debugDescription)
                     print("codingPath:", context.codingPath)
                 } catch let DecodingError.valueNotFound(value, context) {
                     print("Value \(value) not found:", context.debugDescription)
                     print("codingPath:", context.codingPath)
                 } catch let DecodingError.typeMismatch(type, context)  {
                     print("Type \(type) mismatch:", context.debugDescription)
                     print("codingPath:", context.codingPath)
                 } catch {
                     print("error: ", error)
                 }
             case .failure(let error):
                 print(error)
             }
         }
 }
}
 */
