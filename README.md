# AlamofireHelperLayer
Helper to Call Webservice with ease

How to install 

1) Drag and drop API Helpers in your project
2) Goto APIRouter and add your webservice caes like added in example for login

Call like below 


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
