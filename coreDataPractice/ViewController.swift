//
//  ViewController.swift
//  coreDataPractice
//
//  Created by Matthew Folbigg on 24/02/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    
    var dataController: DataController!
    var note: Note?
    var noteId = "Main Note"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        if note == nil {
            note = Note(context: dataController.viewContext)
            note?.noteId = noteId
        }
        textView.text = note?.text
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest = Note.fetchRequest()
        let predicate = NSPredicate(format: "noteId = %@", noteId)
        fetchRequest.predicate = predicate
        
        if let data = try? dataController.viewContext.fetch(fetchRequest) {
            print("Notes in loaded data: \(data.count)")
            guard data.count > 0  else {
                print("No notes loaded")
                return
            }
            note = data.first
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        note?.text = textView.text
        print("hello")
        do {
            try note?.managedObjectContext?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

