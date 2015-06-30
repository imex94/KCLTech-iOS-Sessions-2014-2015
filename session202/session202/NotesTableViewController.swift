//
//  NotesTableViewController.swift
//  session202
//
//  Created by Alex Telek on 09/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var currentUser: User?
    var selectedNote = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //set the Font type and the foreground color of the navigationcontroller bar
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = Dictionary(dictionaryLiteral: (NSForegroundColorAttributeName, UIColor.whiteColor()), (NSFontAttributeName, UIFont(name: "HelveticaNeue-Light", size: 16.0)!))
        
        //set the title of the navigation bar
        navigationController?.navigationBar.topItem?.title = "My Notes"
        
        //set the background color of the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 15/255, green: 36/255, blue: 156/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println(currentUser!.numberOfNotes())
        return currentUser!.numberOfNotes()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = NSBundle.mainBundle().loadNibNamed("NoteTableViewCell", owner: self, options: nil).first as! NoteTableViewCell
        
        // Configure the cell...
        let note = currentUser!.getNoteByIndex(indexPath.row)
        cell.lblNote.text = note.noteText
        cell.lblDate.text = note.getCreatedAt()

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedNote = indexPath.row
        performSegueWithIdentifier("showDetails", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "addNote" {
            let nextViewNav = segue.destinationViewController as! UINavigationController
            let nextView = nextViewNav.topViewController as! AddNewNoteViewController
            nextView.currentUser = currentUser
        } else {
            let nextView = segue.destinationViewController as! DetailViewController
            nextView.note = currentUser?.getNoteByIndex(selectedNote)
        }
    }
}
