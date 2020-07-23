//
//  ParcelModel.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import Foundation


struct ParcelModel : Codable {
    let tracking_number : String?
    let service : String?
    let type : String?
    let status : String?
    let custom_attributes : Custom_attributes?
    let tracking_details : [Tracking_details]?
    let expected_flow : [String]?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case tracking_number = "tracking_number"
        case service = "service"
        case type = "type"
        case status = "status"
        case custom_attributes = "custom_attributes"
        case tracking_details = "tracking_details"
        case expected_flow = "expected_flow"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}


struct Tracking_details : Codable {
    let status : String?
    let origin_status : String?
    let agency : String?
    let datetime : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case origin_status = "origin_status"
        case agency = "agency"
        case datetime = "datetime"
    }
}

struct Target_machine_detail : Codable {
    let name : String?
    let opening_hours : String?
    let location_description : String?
    let location : Location?
    let address : Address?
    let type : [String]?
    let location247 : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case opening_hours = "opening_hours"
        case location_description = "location_description"
        case location = "location"
        case address = "address"
        case type = "type"
        case location247 = "location247"
    }
    
}

struct Location : Codable {
    let latitude : Double?
    let longitude : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case latitude = "latitude"
        case longitude = "longitude"
    }
}


struct Dropoff_machine_detail : Codable {
    let name : String?
    let opening_hours : String?
    let location_description : String?
    let location : Location?
    let address : Address?
    let type : [String]?
    let location247 : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case opening_hours = "opening_hours"
        case location_description = "location_description"
        case location = "location"
        case address = "address"
        case type = "type"
        case location247 = "location247"
    }
}

struct Custom_attributes : Codable {
    let size : String?
    let target_machine_id : String?
    let dropoff_machine_id : String?
    let target_machine_detail : Target_machine_detail?
    let dropoff_machine_detail : Dropoff_machine_detail?
    let end_of_week_collection : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case size = "size"
        case target_machine_id = "target_machine_id"
        case dropoff_machine_id = "dropoff_machine_id"
        case target_machine_detail = "target_machine_detail"
        case dropoff_machine_detail = "dropoff_machine_detail"
        case end_of_week_collection = "end_of_week_collection"
    }
}

struct Address : Codable {
    let line1 : String?
    let line2 : String?
    
    enum CodingKeys: String, CodingKey {
        
        case line1 = "line1"
        case line2 = "line2"
    }
}
