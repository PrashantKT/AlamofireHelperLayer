# AlamofireHelperLayer

<h3>Very Clean and managed structure </h3>

<h2>Helper to Call Webservice with ease (You need approx 15 Mins to make it run) </h2>

How to install 

1) Drag and drop API Helpers in your project
2) Goto APIRouter and add your webservice caes like added in example for login

Call like below 

For Json 

	{
 	 "Message": "Login Success",
 	 "Status": true,
 	 "Data": {
 	 	  "Username": "tukadiyaprashant@gmail.com",
  	 	 "IsvalidUser": "True",
  	 	 "token": "isrpe"
	  }
	  
	}
	
Create Codable general class 

	import Foundation


	struct GeneralResponse<T:Codable>: Codable {
	    let message: String
	    let status: Bool
	    let data: T

	    enum CodingKeys: String, CodingKey {
		case message = "Message"
		case status = "Status"
		case data = "Data"
	    }

	}

And 

	import Foundation

	struct User: Codable {
	    let username, isvalidUser, token: String

	    enum CodingKeys: String, CodingKey {
		case username = "Username"
		case isvalidUser = "IsvalidUser"
		case token
	    }
	}


Call it with 


    func callWSToLogin() {
        APIClient.login(userName: "test", password: "test") { (test:GeneralResponse<User>?, error:Error?) in
        
        }
    }
    
   
 ## Donation
If this project help you reduce time to develop, you can give me a cup of coffee  :) 

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/prashantkt)


