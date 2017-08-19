//
//  SourceEditorCommand.swift
//  Uppercasify
//
//  Created by Ignazio Calò on 17/08/2017.
//  Copyright © 2017 Ignazio Calò. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let buffer = invocation.buffer
        //Store for later
        let lastSelection = buffer.selections.firstObject as! XCSourceTextRange
        let newSelection = XCSourceTextRange(start: lastSelection.start, end: lastSelection.end)
        
        buffer.selections.forEach({ selection in
            guard let selection = selection as? XCSourceTextRange else { return }
            
            for lineIndex in selection.start.line...selection.end.line {
                var line = buffer.lines[lineIndex] as! String
                
                var startIndex = line.characters.startIndex
                var endIndex = line.characters.endIndex
                
                if lineIndex == selection.start.line {
                    startIndex = line.characters.index(line.startIndex, offsetBy: selection.start.column)
                }
                if lineIndex == selection.end.line {
                    endIndex = line.characters.index(line.startIndex, offsetBy: selection.end.column)
                }
                
                let selectedText = line.substring(with: startIndex..<endIndex)
                let isUppercaseCommand  =  invocation.commandIdentifier.hasSuffix("UPPERCASE")
                
                let uppercased = isUppercaseCommand ? selectedText.uppercased() : selectedText.lowercased()
                let newLine = line.replacingCharacters(in: startIndex..<endIndex, with: uppercased)
                
                buffer.lines.removeObject(at: lineIndex)
                buffer.lines.insert(newLine, at: lineIndex)
            }
        })
        
        buffer.selections.setArray([newSelection])
        completionHandler(.none)
    }
    
}
