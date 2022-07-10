//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 07.07.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // 1. Передать массив с ответами на экран с результатами
    // 2. Определить наиболее часто встречающийся тип животного
    // 3. Отобразить результаты в соответствии с этим животным
    // 4. Избавиться от кнопки возврата назад на экране результатов

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    var results: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculationResult()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    private func displayResult(for animal: Animal) {
        resultLabel.text = "Вы - \(animal.rawValue)"
        definitionLabel.text = animal.definition
    }
    
    private func calculationResult() {
        var listAnimals: [Animal: Int] = [:]
        
        let typeAnimals = results.map { type in
            type.animal
        }
        
        for resultAnimal in typeAnimals {
            listAnimals[resultAnimal, default: 0] += 1
        }
        
        let sortedValueForAnimals = listAnimals.sorted { $0.value > $1.value }
        
        let maxNumberRepetitions = sortedValueForAnimals.max { a, b in
            a.value < b.value
        }
        
        guard let defaultResult = sortedValueForAnimals.first?.key else { return }
        
        if let animal = maxNumberRepetitions {
            displayResult(for: animal.key)
        } else {
            displayResult(for: defaultResult)
        }
        
    }
}
