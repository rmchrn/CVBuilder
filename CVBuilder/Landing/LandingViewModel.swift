//
//  LandingViewModel.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 27/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import Foundation

class LandingViewModel: NSObject {
    func getProfileData(completion:@escaping (PersonalInfo?, Error?) -> Void) {
        let serviceHandler = ServiceHandler()
        guard let url = URL.init(string: EndPoints.getProfileDataEndpoint) else { return }
        serviceHandler.getProfile(url: url, completion: ({(data: PersonalInfo?, error: Error?) in
            if let personaInfo = data {
                completion(personaInfo, nil)
            } else {
                //No data saved in server
                if let error = error {
                    print("Error while Fetching - Initial Load")
                    completion(nil, error)
                }
            }}))
    }
}
