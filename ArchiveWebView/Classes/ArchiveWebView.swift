
import Foundation
import WebKit

public class ArchiveWebView : WKWebView {
    
    private var sectionArchiveURL: URL? {
        try? FileManager.default.url(for: .cachesDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: true).appendingPathComponent("WebArchives")
    }
    
    public var saveName = ""
    
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        self.navigationDelegate = self
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadRequest(webUrl : String, saveName : String) {
        
        guard let url = URL(string: webUrl) else { return }
        self.saveName = saveName
        
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        
        DispatchQueue.main.async { [weak self] in
        
            if let archiveURL = self?.sectionArchiveURL?.appendingPathComponent(saveName).appendingPathExtension("webarchive"), FileManager.default.fileExists(atPath: archiveURL.path){
                self?.loadFileURL(archiveURL, allowingReadAccessTo: archiveURL)
            }
            else {
                self?.load(urlRequest)
            }
        }
        
    }
    
}

extension ArchiveWebView : WKNavigationDelegate {
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if let cacheURL = sectionArchiveURL, !(FileManager.default.fileExists(atPath: cacheURL.path)), #available(iOS 14.0, *) {
            do {
                try  FileManager.default.createDirectory(at: cacheURL, withIntermediateDirectories: false)
                print("Create dir : \(cacheURL.description)")
            } catch let error {
                print("Create dir error: \(error.localizedDescription)")
            }
            
        }
        
        if let archiveURL = sectionArchiveURL?.appendingPathComponent(saveName).appendingPathExtension("webarchive"),
           !(FileManager.default.fileExists(atPath: archiveURL.path)) , #available(iOS 14.0, *){
            
            DispatchQueue.main.async {
                webView.createWebArchiveData { res in
                    if let data = try? res.get() {
                        do {
                            print("arc ---", archiveURL)
                            try data.write(to: archiveURL)
                        } catch {
                            print("Create file error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        
    }
}

