//
//  NotesTableViewController.swift
//  my_notes
//
//  Created by Angelina on 5/2/19.
//  Copyright © 2019 Angelina Friz. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, EditNoteDelegate {

    var notes = [[String:String]]()
    var selectedIndex = -1


    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func addNoteButtonTapped(_ sender: UIBarButtonItem) {
        let note = ["title": "", "body": ""]
        notes.insert(note, at: 0)
        tableView.reloadData()
        selectedIndex = 0
//        performSegue(withIdentifier: "cellEditScreenSegue", sender: nil)
        newNote()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]["title"]
        print("cell works")
        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row

//        let vc = EditViewController()
//        vc.noteBodyTextView.isEditable = false
//        navigationController?.pushViewController(vc, animated: true)


    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? EditViewController
        destinationVC?.noteBody = self.notes[selectedIndex]["body"] ?? ""

        destinationVC?.editNoteDelegate = self

    }

    func updateNote(updatedTitle: String, updatedBody: String) {
        notes[selectedIndex]["body"] = updatedBody
        notes[selectedIndex]["title"] = updatedTitle
        tableView.reloadData()

    }

    func newNote() {
        let vc = EditViewController()
        vc.state = .new
        navigationController?.pushViewController(vc, animated: true)
    }

}

