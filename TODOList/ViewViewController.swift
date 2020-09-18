//
//  ViewViewController.swift
//  TODOList
//
//  Created by Giovanni Olivero on 17/09/2020.
//  Copyright © 2020 Giovanni Olivero. All rights reserved.
//

import RealmSwift
import UIKit

class ViewViewController: UIViewController {
    
    public var item: ToDoListItem?
    
    public var deletionHandler: (() -> Void)?
    
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        dataLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let targetItem = self.item else { return }
        
        realm.beginWrite()
        realm.delete(targetItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
