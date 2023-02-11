//
//  DetailView.swift
//  DailyHacks
//
//  Created by Smil on 09/02/23.
//

import SwiftUI
import WebKit


struct DetailView: View {
    let url:String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.github.com").ignoresSafeArea()
    }
}

struct WebView:UIViewRepresentable{
    let urlString: String?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()

    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString{
            if let url = URL(string: safeString){
                let request =  URLRequest(url: url)
                uiView.load(request)
            }
        }else{
            let url = URL(string: "https://mugambijavan.github.io/404-page/")
            let request =  URLRequest(url: url!)
            uiView.load(request)
        }
    }
    
}
