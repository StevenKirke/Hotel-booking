//
//  TagCloud.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import UIKit

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}

class TagCloud {
    
    let fontSize: CGFloat = 16

    func generateCloud(_ array: [String]) -> [[Tag]] {
        var tags: [Tag] = []
        var tagCloud: [[Tag]] = []
        for (_, text) in array.enumerated() {
            let fontSize: CGFloat = 16
            let font = UIFont.systemFont(ofSize: fontSize)
            let attributes = [NSAttributedString.Key.font: font]
            let size = (text as NSString).size(withAttributes: attributes)
            tags.append(Tag(text: text, size: size.width))
        }
        self.getRow(tags) { tags in
            tagCloud = tags
        }
        return tagCloud
    }
    
    private func getRow(_ tags: [Tag], responseTag: @escaping ([[Tag]]) -> Void) {
        
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        var totalWidth: CGFloat = 0
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        tags.forEach { tag in
            totalWidth += tag.size
            if totalWidth > screenWidth {
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            } else {
                currentRow.append(tag)
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        responseTag(rows)
    }
}
