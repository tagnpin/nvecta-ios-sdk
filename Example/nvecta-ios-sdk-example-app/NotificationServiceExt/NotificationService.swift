//
//  NotificationService.swift
//  NotificationServiceExt
//
//  Created by Notifyvisitors Macbook Pro 001  on 14/08/26.
//

import UserNotifications
import notifyvisitorsNotificationService

class NotificationService: notifyvisitorsNotificationService {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        super.didReceive(request, withContentHandler: contentHandler)
    }
    
}
