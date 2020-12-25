//
//  DeleteLessonResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 25/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct OpTime: Codable {
    var ts: String?
    var t: Int?
}

struct ClusterTime: Codable {
    var clusterTime: String
}

struct Signature: Codable {
    var hash: String?
    var keyId: String?
}

struct DeleteLessonResponse: Codable {
    var n: Int?
    var opTime: OpTime?
    var electionId: String?
    var ok: Int?
    var clusterTime: ClusterTime?
    var signature: Signature?
    var operationTime: String?
    var deletedCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case n
        case opTime
        case electionId
        case ok
        case clusterTime = "$clusterTime"
        case signature
        case operationTime
        case deletedCount
    }
    
    func isSuccess() -> Bool {
        return self.ok == 1
    }
}
