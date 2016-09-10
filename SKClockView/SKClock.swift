//
//  clock.swift
//  clock demo
//
//  Created by Sherif Khaled on 9/7/16.
//  Copyright © 2016 Sherif Khaled. All rights reserved.
//

import UIKit

class SKClock: UIView {
    
    @IBOutlet weak var amButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var clockAnchorPoint: UIView!
    @IBOutlet weak var hoursButton: UIButton!
    @IBOutlet weak var minutesButton: UIButton!
    @IBOutlet weak var timeSepratorLabel: UILabel!
    var isHouresSelected:Bool = true
    var isAm:Bool = true
    
    var timesButtons: [UIButton]=[]
    var lastSelectedTimeHour:UIButton!
    var shapeLayer = CAShapeLayer()
    var secondryColor:UIColor = UIColor(hexCode: "#474645")!
    var primaryColor:UIColor = UIColor(hexCode: "#d1e152")!
    var ClockBackGroundColor:UIColor = UIColor.whiteColor()
    
    
    var selectedDate:NSDate!
    
    func configureClockViews(){
        circulizeCourner(amButton)
        circulizeCourner(pmButton)
        circulizeCourner(clockAnchorPoint)
        circulizeCourner(clockView)
        clockView.layer.borderWidth = 1
        clockView.layer.borderColor = secondryColor.CGColor
        addClockButtons(12, end: 12, stepper: -1)
        clockView.backgroundColor=ClockBackGroundColor
        amButton.backgroundColor = primaryColor
        amButton.setTitleColor(secondryColor, forState: .Normal)
        
        
        pmButton.backgroundColor = secondryColor
        pmButton.setTitleColor(primaryColor, forState: .Normal)
        
        configureClockColors()

        
        for clockButton:UIButton in timesButtons {
            circulizeCourner(clockButton)
        }
        
        let date = selectedDate.getDateSting("hh:mm a")
        var dateComponents = date.characters.split{$0 == ":"}.map(String.init)
        dateComponents += dateComponents[1].characters.split{$0 == " "}.map(String.init)
        dateComponents.removeAtIndex(1)
        
        hoursButton.setTitle(dateComponents[0], forState: .Normal)
        minutesButton.setTitle("\(Int(ceil(Double(dateComponents[1])!/5.0)*5))", forState: .Normal)
        
        if dateComponents[2] == "AM" {
            selectAmTime(amButton)
            isAm = true
        }else{
            selectPmTime(pmButton)
            isAm = false
        }
        
        buttonClicked(timesButtons[Int(dateComponents[0])!-1])

        
        
    }
    
