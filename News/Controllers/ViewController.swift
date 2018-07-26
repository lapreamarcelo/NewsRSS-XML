//
//  ViewController.swift
//  News
//
//  Created by Marcelo on 25/7/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var news: [News] = []
    let url = "https://feeds.bbci.co.uk/news/world/rss.xml"

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "OpenWeb" {
            let destination = segue.destination as? BrowserViewController
            destination?.webURL = sender as? String
        }
        
    }
    
    private func setup() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 60)

        self.navigationItem.titleView = imageView
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
    private func fetchNews() {
        guard let rssURL = URL(string: url) else {
            return
        }
        
        Parser().parseFromURL(url: rssURL) { (news) in
            self.loader.stopAnimating()
            self.news = news
            self.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else {
            fatalError("Wrong cell configuration")
        }
        
        cell.setup(news: news[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsURL = news[indexPath.row].newsURL
        
        performSegue(withIdentifier: "OpenWeb", sender: newsURL)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
}

