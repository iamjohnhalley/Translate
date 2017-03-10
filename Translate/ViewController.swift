//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit
import AVFoundation




class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var languageSelected: UILabel!
    @IBOutlet weak var translate: UIButton!
    
   
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var Array = ["Spanish", "French", "German"]
    var languageAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Rounding the edges on TextView
        self.textToTranslate.layer.cornerRadius = 5;
        self.translatedText.layer.cornerRadius = 5;
        self.translate.layer.cornerRadius = 5;
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.textToTranslate.delegate = self

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func close() {
        IJProgressView.shared.hideProgressView()
    }
    
    
    
    func setCloseTimer() {
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(close), userInfo: nil, repeats: false)
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
        languageSelected.text = Array[row]
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //hide keybaord when clicking away
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //return key to hide keyboard
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        
        self.textToTranslate.resignFirstResponder()
        return (true)
    }
    
    //textview : resign keyboard
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text:String) -> Bool {
        if (text == "\n")
        {
            textToTranslate.resignFirstResponder()
            return false
        }
        
         return true
    }
    
    // placeholder text
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textToTranslate.text == "Translate here")
        {
            textToTranslate.text = ""
        }
        textToTranslate.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
 
        if(textToTranslate.text == "")
        {
            textToTranslate.text = "Translate here"
        }
        textToTranslate.resignFirstResponder()
    }
    
    
    // UIPicker View : customise
    
   func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let titleData = Array[row]
    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 14.0)!,NSForegroundColorAttributeName:UIColor.white])
    return myTitle
    }

    
 // Selecting a language using the picker view

    @IBAction func translate(_ sender: AnyObject) {
        
    
    if (languageAnswer == 0)
        {
            
            let str = textToTranslate.text
            let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let langStr = ("en|spa").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
            
            let url = URL(string: urlStr)
            
            let request = URLRequest(url: url!)// Creating Http Request
            
            IJProgressView.shared.showProgressView(view)
            
            
            
            var result = "<Translation Error>"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                
                IJProgressView.shared.hideProgressView()
                
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
            
            let langStr = ("en|fr").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
            
            let url = URL(string: urlStr)
            
            let request = URLRequest(url: url!)// Creating Http Request
            
            //var data = NSMutableData()var data = NSMutableData()
            
        IJProgressView.shared.showProgressView(view)

        
            
            var result = "<Translation Error>"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                
               IJProgressView.shared.hideProgressView()
                
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
        
        let langStr = ("en|de").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)// Creating Http Request
        
        //var data = NSMutableData()var data = NSMutableData()
        
        
        IJProgressView.shared.showProgressView(view)
        
        
       
        
        var result = "<Translation Error>"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            
            
            IJProgressView.shared.hideProgressView()
            
            
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
    
    
    //text to speach button

    @IBAction func speach(_ sender: Any) {
        
        if (languageAnswer == 0)
        
        {
            
            let utterace = AVSpeechUtterance(string: translatedText.text!)
            utterace.voice = AVSpeechSynthesisVoice(language: "es")
            utterace.rate = 0.5;
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterace);
            
        }
        
        
         else if (languageAnswer == 1)
            
        {
            
            let utterace = AVSpeechUtterance(string: translatedText.text!)
            utterace.voice = AVSpeechSynthesisVoice(language: "fr")
            utterace.rate = 0.5;
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterace);
            
        }
        
        
        else if (languageAnswer == 2) {
    
            let utterace = AVSpeechUtterance(string: self.translatedText.text!)
            utterace.voice = AVSpeechSynthesisVoice(language: "de")
            utterace.rate = 0.5;
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterace);
        }
        }
    
    
    
//    let request = NSMutableURLRequest(url: URL(string: "YOUR_URL_HERE" ,param: param))!,
//    cachePolicy: .useProtocolCachePolicy,
//    timeoutInterval:60)
//    request.httpMethod = "POST" // POST ,GET, PUT What you want
//    
//    let session = URLSession.shared
//    
//    
//    
//    let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
//        
//        do {
//            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                print("ASynchronous\(jsonResult)")
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        
//    }
//    dataTask.resume()
    


    
    
}
    














