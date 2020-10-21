//
//  String+Extension.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import Foundation

extension String {
    
    func statusRefactor() -> String{
        var string = self
        switch string {
        case "out_for_delivery":
            string = "Wydano do doręczenia"
            
        case "sent_from_source_branch":
            string = "Wysłana z oddziału"
            
        case "ready_to_pickup":
            string = "Gotowa do odbioru"
            
        case "404":
            string = "Podana przesyłka nie istnieje"
            
        case "delivered":
            string = "Przesyłka dostarczona"
            
        case "confirmed":
            string = "Gotowa do nadania"
            
        case "adopted_at_source_branch":
            string = "Przyjęta w oddziale"
            
        case "collected_from_sender":
            string = "Przejęta od nadawcy"
            
        case "adopted_at_sorting_center":
            string = "Przejęta w sortowni"
            
        case "dispatched_by_sender":
            string = "Wysłana przez nadawcę"
            
        case "taken_by_courier":
            string = "Przejęta przez kuriera"
        
        case "out_for_delivery_to_address":
            string = "W doręczeniu"
            
        case "stack_in_customer_service_point":
            string = "Do odbioru w punkcie"
            
        default:
            string = self
        }
        
        return string
    }
}
