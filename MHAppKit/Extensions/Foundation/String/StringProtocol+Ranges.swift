//
//  StringProtocol+Ranges.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6.06.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

extension StringProtocol where Self.Index == String.Index {
    
    /**
     Finds and returns the ranges of all occurrence of a given string within a given range of the string, subject to given options, using the specified locale, if any.
     
     - parameter string: The string for which to search.
     - parameter rangeToSearch: The range within the receiver for which to search for string.
     
     - returns: A collection of ranges within the receiver giving the locations and length in the receiver of the string within the range in the receiver. The ranges returned are relative to the start of the string, not to the passed-in range.
     
     */
    
    public func ranges<T>(of string: T, range: Range<Self.Index>? = nil) -> [Range<Self.Index>] where T : StringProtocol {
        
        return self.ranges(of: string, within: range) { (string, range) -> Range<String.Index>? in
            
            return self.range(of: string, range: range)
        }
    }
    
    /**
     Finds and returns the ranges of all occurrence of a given string within a given range of the string, subject to given options, using the specified locale, if any.
     
     - parameter string: The string for which to search.
     - parameter options: A mask specifying search options.
     - parameter rangeToSearch: The range within the receiver for which to search for string.
     
     - returns: A collection of ranges within the receiver giving the locations and length in the receiver of the string within the range in the receiver, modulo the options in mask. The ranges returned are relative to the start of the string, not to the passed-in range.
     
     */
    
    public func ranges<T>(of string: T, options: String.CompareOptions, range: Range<Self.Index>? = nil) -> [Range<Self.Index>] where T : StringProtocol {

        return self.ranges(of: string, within: range) { (string, range) -> Range<String.Index>? in

            return self.range(of: string, options: options, range: range)
        }
    }
    
    /**
     Finds and returns the ranges of all occurrence of a given string within a given range of the string, subject to given options, using the specified locale, if any.
     
     - parameter string: The string for which to search.
     - parameter options: A mask specifying search options.
     - parameter rangeToSearch: The range within the receiver for which to search for string.
     - parameter locale: The locale to use when comparing the receiver with aString. To use the current locale, pass [NSLocale current]. To use the system locale, pass nil. The locale argument affects the equality checking algorithm. For example, for the Turkish locale, case-insensitive compare matches “I” to “ı” (U+0131 LATIN SMALL DOTLESS I), not the normal “i” character.
     
     - returns: A collection of ranges within the receiver giving the locations and length in the receiver of the string within the range in the receiver, modulo the options in mask. The ranges returned are relative to the start of the string, not to the passed-in range.
     
     */
    
    public func ranges<T>(of string: T, options: String.CompareOptions, range: Range<Self.Index>? = nil, locale: Locale?) -> [Range<Self.Index>] where T : StringProtocol {

        return self.ranges(of: string, within: range) { (string, range) -> Range<String.Index>? in
            
            return self.range(of: string, options: options, range: range, locale: locale)
        }
    }
    
    /**
     Finds and returns the ranges of all occurrence of a given string within a given range of the string, subject to given searcher that determines the range of the first occurrence of a given string within a given range of the string.
     
     - parameter string: The string for which to search.
     - parameter rangeToSearch: The range within the receiver for which to search for string.
     - parameter searcher: The searcher that determines the range of the first occurrence of a given string within a given range of the string. The searcher accepts 2 arguments - a string for which to search within the receiver and a range within the receiver for which to search for the string. The searcher should return a range giving the location and length in the receiver of the string within the range in the receiver. The range returned is relative to the start of the string, not to the passed-in range. If no match is found - the searcher should return nil.
     
     - returns: A collection of ranges within the receiver giving the locations and length in the receiver of the string within the range in the receiver. The ranges returned are relative to the start of the string, not to the passed-in range.
     
     */
    
    public func ranges<T>(of string: T, within rangeToSearch: Range<Self.Index>? = nil, searcher: (T, Range<Self.Index>) -> Range<Self.Index>?) -> [Range<Self.Index>] where T : StringProtocol {
        
        var result: [Range<Self.Index>] = []
        var rangeToSearch = rangeToSearch ?? self.startIndex..<self.endIndex
        var rangeOfOccurance = searcher(string, rangeToSearch)
        
        while let range = rangeOfOccurance {
            
            result.append(range)
            rangeToSearch = range.upperBound..<rangeToSearch.upperBound
            rangeOfOccurance = searcher(string, rangeToSearch)
        }
        
        return result
    }
}
