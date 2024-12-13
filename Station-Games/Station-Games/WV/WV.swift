import SwiftUI
import WebKit


struct WV: UIViewRepresentable {
    let initialURL: URL
    var allowsBackForwardNavigationGestures: Bool = true
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures
        webView.customUserAgent = WKWebView().value(forKey: "userAgent") as? String
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: initialURL)
        webView.load(request)
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate {

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if let url = webView.url {
                //print("Final Loaded URL: \(url)")
                if Links.shared.finalURL == nil {
                    Links.shared.finalURL = url
                }
               
            }
        }
        
        // This method gets called whenever the web view starts loading a new request
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
               // print("Navigating to URL: \(url)")
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
}

struct WVWrap: View {
    @State private var nAllow = true
    var urlString = ""
    @AppStorage("firstOpen") var firstOpen = true
    
    var body: some View {
        ZStack {
            if firstOpen {
                if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let url = URL(string: encodedString) {
                    WV(initialURL: url)
                        .onAppear {
                            print("encodedString")
                            print("firstOpen", firstOpen)
                        }
                        .onDisappear {
                            print("onDisappear")
                            firstOpen = false
                            nAllow = true
                        }
                }
            } else {
                if let url = Links.shared.finalURL {
                    WV(initialURL: url)
                        .onAppear {
                            print("Links.shared.finalURL:", url)
                            print("firstOpen", firstOpen)
                        }
                } else {
                    Text("Error")
                        .onAppear {
                            print("Error")
                            firstOpen = true
                        }
                }
                
            }
            
            
        }.onAppear {
            checkFirstLaunch()
        }
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedKey = "hasLaunchedBefore"
        if UserDefaults.standard.bool(forKey: hasLaunchedKey) {
            // Not the first launch
            firstOpen = false
        } else {
            // First launch
            firstOpen = true
            UserDefaults.standard.set(true, forKey: hasLaunchedKey)
        }
    }
}

