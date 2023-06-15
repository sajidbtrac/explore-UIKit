//
//  DetailWebView.swift
//  Project16
//
//  Created by BTSL.SAJID on 15/6/23.
//

import UIKit
import WebKit

class DetailWebView: UIViewController {
    @IBOutlet weak var detailWebView: WKWebView!
    
    var url: String! = nil
    
    override func loadView() {
        guard let validURL = URL(string: url) else { return }
        let webView = WKWebView()
        webView.load(URLRequest(url: validURL))
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
                
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
