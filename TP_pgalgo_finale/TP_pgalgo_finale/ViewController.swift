//
//  ViewController.swift
//  TP_pgalgo_finale
//
//  Created by Rodrigo de Freitas Motta Correa on 17-12-09.
//  Copyright © 2017 Rodrigo de Freitas Motta Correa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //__________
 
    @IBOutlet weak var mur_gauche: UIView!
    @IBOutlet weak var mur_droit: UIView!
    @IBOutlet weak var mur_haut: UIView!
    @IBOutlet weak var mur_bas: UIView!
    @IBOutlet weak var balle: UIView!
    @IBOutlet weak var game_over: UIView!
    @IBOutlet weak var finger_mover: UIView!
    //-------------
    //Variables Bounce1
    @IBOutlet weak var mg: UIView!
    @IBOutlet weak var md: UIView!
    @IBOutlet weak var mb: UIView!
    @IBOutlet weak var mh: UIView!

    //----------
    
    @IBOutlet weak var game_timerLabel: UILabel!
    
    
    //---------------
    var objet_bounce1: Bounce!
    
    
    var game_timer: Timer!
    var sec = 0
    
    //_____________
    var objet_bounce: Bounce!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
//--------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objet_bounce = Bounce(ball: balle, left_window: mur_gauche, right_window: mur_droit, top_window: mur_haut, bottom_window: mur_bas)
        balle.layer.cornerRadius = 25
        
        objet_bounce1 = Bounce(ball: balle, left_window: mg, right_window: md, top_window: mh, bottom_window: mb)
       
        
        lancerAnimation()
    }

    
    func lancerAnimation() {
        
        let degres: Double = Double( arc4random_uniform(360))
        cos = __cospi(degres / 180)
        sin = __sinpi(degres / 180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
        game_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(keep), userInfo: nil, repeats: true)
    }
        //_______________
    
    @objc func keep(){
        sec += 1
        game_timerLabel.text = "\(sec) seconds..."
    }
    
    
    
       @objc func animation() {
        print("test")
            balle.center.x += CGFloat(cos)
            balle.center.y += CGFloat(sin)
        // boucle pour arreter le timer du jeu
//        if sec == 10 {
//        aTimer.invalidate()
//        aTimer = nil
//        game_timer.invalidate()
//        game_timer = nil
//        sec = 0
//        }
        //-----------
        if balle.frame.intersects(game_over.frame) {
            aTimer.invalidate()
            aTimer = nil
        }
            
            sin = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
            cos = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
        
        // bounce 1 animation
            sin = objet_bounce1.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
            cos = objet_bounce1.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
        
        
        
        }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch : UITouch = touches.first!
        if touch.view == finger_mover {
            finger_mover.center.x = touch.location(in: self.view).x
            mur_bas.center.x = finger_mover.center.x
        }
    }
    
    
//________________
}

