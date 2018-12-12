import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var confirmEmailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    @IBOutlet weak var unmatchEmail: UILabel!
    @IBOutlet weak var unmatchPsswrd: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
//    var theTruth: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        unmatchEmail.text = ""
        unmatchPsswrd.text = ""
        
        if
            self.emailText.text! == self.confirmEmailText.text! &&
            self.passwordText.text! == self.confirmPasswordText.text! &&
            self.emailText.text != "" &&
            self.passwordText.text != "" &&
            self.confirmEmailText.text != "" &&
            self.confirmPasswordText.text != ""
        {
            Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordText.text!) { (authResult, error) in
                if authResult != nil
                {
                    print("User has signed up")
                    self.unmatchEmail.text = ""
                    self.unmatchPsswrd.text = ""
                    self.performSegue(withIdentifier: "registeredtologin", sender: self)
                }
                if error != nil
                {
                    if let error = error as NSError?
                    {
                        guard let errors = AuthErrorCode(rawValue: error.code) else
                        {
                            return
                        }
                        
                        switch errors
                        {
                            case .invalidEmail:
                                self.unmatchEmail.text = "invalid email"
                            case .emailAlreadyInUse:
                                self.unmatchEmail.text = "email already in used"
                            case .weakPassword:
                                self.unmatchPsswrd.text = "weak password"
                            default:
                                print("Error Signing up")
                        }
                    }
                }
                guard let user = authResult?.user else {return}
            }
        }
        if self.emailText.text != self.confirmEmailText.text
        {
            self.unmatchEmail.text = "The emails do not match!"
        }
        if self.passwordText.text != self.confirmPasswordText.text
        {
            self.unmatchPsswrd.text = "The passwords do not match!"
        }
        if self.confirmEmailText.text == "" || self.emailText.text == ""
        {
            self.unmatchEmail.text = "Please fill in the email fields"
        }
        if  self.confirmPasswordText.text == "" || self.passwordText.text == ""
        {
            self.unmatchPsswrd.text = "Please fill in the pass fields"
        }
    }
}
