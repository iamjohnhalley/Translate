//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var languageSelected: UILabel!
    @IBOutlet weak var translate: UIButton!
    
    
    var Array = ["Spanish", "French", "German"]
    var languageAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.textToTranslate.layer.cornerRadius = 5;
        self.translatedText.layer.cornerRadius = 5;
        self.translate.layer.cornerRadius = 5;
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array [row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageAnswer = row
    }
    
    
    
    @IBAction func translate(_ sender: AnyObject) {
        
        
    if (languageAnswer == 0)
        {
            
            let str = textToTranslate.text
            let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let langStr = ("en|fr").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
            
            let url = URL(string: urlStr)
            
            let request = URLRequest(url: url!)// Creating Http Request
            
            //var data = NSMutableData()var data = NSMutableData()
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.center = view.center
            view.addSubview(indicator)
            indicator.startAnimating()
            
            var result = "<Translation Error>"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                
                indicator.stopAnimating()
                
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        
                        let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        
                        if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                            let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                            
                            result = responseData.object(forKey: "translatedText") as! String
                        }
                    }
                    
                    self.translatedText.text = result
                }
            }
   
        }
        
    else  if (languageAnswer == 1)
       
    {
            
            
            
            let str = textToTranslate.text
            let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let langStr = ("en|spa").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
            
            let url = URL(string: urlStr)
            
            let request = URLRequest(url: url!)// Creating Http Request
            
            //var data = NSMutableData()var data = NSMutableData()
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.center = view.center
            view.addSubview(indicator)
            indicator.startAnimating()
            
            var result = "<Translation Error>"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                
                indicator.stopAnimating()
                
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        
                        let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        
                        if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                            let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                            
                            result = responseData.object(forKey: "translatedText") as! String
                        }
                    }
                    
                    self.translatedText.text = result
                }
            }
            
            
            
            
            
        }
    
    
     else
        
    {
        
        let str = textToTranslate.text
        let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let langStr = ("en|fr").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)// Creating Http Request
        
        //var data = NSMutableData()var data = NSMutableData()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        var result = "<Translation Error>"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            
            indicator.stopAnimating()
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 200){
                    
                    let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                    
                    if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                        let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                        
                        result = responseData.object(forKey: "translatedText") as! String
                    }
                }
                
                self.translatedText.text = result
            }
            }
        
        }
    
    }
    
    
   
}










