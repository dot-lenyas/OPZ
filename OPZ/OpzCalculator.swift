//
//  OpzCalculator.swift
//  OPZ
//
//  Created by lazarenko_lo on 26.06.2021.
//
//Дополнение стринг
extension String {

  var length: Int {
    return count
  }

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                        upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}
//=====================




import Foundation
class OpzCalculator
{
    private var stack: Stack<String>
    private var signs: Stack<Sign>

    init()
    {
        stack = Stack<String>()
        signs = Stack<Sign>()

    }

    private func forOperations(_ sign: Sign, _ st: Stack<String>, _ sig: Stack<Sign>)
    {
        switch sign.symbol
        {
            case "/":
                sig.push(element: sign)
                break
            case "*":
                while (!sig.isEmpty() && sig.Back()!.symbol == "/")
                {
                    st.push(element: sig.Back()!.symbol)
                    sig.pop()
                }
                sig.push(element: sign)
                break;
            case "+":
                while (!sig.isEmpty() && (sig.Back()!.symbol == "/" || sig.Back()!.symbol == "*" || sig.Back()!.symbol == "-" || sig.Back()!.symbol == "+"))
                {
                    st.push(element: sig.Back()!.symbol);
                    signs.pop();
                }
                sig.push(element: sign);
                break;
            case "-":
                while (!sig.isEmpty() && (sig.Back()!.symbol == "/" || sig.Back()!.symbol == "*" || sig.Back()!.symbol == "-" || sig.Back()!.symbol == "+"))
                {
                    st.push(element: sig.Back()!.symbol);
                    signs.pop();
                }
                sig.push(element: sign);
        default:
            break
        }


    }

    private func bracketsTreatment(_ sign: Sign,  _ i: inout Int, _ str: String)
    {
        var tempStack: Stack = Stack<String>()
        var tempSign: Stack = Stack<Sign>()
        var j = i
        var sign: Sign
        while str[j] != ")" {
            switch str[j] {
            case "0"..."9":
                stack.push(element: str[i])
            case "*":
                sign = Multiply()
                forOperations(sign, tempStack, tempSign)
                break
            case "-":
                sign = Minus()
                forOperations(sign, tempStack, tempSign)
                break
            case "+":
                sign = Plus()
                forOperations(sign, tempStack, tempSign)
                break
            case "/":
                sign = Division()
                forOperations(sign, tempStack, tempSign)
                break
            default:
                break
            }
            j+=1
            i+=1
        }
        while (!tempStack.isEmpty()) {
            stack.push(element: tempStack.Back()!)
            tempStack.pop()
        }
        while (!tempSign.isEmpty()) {
            var temp = tempSign.Back()!

            stack.push(element: temp.symbol)
            tempSign.pop()
        }
        while (!signs.isEmpty()) {
            stack.push(element: signs.Back()!.symbol)
            signs.pop()
        }

    }

    private func calculate(st: Stack<String>, sig: Stack<Sign>) -> Float
    {
        var result: Float = 0;
        var stack: Stack<String> = Stack<String>()

            while (!st.isEmpty())
            {
                stack.push(element: st.Back()!)
                st.pop()
            }
            var a: Stack<Int> = Stack<Int>()
            for i in 0..<stack.Length()
            {
                a.push(element: 0)
            }
            var i = 0;
            while (!stack.isEmpty())
            {

                if (stack.Back()! >= "0" && stack.Back()! <= "9")
                {
                    var b: Int? = Int(stack.Back()!)! - 0
                    a.push(element: b!)
                    stack.pop()
                    i+=1
                }
                else
                {
                    var temp: Float = 0
                    var temp1: Float = 0

                    switch (stack.Back())
                    {
                        case "+":
                            temp = Float(a.Back()!)
                            a.pop()
                            temp += Float(a.Back()!)
                            result = temp
                            a.pop()
                            stack.pop()
                            if (stack.Length() != 0)
                            {
                                if (result >= 0 && result <= 9)
                                {
                                    stack.push(element: String(result) + "0")
                                }
                                else
                                {
                                    var s = Int(result)
                                    a.push(element: s)
                                }
                            }
                            break;
                        case "-":
                            temp = Float(a.Back()!)
                            temp *= -1
                            a.pop()
                            temp += Float(a.Back()!)
                            result = temp
                            //a.erase(a.begin() + i - 1);
                            //a.erase(a.begin() + i - 2);
                            a.pop()
                            stack.pop()
                            if (stack.Length() != 0)
                            {
                                if (result >= 0 && result <= 9)
                                {
                                    stack.push(element: String(result) + "0")
                                }
                                else
                                {
                                    var s = Int(result)
                                    a.push(element: s)
                                }
                            }
                            break
                        case "*":
                            temp = Float(a.Back()!)
                            a.pop()
                            temp *= Float(a.Back()!)
                            result = temp
                            a.pop()

                            //a.erase(a.begin() + i - 1);
                            //a.erase(a.begin() + i - 2);
                            stack.pop()

                            if (stack.Length() != 0)
                            {
                                if (result >= 0 && result <= 9)
                                {
                                    stack.push(element: String(result) + "0")
                                }
                                else
                                {
                                    var s = Int(result)
                                    a.push(element: s)
                                }
                            }
                            break
                        case "/":
                            temp = Float(a.Back()!)
                            a.pop()
                            temp1 = Float(a.Back()!)
                            temp = temp1 / temp
                            result = temp
                            a.pop()

                            //a.erase(a.begin() + i - 1);
                            //a.erase(a.begin() + i - 2);
                            stack.pop()

                            if (stack.Length() != 0)
                            {
                                if (result >= 0 && result <= 9)
                                {
                                    stack.push(element: String(result) + "0")
                                }
                                else
                                {
                                    var s = Int(result)
                                    a.push(element: s)
                                }
                            }
                            break
                        default:
                            break
                    }
                }


            }
            return result;
    }

    public func DoOpz(str: String) -> Float
    {
        var i = 0
        while true
        {
            var sign: Sign
            if (str[i] == "" || i >= str.count)
            {
                break;
            }
            switch str[i] {
            case "0"..."9":
                stack.push(element: str[i])
                break
            case "*":
                sign = Multiply()
                forOperations(sign, stack, signs)
                break
            case "/":
                sign = Division()
                forOperations(sign, stack, signs)
                break
            case "-":
                sign = Minus()
                forOperations(sign, stack, signs)
                break
            case "+":
                sign = Plus()
                forOperations(sign, stack, signs)
                break
            case "(":
                sign = OpeningBracket()
                bracketsTreatment(sign, &i, str)
                break
            default:
                break
            }
            i+=1
        }
        while !signs.isEmpty() {
            stack.push(element: signs.Back()!.symbol)
            signs.pop()
        }

        var result: Float = calculate(st: stack, sig: signs)
        return result

    }
}
