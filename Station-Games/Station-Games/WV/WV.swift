import SwiftUI
import WebKit


struct WV: UIViewRepresentable {
    let url: URL
    var allowsBackForwardNavigationGestures: Bool = true
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures
        webView.uiDelegate = context.coordinator
        
        webView.customUserAgent = WKWebView().value(forKey: "userAgent") as? String
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKUIDelegate {
        var parent: WV
        
        init(_ parent: WV) {
            self.parent = parent
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
                    WV(url: url)
                        .onAppear {
                            print("encodedString")
                            print("firstOpen", firstOpen)
                            
                            
                        }
                        .onDisappear {
                            
                            nAllow = true
                        }
                }
            } else {
                if let url = Links.shared.finalURL {
                    WV(url: url)
                        .onAppear {
                            print("Links.shared.finalURL")
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

