import UIKit

class UserViewController: UIViewController {
    
    var randomUsers = [User](){
        didSet {
            DispatchQueue.main.async{
                self.userView.tableView.reloadData()
            }
        }
    }
    
    private let userView = UserView()
    
    override func loadView() {
        view = userView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userView.tableView.delegate = self
        userView.tableView.dataSource = self
        userView.tableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
        fetchUsers()
    }
    
    private func fetchUsers() {
        UsersFetchingService.manager.getUsers { (result) in
            switch result {
            case .failure(let appError):
                print("error fetching podcasts: \(appError)")
            case .success(let users):
                self.randomUsers = users
            }
        }
    }
   
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else {
            fatalError("Could not deqeue reusable cell")
        }
        
        var randomUser = randomUsers[indexPath.row]
        cell.textLabel?.text = "\(randomUser.name.title)\(randomUser.name.first)\(randomUser.name.last)"
        
        return cell
    }
    
    
}
