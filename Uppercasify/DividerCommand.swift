//
//  DividerCommand.swift
//  XcodeExtension
//
//  Created by Ignazio Calò on 17/08/2017.
//  Copyright © 2017 Ignazio Calò. All rights reserved.
//

import Foundation
import XcodeKit

class DividerCommand: NSObject, XCSourceEditorCommand {
    
    let editorWidth = 76
    let commentStart = "/*"
    let commentEnd = "*/"
    
    /***************************************************************/
    /*                        D I V I D E R                        */
    /***************************************************************/
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let buffer = invocation.buffer
        guard let firstSelection = buffer.selections.firstObject as? XCSourceTextRange,
                  firstSelection.start.line == firstSelection.end.line else {
                    completionHandler(.none)
                    return
        }
        
        let selectedLineIndex = firstSelection.start.line
        let codeLine = buffer.lines[selectedLineIndex] as! String
        
        let startIndex = codeLine.characters.index(codeLine.startIndex, offsetBy: firstSelection.start.column)
        let endIndex = codeLine.characters.index(codeLine.startIndex, offsetBy: firstSelection.end.column)
        
        let selectedText = codeLine.substring(with: startIndex..<endIndex)
        
        let spacedText = Array(selectedText.characters).map { String($0) }.joined(separator: " ") // "foo" -> "f o o"
        let sideSpaceCount = (editorWidth - spacedText.characters.count) / 2
        let textInset = String(repeating: " ", count: sideSpaceCount)
        let spacedLine = textInset + spacedText + textInset
        
        let fixForOddStrings = (spacedText.characters.count % 2 != 0) ? " " : ""
        
        let starsLine = commentStart + String(repeating: "*", count: editorWidth) + commentEnd
        let textLine = commentStart + spacedLine + fixForOddStrings + commentEnd

        let divider = [
            starsLine,
            textLine,
            starsLine
            
        ]
        
        let arr: NSMutableArray = buffer.lines
        buffer.lines.removeObject(at: selectedLineIndex)
        let indexSet = IndexSet(integersIn: selectedLineIndex..<(selectedLineIndex + divider.count))
        arr.insert(divider, at:indexSet)
        completionHandler(.none)
    }
}