    func addClockButtons(buttonsNumber:Int,end:Int,stepper:Int){
        let r = Double(clockView.frame.size.width/2) - 33
        let cx = Double(clockAnchorPoint.center.x)
        let cy = Double(clockAnchorPoint.center.y)
        let rangeSpacer = Double(360/buttonsNumber)
        var a = 180.0
        var text = end
        for _ in buttonsNumber.stride(to: 0, by: -1){
            
            let x = cx + r * sin(a.degreesToRadians)
            let y = cy + r * cos(a.degreesToRadians)
            
            let clockButton:UIButton = UIButton(frame:CGRect(x: x, y: y, width: 35, height: 35))
            
            if text == 60 {
                clockButton.setTitle("00", forState: UIControlState.Normal)
            }else{
                clockButton.setTitle("\(text)", forState: UIControlState.Normal)
            }
            
            clockButton.setTitleColor(secondryColor, forState: .Normal)
            clockButton.titleLabel?.textAlignment = .Center
            clockButton.center.x = CGFloat(x)
            clockButton.center.y = CGFloat(y)
            clockButton.layer.cornerRadius = clockButton.frame.width/2
            clockButton.userInteractionEnabled=false
            clockButton.addTarget(self, action: #selector(SKClock.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            clockView.addSubview(clockButton)
            timesButtons.append(clockButton)
            a = (a + rangeSpacer) % 360
            text = text + stepper
        }
       timesButtons = timesButtons.reverse()
    }
    
    func circulizeCourner(view:UIView){
        view.layer.cornerRadius = view.frame.size.width/2
        //        view.layer.masksToBounds = true
    }
    
    func buttonClicked(sender:UIButton){
        if (lastSelectedTimeHour != nil) {
            lastSelectedTimeHour.backgroundColor=UIColor.clearColor()
            lastSelectedTimeHour.setTitleColor(secondryColor
                , forState: .Normal)
        }
        
        shapeLayer.removeFromSuperlayer()
        sender.backgroundColor = primaryColor
        sender.setTitleColor(secondryColor, forState: .Normal)
        
        let path = UIBezierPath()
        path.moveToPoint(clockAnchorPoint.center)
        path.addLineToPoint(sender.center)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = primaryColor.CGColor
        shapeLayer.lineWidth = 1.0
        clockView.layer.insertSublayer(shapeLayer, atIndex: 0)
        lastSelectedTimeHour = sender
        
        if isHouresSelected {
            hoursButton.setTitle(sender.titleLabel?.text, forState: .Normal)
        }else{
            minutesButton.setTitle(sender.titleLabel?.text, forState: .Normal)
        }
        
    }
    
    func configureClockColors(){
        clockAnchorPoint.backgroundColor = primaryColor
        shapeLayer.strokeColor = primaryColor.CGColor
        if (lastSelectedTimeHour != nil) {
            lastSelectedTimeHour.backgroundColor=primaryColor
            lastSelectedTimeHour.setTitleColor(secondryColor
                , forState: .Normal)
            
        }
        hoursButton.setTitleColor(primaryColor
            , forState: .Normal)
        minutesButton.setTitleColor(primaryColor
            , forState: .Normal)
        timeSepratorLabel.textColor=secondryColor
        clockView.layer.borderColor = secondryColor.CGColor
        for  clockButton:UIButton in timesButtons {
            clockButton.setTitleColor(secondryColor, forState: .Normal)
        }

    }
    
    @IBAction func selectAmTime(sender: UIButton) {
        primaryColor = sender.backgroundColor!
        secondryColor = (sender.titleLabel?.textColor)!
        configureClockColors()
        isAm = true

    }
    
    @IBAction func selectPmTime(sender: UIButton) {
        primaryColor = sender.backgroundColor!
        secondryColor = (sender.titleLabel?.textColor)!
        configureClockColors()
        isAm = false
    }
    
    @IBAction func selectMinutes(sender: UIButton) {
        shapeLayer.removeFromSuperlayer()

        for clockButton in timesButtons {
            clockButton.removeFromSuperview()
        }
        timesButtons=[]
        addClockButtons(12, end: 60, stepper: -5)
        isHouresSelected = false
        buttonClicked(timesButtons[Int(ceil(Double((minutesButton.titleLabel?.text)!)!/5.0)-1)])
    }
    
    @IBAction func selectHours(sender: UIButton) {
        shapeLayer.removeFromSuperlayer()

        for clockButton in timesButtons {
            clockButton.removeFromSuperview()
        }
        timesButtons=[]
        addClockButtons(12, end: 12, stepper: -1)
        isHouresSelected = true
        buttonClicked(timesButtons[Int((hoursButton.titleLabel?.text)!)!-1])

    }
    
    
    func getSelectedDate() -> NSDate {
        var StringDate = "\(hoursButton.titleLabel!.text!)" + ":" + "\(minutesButton.titleLabel!.text!)"
        if isAm{
            StringDate = StringDate + " AM"
        }else{
            StringDate = StringDate + " PM"
        }
        return StringDate.getDate("hh:mm a")!
    }
    
    func getSelecteStringdDate() -> String {
        var StringDate = "\(hoursButton.titleLabel!.text!)" + ":" + "\(minutesButton.titleLabel!.text!)"
        if isAm{
            StringDate = StringDate + " AM"
        }else{
            StringDate = StringDate + " PM"
        }
        return StringDate
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches[touches.startIndex.advancedBy(0)]
        let touchPoint:CGPoint = touch.locationInView(clockView)
        for  clockButton:UIButton in timesButtons {
            if(CGRectContainsPoint(clockButton.frame, touchPoint)) {
                buttonClicked(clockButton)
                return;
            }
        }
    }
   
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches[touches.startIndex.advancedBy(0)]
        let touchPoint:CGPoint = touch.locationInView(clockView)
        for  clockButton:UIButton in timesButtons {
            if(CGRectContainsPoint(clockButton.frame, touchPoint)) {
                buttonClicked(clockButton)
                return;
            }
        }
    }
    
}
extension NSDate
{
    func getDateSting(format:String,withLocal:Bool = false) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return dateFormatter.stringFromDate(self)
    }
}

extension String
{
    func getDate(format:String) -> NSDate?
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return dateFormatter.dateFromString(self)
    }
    
}

extension Double {
    var degreesToRadians: Double { return Double(self) * M_PI / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / M_PI }
}

protocol DoubleConvertible {
    init(_ double: Double)
    var double: Double { get }
}
extension Double : DoubleConvertible { var double: Double { return self         } }
extension Float  : DoubleConvertible { var double: Double { return Double(self) } }
extension CGFloat: DoubleConvertible { var double: Double { return Double(self) } }

extension DoubleConvertible {
    var degreesToRadians: DoubleConvertible {
        return Self(double * M_PI / 180)
    }
    var radiansToDegrees: DoubleConvertible {
        return Self(double * 180 / M_PI)
    }
}

extension UIColor {
    public convenience init?(hexCode: String) {
       let hexString = hexCode + "FF"
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.startIndex.advancedBy(1)
            let hexColor = hexString.substringFromIndex(start)
            
            if hexColor.characters.count == 8 {
                let scanner = NSScanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexLongLong(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

