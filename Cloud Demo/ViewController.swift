//
//  ViewController.swift
//  Cloud Demo
//
//  Created by Ankit Sharma on 26/02/24.
//

import UIKit
import MobileRTC
class ViewController: UIViewController,MobileRTCMeetingServiceDelegate {

    
    var meetingNumber : String?
    var meetingPassword : String?
    var username : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        meetingNumber =  "7411180111"
        meetingPassword =  "-1"
        username = "Pooja Pant Staging 2-3209582507266"
    }

    @IBAction func joinAMeetingButtonPressed(_ sender: Any) {
        joinMeeting(meetingNumber: meetingNumber!, meetingPassword: meetingPassword!, userName: username!)
       }
    
    
    
    func joinMeeting(meetingNumber: String, meetingPassword: String,userName:String) {
            if let meetingService = MobileRTC.shared().getMeetingService() {
                meetingService.delegate = self
                let joinMeetingParameters = MobileRTCMeetingJoinParam()
                joinMeetingParameters.meetingNumber = meetingNumber
                joinMeetingParameters.password = meetingPassword
                joinMeetingParameters.userName = userName
                meetingService.joinMeeting(with: joinMeetingParameters)
            }
        }
    
    
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
           print("Meeting error: (\(error), message: (String(describing: \(message!))")
        if message != "success"{
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       }
       // Is called when the user joins a meeting.
       func onJoinMeetingConfirmed() {
           print("Join meeting confirmed.")
       }
       // Is called upon meeting state changes.
       func onMeetingStateChange(_ state: MobileRTCMeetingState) {
           print("Current meeting state: (\(state)")
       }
}

