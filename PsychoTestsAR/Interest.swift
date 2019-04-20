//
//  Interest.swift
//  PsychoTestsAR
//
//  Created by Apple on 18/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit

class Interest
{
    
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    
    static func fetchInterests() -> [Interest]
    {
        return [
            Interest(title: "PSYCHOTEST składa się z kilku modułów pozwalających na kompleksowe wytrenowanie sprawności psycho-ruchowej. Zapoznaj się z każdym z modułów", featuredImage: UIImage(named:"title")!, color: UIColor(red: 63/255.0, green: 78/255.0, blue: 80/255.0, alpha: 0.4)),
            Interest(title: "W tej części elementy wygenerowane przez aplikacje wkroczą do rzeczywistego świata. Dzięki interakcji użytkownika z wirtualnym światem moźliwe jest określenie szybkości reakcji", featuredImage: UIImage(named: "testAR1")!, color: UIColor(red: 105/255.0, green:80/255.0, blue: 227/255.0, alpha: 0.4)),
            Interest(title: "TEST IQ to zestaw losowych pytań pozwalajacych na ocenę sprawności intelektualnej", featuredImage: UIImage(named: "testIQ")!, color: UIColor(red: 63/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.4)),
            Interest(title: "Test Ravena określa poziom inteligencji ogólnej. Zadaniem jest znalezienie brakujacego elementu matrycy", featuredImage: UIImage(named: "testRavena")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.4)),
            
            Interest(title: "Test Ishihara opiera się na analizie widzenia barw. Jest to szybki sposób na zbadanie poziomu postrzegania kolorów", featuredImage: UIImage(named: "testIshirh")!, color: UIColor(red: 245/255.0, green: 62/255.0, blue: 40/255.0, alpha: 0.7)),
            // Interest(title: "Inspire, Instruct, and Empower People", featuredImage: UIImage(named: "f6")!, color: UIColor(red: 103/255.0, green: 217/255.0, blue: 87/255.0, alpha: 0.4)),
            //Interest(title: "Business and Marketing Geeks", featuredImage: UIImage(named: "f7")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.4)),
            //Interest(title: "3D Printing, Virtual Reality and AI", featuredImage: UIImage(named: "f8")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.4)),
        ]
    }
}
