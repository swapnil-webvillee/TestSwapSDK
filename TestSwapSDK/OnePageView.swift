//
//  OnePageView.swift
//  TestSwapSDK
//
//  Created by WebvilleeMAC on 05/04/18.
//  Copyright © 2018 Webvillee. All rights reserved.
//

import UIKit

public class OnePageView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIWebViewDelegate {
    
    
    var collectionViewObject:UICollectionView! = nil
    var webViewBase:UIView! = nil
    var web = UIWebView()
    var arrNews = NSArray()
    var indicator = UIActivityIndicatorView()
    var isViewLoaded = false
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // fatalError("init(coder:) has not been implemented")
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !isViewLoaded {
            drawLayers()
        }
    }
    
    func drawLayers()  {
        isViewLoaded = true
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 50))
        headerView.backgroundColor = .gray
        self.addSubview(headerView)
        
        let btn = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 30, height: 30))
        //            btn.backgroundColor = .lightGray
        btn.setTitle("X", for: .normal)
        btn.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        headerView.addSubview(btn)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.collectionViewObject = UICollectionView.init(frame: CGRect.init(x: 0, y: 50, width: self.frame.size.width, height: self.frame.size.height),collectionViewLayout: layout)
        self.addSubview(collectionViewObject)
        collectionViewObject.delegate = self
        collectionViewObject.dataSource = self
        collectionViewObject.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        collectionViewObject.register(pager.self, forCellWithReuseIdentifier: "collectionCell")
        
        webViewBase = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height))
        webViewBase.backgroundColor = .white
        self.addSubview(webViewBase)
        self.getNews()
        
    }
    
    func showWebView()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.webViewBase.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
        }) { (result) in
            self.web = UIWebView.init(frame: CGRect.init(x: 0, y: 30, width: self.frame.size.width, height: self.frame.size.height-30))
            let urlReq = URLRequest.init(url: URL.init(string: "https://www.wittyfeed.com")!)
            self.web.delegate = self
            self.web.loadRequest(urlReq)
            self.webViewBase.addSubview(self.web)
            
            let webViewBaseHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 30))
            webViewBaseHeader.backgroundColor = #colorLiteral(red: 0, green: 0.4431372549, blue: 0.737254902, alpha: 1)
            self.webViewBase.addSubview(webViewBaseHeader)
            
            
            let btn = UIButton.init(frame: CGRect.init(x: 10, y: 0, width: 30, height: 30))
            //            btn.backgroundColor = .lightGray
            btn.setTitle("X", for: .normal)
            btn.addTarget(self, action: #selector(self.hideWebView), for: .touchUpInside)
            
            webViewBaseHeader.addSubview(btn)
        }
    }
    
    @objc func hideWebView()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.webViewBase.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
            
        }) { (result) in
            self.web.removeFromSuperview()
            if self.indicator.isAnimating {
                self.indicator.stopAnimating()
                self.indicator.removeFromSuperview()
                self.indicator = UIActivityIndicatorView()
            }
        }
    }
    
    @objc func backAction(){
        print("Back action called")
        
        DelegateClassSwap.shared.callDelegate()
    }
    //MARK: Collection delgate + datasource
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalCell:CGFloat = 2.0
        let spaceBetweenCells:CGFloat = 10.0
        _ = (collectionView.bounds.size.width - max(0, totalCell - 1)*spaceBetweenCells)/totalCell
        let dim = (collectionView.bounds.size.width - (totalCell - 1) * spaceBetweenCells) / totalCell;
        return CGSize(width: dim, height: 200)
        
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrNews.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // let cell =  UICollectionViewCell()
        
        
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        //        let img_view = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        //        img_view.contentMode = .scaleAspectFill
        //        img_view.clipsToBounds = true
        //
        //        switch indexPath.item {
        //        case 0:
        //            img_view.image = #imageLiteral(resourceName: "imgFeed")
        //            break
        //        case 5:
        //            img_view.image = #imageLiteral(resourceName: "home_bg")
        //            break
        //        case 12:
        //            img_view.image = #imageLiteral(resourceName: "13346759_1074256525971885_528255319599754059_n")
        //            break
        //        default:
        //            img_view.image = #imageLiteral(resourceName: "Health")
        //            break
        //        }
        //
        //        cell.contentView.addSubview(img_view)
        //        return cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! pager
        
        let newsDict = self.arrNews.object(at: indexPath.item) as! NSDictionary
        let name = String.init(format: "%@", newsDict.object(forKey: "title") as! CVarArg)
        let imageStr = String.init(format: "%@", newsDict.object(forKey: "urlToImage") as! CVarArg)
        cell.arrImage.downloadedFrom(link: imageStr)
        cell.lblTitle.text = name
        
        return cell
        
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showWebView()
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //MARK: Webview delgates
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        if indicator.isAnimating {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            indicator = UIActivityIndicatorView()
            
        }
        indicator.frame = CGRect.init(x: self.frame.size.width/2-20, y: self.frame.size.height/2-20, width: 40, height: 40)
        indicator.color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        if indicator.isAnimating {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            indicator = UIActivityIndicatorView()
            
        }
    }
    
    //MARK: Call Webservice
    
    func getNews() {
        if indicator.isAnimating {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            indicator = UIActivityIndicatorView()
        }
        indicator.frame = CGRect.init(x: self.frame.size.width/2-20, y: self.frame.size.height/2-20, width: 40, height: 40)
        indicator.color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.addSubview(indicator)
        indicator.startAnimating()
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=05b89c3373c0450286ccadfd98405ce2")!
        var req = URLRequest.init(url: url)
        req.httpMethod = "GET"
        req.timeoutInterval = 60
        
        //req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConf)
        let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            
            if httpResponse != nil
            {
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil)
            {
                print(error!)
                print(lastPath)
                
            }
            else
            {
                //print(httpResponse!)
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("resulted json", json)
                    DispatchQueue.main.async
                        {
                            self.indicator.stopAnimating()
                            self.indicator.removeFromSuperview()
                            self.arrNews = (json as! NSDictionary).object(forKey: "articles") as! NSArray
                            self.collectionViewObject.reloadData()
                    }
                }
                catch
                {
                    print("json error: \(error)")
                    
                }
            }
            
            
        }
        
        dataTask.resume()
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
