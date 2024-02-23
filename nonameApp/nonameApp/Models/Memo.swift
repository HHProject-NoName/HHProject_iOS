//
//  Memo.swift
//  nonameApp
//
//  Created by heyji on 2024/02/22.
//

import Foundation

struct Memo {
    let id: String
    let content: String
    let tag: [String]
    let sort: String
    let flag: Bool = false
    let push: Bool? = false
    let color: String = "white"
    let createdAt: String
    let updateAt: String
}

struct TagList {
    let name: String
    let pin: Bool = false
}

enum MemoSort {
    case memo
    case goal
}

extension Memo {
    static let memoList = [
        Memo(id: "1", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", tag: ["#기록"], sort: "글", createdAt: "2024-02-23", updateAt: "2024-02-23 08:42:49"),
        Memo(id: "2", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", tag: ["#질문"], sort: "글", createdAt: "2024-02-22", updateAt: "2024-02-23 08:42:49"),
        Memo(id: "3", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", tag: ["#기록"], sort: "글", createdAt: "2024-02-21", updateAt: "2024-02-23 08:42:49")
    ]
}
