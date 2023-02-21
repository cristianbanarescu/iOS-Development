//
//  UITableViewCell+NibIdentifiable.swift
//  AccessibilityDemo
//
//  Created by Cristian Banarescu on 21.02.2023.
//

import Foundation

protocol NibIndentifiable {
   var nibName: String { get }
   var identifier: String { get }
}
