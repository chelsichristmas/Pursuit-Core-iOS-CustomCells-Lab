import UIKit

class UserViewController: UIViewController {
    
    var randomUsers = [User](){
        didSet {
            
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
    }
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else {
            fatalError("Could not deqeue reusable cell")
        }
        
        
        return cell
    }
    
    
}
