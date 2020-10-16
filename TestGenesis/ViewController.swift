import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var pageNumber = 1
    var searchText = ""
    var networking : NetworkingProtocol = Networking()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: [User] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setSearchController()
    }
    private func search() {
        self.networking.search(searchText, pageNumber: pageNumber) { (model) in
            self.model.append(contentsOf: model)
        }
    }
    
    private func setSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "serch"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func showTutorial(_url: String) {
        guard let url = URL(string: _url) else {return}
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        let url = item.html_url
        model[indexPath.row].isWatch = true
        showTutorial(_url: url)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = model[indexPath.row]
        cell.textLabel?.text = item.full_name
        if item.isWatch ?? false {
            cell.contentView.backgroundColor = .lightGray
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.count - 1 {
            self.pageNumber += 1
            search()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text , !text.isEmpty else {return}
        self.model = []
        self.searchText = text
        search()
        searchBar.searchTextField.resignFirstResponder()
    }
}
