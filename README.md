# AlamofireHelperLayer
Helper to Call Webservice with ease


override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIClient.login(userName: "username", password: "password") { (response) in
            switch response {
            case .success(let json) :
                print(json)
            case .failure(let error) :
                print("error \(error)" )
            }
        }
        
    }
