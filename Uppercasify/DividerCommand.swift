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
    
    /************************ D I V I D E R ************************/
    /*                                                             */
    /***************************************************************/
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let buffer = invocation.buffer
        let firstSelection = buffer.selections.firstObject as? XCSourceTextRange
        let startLine = firstSelection?.start.line
        let divider = ["/************************ D I V I D E R ************************/",
                       "/*                                                             */",
                       "/***************************************************************/"]
        
        guard let line = startLine else { return }
//        buffer.selections.forEach({ selection in
//            guard let selection = selection as? XCSourceTextRange else { return }
//            
//            for lineIndex in selection.start.line..<selection.end.line {
//                var line = buffer.lines[lineIndex] as! String
//                
//                var startIndex = line.characters.startIndex
//                var endIndex = line.characters.endIndex
//                
//                if lineIndex == selection.start.line {
//                    startIndex = line.characters.index(line.startIndex, offsetBy: selection.start.column)
//                }
//                if lineIndex == selection.end.line {
//                    endIndex = line.characters.index(line.startIndex, offsetBy: selection.end.column)
//                }
//                
//                let selectedText = line.substring(with: startIndex..<endIndex)
//                let isUppercaseCommand  =  invocation.commandIdentifier.hasSuffix("UPPERCASE")
//                
//                let uppercased = isUppercaseCommand ? selectedText.uppercased() : selectedText.lowercased()
//                let newLine = line.replacingCharacters(in: startIndex..<endIndex, with: uppercased)
//                
//                buffer.lines.removeObject(at: lineIndex)
//                buffer.lines.insert(newLine, at: lineIndex)
//            }
//        })
        
//        buffer.lines.insert(contentOf: divider, at: 0)
        
        buffer.lines.insert(divider, at: line)
//        buffer.selections.setArray([newSelection])
        completionHandler(.none)
    }
}
