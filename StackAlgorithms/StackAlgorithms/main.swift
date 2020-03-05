//
//  main.swift
//  StackAlgorithms
//
//  Created by Jozeee on 1/19/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

/*
 Stack Questions
 Evaluate postfix expression using a stack.
 Sort values in a stack.
 Check balanced parenthesis in an expression.
 Reverse a string using a stack.
 Convert postfix to prefix expression using a stack.
 */


// MARK: -
// Evaluate postfix expression (6 2 / 5 +) using a stack.
// Listen; Example: "57+62-*"; Brute; Optimize (BUD); Walkthrough;
// Time(n): Where n is the size of the array.
// Space(n): array takes n number of elements, stack takes n number of elements
// and we also use 1 or 2 variables per loop depending on postfix expression.
func evaluatePostfix(_ postfix: String) {
    let elements: [String] = postfix.map({String($0)})
    let stack: Stack<Int> = Stack()
    
    for element in elements {
        if let num = Int(element) {
            stack.push(num)
        } else {
            guard let rhs = stack.pop(), let lhs = stack.pop() else {
                print("Invalid expression.")
                return
            }
            switch element {
            case "+": stack.push(lhs + rhs)
            case "-": stack.push(lhs - rhs)
            case "*": stack.push(lhs * rhs)
            case "/":
                guard rhs != 0 else {
                    print("Cannot divide by 0.")
                    return
                }
                stack.push(lhs / rhs)
            default: break
            }
        }
    }
    if let answer = stack.pop() {
        print("Answer: \(answer)")
    }
}


// MARK: -
// Sort values in a stack.
// LISTEN: Smallest at the bottom of the stack; Example: [2, 3, 1, 12, 0, 8] <- Top
// BRUTE: Pop all elements into an array, sort them, and push them back to the stack.
// OPTIMIZE BUD: (Bottlenecks? Having to pop all the elements. Unnecessary work? Creating an array and sorting it.
//                Duplicate? reading all the values and then again putting them back in the stack.)
// Don't use an array; use a temp stack and a temporary variable. It will sort faster as we read values.
// WALKTHROUGH: stack = [1, 2, 3, 4, 5, 6]; temp = []; temp = ; value = ; tempValue =
// Time O(n^2): at most where n is the size of the stack (if in reverse order). This number is smaller depending on the size.
// Space O(1): Size remains the same as list size.
func sortStack(_ stack: Stack<Int>) -> Stack<Int> {
    let tempStack: Stack<Int> = Stack<Int>()
    // Loop the original stack until there are no more values.
    while !stack.isEmpty {
        // Pop and compare it against the head of the temp stack.
        if let temp = stack.pop() {
            // If the top of the temp stack keeps being greater than the popped value, then keep popping
            // from the temp stack until the smaller value is put on top.
            while !tempStack.isEmpty && (tempStack.peek() ?? 0) > temp {
                if let tempValue = tempStack.pop() {
                    stack.push(tempValue)
                }
            }
            tempStack.push(temp)
        }
    }
    return tempStack
}


// MARK: -
// Sort values in a stack.
func sortStackRecursion(_ stack: Stack<Int>) {
    if !stack.isEmpty {
        let temp = stack.pop() ?? 0
        // Keep popping elements recursively to keep a reference of each element.
        sortStackRecursion(stack)
        // Once they have all been popped, start sorting them.
        sortStackRecursionInsert(stack, element: temp)
    }
}

private func sortStackRecursionInsert(_ stack: Stack<Int>, element: Int) {
    if stack.isEmpty || element > stack.peek() ?? 0 {
        stack.push(element)
    } else {
        let temp = stack.pop() ?? 0
        // Keep sorting the elements from the bottom as needed. When they are sorted,
        // continue to the next recursive call.
        sortStackRecursionInsert(stack, element: element)
        stack.push(temp)
    }
}


// MARK: -
// Check balanced parenthesis in an expression.
// LISTEN; EXAMPLE: ((1 + (3 * 4)) - (3))
// BRUTE: Ignore all values except parenthesis. Push each parenthesis into a stack. If a corresponding parenthesis is found,
// then pop it. Continue until there are no more characters. If the stack is not empty, then return false.
// Time O(n + c) where n is the size of the array and c is the number of parenthesis.
// Space O(n): Size grows in relation to the size of the expression.
func checkParenthesis(in expression: String) -> Bool {
    // map is O(n) and filter is O(n), so O(n) for this array.
    let chars: [String] = expression.map({String($0)}).filter({
        ($0 == "(" || $0 == ")") || ($0 == "{" || $0 == "}") || ($0 == "[" || $0 == "]")
    })
    guard !chars.isEmpty else { return false }
    
    let stack: Stack<String> = Stack<String>()
    
    // O(c) for how many elements in chars.
    for char in chars {
        if let val = stack.peek(), (val == "(" && char == ")") || (val == "{" && char == "}") || (val == "[" && char == "]") {
            _ = stack.pop()
            continue
        }
        stack.push(char)
    }
    // If all parenthesis had a match, the stack should be empty.
    return stack.isEmpty
}


// MARK: -
// Time O(n): Where n is the number of characters in the string.
func reverseString(_ str: String) -> String {
    let stack: Stack<String> = Stack<String>()
    var rStr: String = ""
    str.forEach({stack.push(String($0))})
    while !stack.isEmpty {
        if let val = stack.pop() {
            rStr += val
        }
    }
    return rStr
}


// MARK: -
// Convert prefix to postfix expression using a stack.
// *+AB-CD -> AB+CD-*
// Stack: AB+CD-;
// Postfix:
func convertPrefixToPostfix(_ str: String) {
    let stack = Stack<String>()
    
    for char in str.reversed() {
        if isOperator(String(char)) {
            if let firstNum = stack.pop(), let secondNum = stack.pop() {
                stack.push("\(firstNum)\(secondNum)\(char)")
            }
        } else {
            stack.push(String(char))
        }
    }
    
    print(stack.pop() ?? "")
}

private func isOperator(_ str: String) -> Bool {
    return str == "+" || str == "-" || str == "*" || str == "/"
}
