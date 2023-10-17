//
//  GroupService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 26/06/23.
//

import Foundation

class GroupService {
    static let shared = GroupService()
    
    let defaults = UserDefaults.standard
    
    func getGroups(_ completion: @escaping ([String]?, Error?) -> Void) {
        
        let groupsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getGroups!))"
        
        NetworkCall(data: nil, url: groupsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[String],Error>) in
            switch result{
            case .success(let groups):
                var groupList = groups
                groupList.insert(" ", at: 0)
                completion(groupList, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getGroupProfile(groupName: String, _ completion: @escaping ([String]?, Error?) -> Void) {
        
        guard let encodedgroupName = groupName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            
            return
        }
        
        let groupsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getGroupProfile!))/\(encodedgroupName)"
        
        NetworkCall(data: nil, url: groupsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<GroupProfile,Error>) in
            switch result{
            case .success(let groupProfile):
                
                var cdnList: [String] = [" "]
                groupProfile.dealers.forEach { dealer in
                    cdnList.append("\(dealer.cdDN)")
                }
                completion(cdnList, nil)
                
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}
