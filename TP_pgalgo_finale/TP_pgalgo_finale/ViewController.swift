//
//  ViewController.swift
//  TP_pgalgo_finale
//
//  Created by Rodrigo de Freitas Motta Correa on 17-12-09.
//  Copyright © 2017 Rodrigo de Freitas Motta Correa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
      //__________
     // Variables Bounce, balle et finger move
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
    // Label pour le timer et points
    @IBOutlet weak var points_label: UILabel!
    @IBOutlet weak var game_timerLabel: UILabel!
    
    //---------------
    var objet_bounce1: Bounce!
    var game_timer: Timer!
    var sec = 0
    var points = 0
    //_____________
    var objet_bounce: Bounce!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
    //--------
    
    // Variables pour les sons
    var startSound = AVAudioPlayer()
    var scorePoints = AVAudioPlayer()
    var audioGameover = AVAudioPlayer()
    var victoryGame = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Méthode Bounce pour faire l'intersection de la balle, chaqu'un des élements donnent un mouvemment different a la balle
        
        objet_bounce = Bounce(ball: balle, left_window: mur_gauche, right_window: mur_droit, top_window: mur_haut, bottom_window: mur_bas)// methode Bounce pour faire que le balle tourne autre direccion ainsi qui a intersecté
        balle.layer.cornerRadius = 25// Donner forme la balle
        
        objet_bounce1 = Bounce(ball: balle, left_window: mg, right_window: md, top_window: mh, bottom_window: mb)
       
        lancerAnimation()
        
         //Les musiques pour l'animation
          do
            {
                 //musique pour commencer le jeu
                startSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "start", ofType: "mp3")!))
                startSound.play()
                 //musique pour le fin du jeu, quand l'usager
                audioGameover = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gameover", ofType: "mp3")!))
                audioGameover.prepareToPlay()
                 // Chaque point de l'usager
                scorePoints = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "score", ofType: "mp3")!))
                scorePoints.prepareToPlay()
                 // Musique pour la victory
                victoryGame = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "victory", ofType: "mp3")!))
                victoryGame.prepareToPlay()
                
            }
            catch
            {
            print(error)
            }
        
    }

     // Fonction pour l'animation - les mouvements de la balle
    func lancerAnimation() {
        
        let degres: Double = Double( arc4random_uniform(360))
        cos = __cospi(degres / 180)
        sin = __sinpi(degres / 180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
        game_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(keep), userInfo: nil, repeats: true)
    }
        //_______________
    
    //fonction pour afficher le timer
    @objc func keep(){
        sec += 1
        game_timerLabel.text = "\(sec) seconds..." // Afichage avec le text(seconds) dans le timer
    }
    
    
    // Fonction pour faire animation avec le direccion de la balle
       @objc func animation() {
        
            balle.center.x += CGFloat(cos) // direccion de la balle dans x
            balle.center.y += CGFloat(sin) // direcion de la balle dans y
        
        // Conditions pour les points
        if balle.frame.intersects(mur_bas.frame) { // si la balle est intersects par le mur_bas donner le points dessous
            points += 1
            points_label.text = "\(points)"
            scorePoints.play()
        }
        
//        // boucle pour arreter le timer du jeu
        if sec == 60 {// temp maxime pour jouer
        aTimer.invalidate()
        aTimer = nil
        game_timer.invalidate()
        game_timer = nil
        sec = 0
        victoryGame.play()
            
        }
        //-----------
        //Conditions pour finir le jeu
        if balle.frame.intersects(game_over.frame) { // Si la balle intersect par le view game over
            aTimer.invalidate() //arreter le timer
            aTimer = nil
            points = 0 // points égal a zero aprés le game over
             points_label.text = "\(points) points" //recommencer compter les points aprés le game over
            audioGameover.play()  // musique game over doit ativer
            
        }
            // calcule du sin e cos pour le méthode bounce
            sin = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
            cos = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
        
           // bounce 1 animation
            sin = objet_bounce1.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
            cos = objet_bounce1.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
        
        }
     // Faire le mouvement du funger move e du mur bas ensemble
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

