//
//  GnomeDetailViewModel.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import UIKit

enum DetailSection {
    case professions
    case friends
}

class GnomeDetailViewModel {
    
    private var gnome: Gnome
    private var detailSections: [DetailSection]
    
    var nameText: String
    var ageText: NSMutableAttributedString?
    var weightText: NSMutableAttributedString?
    var heightText: NSMutableAttributedString?
    var hairColorNameText: NSMutableAttributedString?
    
    init(gnome: Gnome) {
        
        self.gnome = gnome
        self.nameText = gnome.name
        self.detailSections = [.friends, .professions]
    }
    
    func setup() {
        ageText = attributedString(fullText: "Age: \(gnome.age) years", attributedText: "Age:")
        weightText = attributedString(fullText: "Weight: \(String(format: "%.2f", arguments: [gnome.weight])) kg", attributedText: "Weight:")
        heightText = attributedString(fullText: "Height: \(String(format: "%.2f", arguments: [gnome.height])) cm", attributedText: "Height:")
        hairColorNameText = attributedString(fullText: "Hair color: \(gnome.hairColor)", attributedText: "Hair color:")
    }
    
    func numberOfSection() -> Int {
        detailSections.count
    }
    
    func title(at section: Int) -> String {
        String(describing: detailSections[section]).capitalized
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch detailSections[section] {
        case .professions:
            return gnome.professions.isEmpty ? 1 : gnome.professions.count
        case .friends:
            return gnome.friends.isEmpty ? 1 : gnome.friends.count
        }
    }
    
    func text(at indexPath: IndexPath) -> String {
        switch detailSections[indexPath.section] {
        case .professions:
            if gnome.professions.isEmpty {
                return "it seems someone needs to find a job 💻"
            } else {
                return gnome.professions[indexPath.row]
            }
        case .friends:
            if gnome.friends.isEmpty {
                return "it seems someone needs to make some friends 😁"
            } else {
                return gnome.friends[indexPath.row]
            }
        }
    }
}

private extension GnomeDetailViewModel {
    func attributedString(fullText: String, attributedText: String) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: fullText)
        mutableString.setFontForText(textToFind: attributedText, withFont: UIFont.boldSystemFont(ofSize: 16), color: .secondaryLabel)
        return mutableString
    }
}

extension NSMutableAttributedString {
    func setFontForText(textToFind: String, withFont font: UIFont, color: UIColor = UIColor.label) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        addAttributes([
                        NSAttributedString.Key.font: font,
                        NSAttributedString.Key.foregroundColor: color], range: range)
    }
}
