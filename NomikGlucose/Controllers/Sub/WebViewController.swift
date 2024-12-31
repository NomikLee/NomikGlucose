//
//  WebViewController.swift
//  NomikGlucose
//
//  Created by Pinocchio on 2024/12/31.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    // MARK: - UI Components
    private let webView: WKWebView = {
        let wb = WKWebView()
        wb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return wb
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    // MARK: - Functions
    public func webSetting(to urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
