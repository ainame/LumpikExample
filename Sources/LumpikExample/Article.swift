//
//  Article.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/10.
//

import Foundation

class Article: Entity {
   let id: Int
   let title: String
   let body: String
   let createdAt: Date
   let updatedAt: Date
   let publishedAt: Date
}
