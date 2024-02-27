//
//  Match.swift
//  EtonNowiOS
//
//  Created by Collins, Matthew - MC on 22/02/2024.
//

import Foundation

struct Match: Codable {
    let id: String
    let title: String
    let date: Date
    let played: Bool
    let team1: House
    let score1: Int
    let team2: House
    let score2: Int
}
