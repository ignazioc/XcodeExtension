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
    
    /*
     func extensionDidFinishLaunching() {
     // If your extension needs to do any work at launch, implement this optional method.
     }
     */
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        let className = SourceEditorCommand.className()
        let bundleIdentifier = Bundle(for: type(of: self)).bundleIdentifier!
        
        return ["UPPERCASE", "lowercase"].map { (commandName) -> [XCSourceEditorCommandDefinitionKey: Any] in
            [
                .nameKey: commandName,
                .classNameKey: className,
                .identifierKey: bundleIdentifier.appending(commandName)
            ]
        }
        
    }
    
}
