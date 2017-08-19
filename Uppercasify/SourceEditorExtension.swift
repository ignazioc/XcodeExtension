//
//  SourceEditorExtension.swift
//  Uppercasify
//
//  Created by Ignazio Calò on 17/08/2017.
//  Copyright © 2017 Ignazio Calò. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        let className = SourceEditorCommand.className()
        let bundleIdentifier = Bundle(for: type(of: self)).bundleIdentifier!
        
        let caseCommands = ["UPPERCASE", "lowercase"].map { (commandName) -> [XCSourceEditorCommandDefinitionKey: Any] in
            [
                .nameKey: commandName,
                .classNameKey: className,
                .identifierKey: bundleIdentifier.appending(commandName)
            ]
        }
        
        let dividerCommands: [[XCSourceEditorCommandDefinitionKey: Any]] = [[
                .nameKey: "Insert Divider",
                .classNameKey: DividerCommand.className(),
                .identifierKey: bundleIdentifier.appending("insertdivider")
        ]]
        
        return caseCommands + dividerCommands
        
    }
    
}
