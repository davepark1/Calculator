//
//  ViewController.swift
//  Calculator
//
//  Created by David Park on 8/15/19.
//  Copyright © 2019 David Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items = ["C", "+/-", "%", "/", "7", "8", "9", "*", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="];
    var result : Double?;
    var calculation : String = "";
    //var num : Int?;
    var stringNum : String = "";
    var op : String = "";
    var queue = Queue.init();
    
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var calcLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell;
        
        cell.cellLabel.text = items[indexPath.item];
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var clicked : String!;
        
        print(items[indexPath.item]);
        clicked = items[indexPath.item];
        
        switch clicked{
            case "=":
                //add last operation procedure first
                if (stringNum != ""){
                    if (result == nil){
                        calcLabel.text = stringNum;
                    }else{
                        calculate();
                        calcLabel.text = String(result!);
                        
                        if (op != ""){
                            calculation += op;
                        }
                        calculation += "\(stringNum) = \((String(result!)))";
                        
                        let node = Node.init(calculation: calculation);
                        if (queue.count == 3){
                            queue.dequeue();
                            queue.enqueue(data: node);
                        }else{
                            queue.enqueue(data: node);
                        }
                        calculation = "";
                    }
                }else{
                    if (result == nil){
                        calcLabel.text = "";
                        break;
                    }
                    
                    calcLabel.text = String(result!);
                    calculation += " = \((String(result!)))";
                    
                    let node = Node.init(calculation: calculation);
                    if (queue.count == 3){
                        queue.dequeue();
                        queue.enqueue(data: node);
                    }else{
                        queue.enqueue(data: node);
                    }
                    calculation = "";
                }
                
                setHistoryText();
                result = nil;
                op = "";
                stringNum = "";
            case "+":
                if (stringNum == ""){
                    if (result != nil){
                        op = clicked;
                    }
                    break;
                }
                
                calculate();
                if (op != ""){
                    calculation += op;
                }
                calculation += stringNum;
                
                op = clicked;
                stringNum = "";
                
                calcLabel.text = String(result!);
                break;
            case "-":
                if (stringNum == ""){
                    if (result != nil){
                        op = clicked;
                    }
                    break;
                }
                
                calculate();
                if (op != ""){
                    calculation += op;
                }
                calculation += stringNum;
                
                op = clicked;
                stringNum = "";
                
                calcLabel.text = String(result!);
                break;
            case "*":
                if (stringNum == ""){
                    if (result != nil){
                        op = clicked;
                    }
                    break;
                }
                
                calculate();
                if (op != ""){
                    calculation += op;
                }
                calculation += stringNum;
                
                op = clicked;
                stringNum = "";
                break;
            case "/":
                if (stringNum == ""){
                    if (result != nil){
                        op = clicked;
                    }
                    break;
                }
                
                calculate();
                if (op != ""){
                    calculation += op;
                }
                calculation += stringNum;
                
                op = clicked;
                stringNum = "";
                
                calcLabel.text = String(result!);
                break;
            case "%":
                if (stringNum == ""){
                    if (result != nil){
                        op = clicked;
                    }
                    break;
                }
                
                calculate();
                if (op != ""){
                    calculation += op;
                }
                calculation += stringNum;
                
                op = clicked;
                stringNum = "";
                
                calcLabel.text = String(result!);
                break;
            case "0":
                stringNum += "0";
                calcLabel.text = stringNum;
                break;
            case "1":
                stringNum += "1";
                calcLabel.text = stringNum;
                break;
            case "2":
                stringNum += "2";
                calcLabel.text = stringNum;
                break;
            case "3":
                stringNum += "3";
                calcLabel.text = stringNum;
                break;
            case "4":
                stringNum += "4";
                calcLabel.text = stringNum;
                break;
            case "5":
                stringNum += "5";
                calcLabel.text = stringNum;
                break;
            case "6":
                stringNum += "6";
                calcLabel.text = stringNum;
                break;
            case "7":
                stringNum += "7";
                calcLabel.text = stringNum;
                break;
            case "8":
                stringNum += "8";
                calcLabel.text = stringNum;
                break;
            case "9":
                stringNum += "9";
                calcLabel.text = stringNum;
                break;
            case ".":
                //let cd = containsDecimal(value: stringNum);
                let cd = stringNum.contains(".");
                if (cd == true){
                    print("Number can't contain more than one decimal.");
                }else{
                    stringNum += ".";
                    calcLabel.text = stringNum;
                }
                break;
            case "+/-":
                if (stringNum == ""){
                    break;
                }
                
                if (stringNum[stringNum.startIndex] == "-"){
                    stringNum.remove(at: stringNum.startIndex);
                }else{
                    stringNum = "-" + stringNum;
                }
                calcLabel.text = stringNum;
                break;
            case "C":
                if (stringNum != ""){
                    stringNum == "";
                }else if (result != nil){
                    result = nil;
                    calculation = "";
                }else{
                    var tmp = true;
                    
                    while(tmp == true){
                        tmp = queue.dequeue();
                    }
                    
                    setHistoryText();
                }
                
                calcLabel.text = "";
                break;
            default:
                print(items[indexPath.item]);
                break;
        }
        
    }
    
    func setHistoryText(){
        var text = "";
        var tmp : Node? = queue.head;
        
        while(tmp != nil){
            text += "\(String(tmp!.calculation));   ";
            tmp = tmp!.next;
        }
        
        history.text = text;
    }
    
    func calculate(){
        var num = Double(stringNum);
        
        if (result == nil){
            result = num;
        }else{
            switch op{
                case "+":
                    result = result! + num!;
                case "-":
                    result = result! - num!;
                case "/":
                    result = result! / num!;
                case "%":
                    result = result! / 100;
                case "*":
                    result = result! * num!;
                default: break;
            }
        }
    }
    
    func containsDecimal(value: String) -> Bool{  //finish function
        return true;
    }
}
