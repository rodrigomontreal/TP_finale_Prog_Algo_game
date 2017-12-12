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
    
    
    //_____________
    var objet_bounce: Bounce!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
//--------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objet_bounce = Bounce(ball: balle, left_window: mur_gauche, right_window: mur_droit, top_window: mur_haut, bottom_window: mur_bas)
        balle.layer.cornerRadius = 12.5
        lancerAnimation()
        
    }

    
    func lancerAnimation() {
        
        let degres: Double = Double( arc4random_uniform(360))
        cos = __cospi(degres / 180)
        sin = __sinpi(degres / 180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
    }
        //_______________
       @objc func animation() {
            balle.center.x += CGFloat(cos)
            balle.center.y += CGFloat(sin)
        
        if balle.frame.intersects(game_over.frame) {
            aTimer.invalidate()
            aTimer = nil
        }
            
            sin = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
            cos = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
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

