//
//  ViewController.swift
//  Timer_Second Try
//
//  Created by Karen Lorena Mercado Campos on 2/20/15.
//  Copyright (c) 2015 Karen Lorena Mercado Campos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var pickerview: UIPickerView!
    
    @IBOutlet weak var TaskTimerPickerView: UIPickerView!
    
    // make sure to add this sound to your project
    var playSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Hurry", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    var myTimer = NSTimer()
    var taskTimerUp = NSTimer()
    var timeLeft = 0
    var mins = [String]()
    var secs = [String]()
    
    var taskTimer = 0
    
    
    //cree los labels con programación para poder decirles donde van. El de minutos lo moví 115px en x y 100 en y. El de segundos 305 en x y 100 en y
    var minsLabel = UILabel(frame: CGRectMake(115, 100, 200, 21))
    var secsLabel = UILabel(frame: CGRectMake(305, 100, 200, 21))
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(component == 0){
            return String(mins [row])
        }else{
            return String(secs [row])
        }
    }
    
    @IBAction func Start(sender: UIButton) {
        //timeLeft es la suma del tiempo de min (multiplicado por 60 para hacerlo segundos y los segundos
        timeLeft = (pickerview.selectedRowInComponent(0) * 60) + pickerview.selectedRowInComponent(1)
        //esto es exactamente el método que tú tenías
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("changeUIPickerView"), userInfo: nil, repeats: true)
            self.view.backgroundColor = UIColor.blueColor()
    }
    
    @IBAction func Stop(sender: UIButton){
        //picas el botón y muere el timer, es todo!
        myTimer.invalidate()
        audioPlayer.stop()
        
    }
    
    
    func changeUIPickerView() {
        //le resto 1 cada vez que se llama este método
        timeLeft = timeLeft-1
        //si el valor actual -1 = -1 quiere decir que estamos en 0
        //si estamos en 0 hay que regresar a 59
        //también quiere decir que hay que cambair el valor del minuto y bajarlo 1
        if((pickerview.selectedRowInComponent(1) - 1) == -1){
            pickerview.selectRow(59, inComponent: 1, animated: true)
            pickerview.selectRow(pickerview.selectedRowInComponent(0)-1, inComponent: 0, animated: true)
        }else{
            //si no es -1 entonces solo hay que bajar el segundo
            pickerview.selectRow(pickerview.selectedRowInComponent(1)-1, inComponent: 1, animated: true)
        }
        //si ya no queda tiempo, detengo el timer
        if(timeLeft == 0){
            myTimer.invalidate()
            audioPlayer.play()
            self.view.backgroundColor = UIColor.yellowColor()
        }
    }
    
    
    
    //Task Timer
    
    @IBAction func startTimer(sender: AnyObject) {
        taskTimer = (TaskTimerPickerView.selectedRowInComponent(0) * 60) + TaskTimerPickerView.selectedRowInComponent(1)
        //esto es exactamente el método que tú tenías
        taskTimerUp = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("TaskTimerUIPickerView"), userInfo: nil, repeats: true)
            self.view.backgroundColor = UIColor.purpleColor()

        
    }
  
    @IBAction func stopTimer(sender: UIButton) {
        taskTimerUp.invalidate()
         self.view.backgroundColor = UIColor.lightGrayColor()
    }
    
    
    func TaskTimerUIPickerView() {
        //le resto 1 cada vez que se llama este método
        taskTimer += 1
        //si el valor actual -1 = -1 quiere decir que estamos en 0
        //si estamos en 0 hay que regresar a 59
        //también quiere decir que hay que cambair el valor del minuto y bajarlo 1
        if((TaskTimerPickerView.selectedRowInComponent(1) + 1) == 60){
            TaskTimerPickerView.selectRow(0, inComponent: 1, animated: true)
            TaskTimerPickerView.selectRow(TaskTimerPickerView.selectedRowInComponent(0)+1, inComponent: 0, animated: true)
        }else{
            TaskTimerPickerView.selectRow(TaskTimerPickerView.selectedRowInComponent(1)+1, inComponent: 1, animated: true)
        }
        
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for(var i = 0; i <= 59; i++){
            mins.append(String(i))
            secs.append(String(i))
        }
        
        //el texto de las labels que hice arriba
        minsLabel.text = "mins"
        secsLabel.text = "secs"
        //esto nomás hace la font "bold" si quieres quítalo
        minsLabel.font = UIFont.boldSystemFontOfSize(16.0)
        secsLabel.font = UIFont.boldSystemFontOfSize(16.0)
        
        //aquí agrego las labels a la pantalla
        self.pickerview.addSubview(minsLabel)
        self.pickerview.addSubview(secsLabel)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: playSound, error: nil)
        audioPlayer.prepareToPlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

