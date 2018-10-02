//
//  PageContentViewController.swift
//  Pager
//
//  Created by Mohammed Rokon Uddin on 2/10/18.
//  Copyright © 2018 Monstar Lab Bangladesh Ltd. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    var image: UIImage!
    var index = 0
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

}
