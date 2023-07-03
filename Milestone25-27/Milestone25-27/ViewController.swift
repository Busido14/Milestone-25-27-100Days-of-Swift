//
//  ViewController.swift
//  Milestone25-27
//
//  Created by Артем Чжен on 24/05/23.
//

import UIKit

enum  textPosition {
    case top
    case bottom
}

class ViewController:  UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var topButton: UIButton!
    @IBOutlet var bottomButton: UIButton!
    
    var topText = NSAttributedString()
    var bottomText = NSAttributedString()
    var animation = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.isHidden = true
        bottomLabel.isHidden = true
        topButton.isHidden = true
        bottomButton.isHidden = true
        
        title = "Meme generation"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addedPicture))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", image: .actions, target: self, action: #selector(sharePicture))
    }
    
    @objc func addedPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:  true)
    }
    
    @objc func sharePicture() {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        animation = image
        imageView.image = animation
        topButton.isHidden = false
        bottomButton.isHidden = false
    }
    
    @IBAction func topTextTapped(_ sender: Any) {
        topLabel.isHidden = false
        let ac = UIAlertController(title: "Top text", message: "Enter text for the top of the image", preferredStyle: .alert)
        ac.addTextField()
        let setText = UIAlertAction(title: "Set Text", style: .default) {
            [weak self, weak ac] action in
            guard let text = ac?.textFields?[0].text else { return }
            self?.setText(text, textPosition.top)
        }
        ac.addAction(setText)
        present(ac, animated: true)
    }
    
    @IBAction func bottomTextTapped(_ sender: Any) {
        bottomLabel.isHidden = false
        let ac = UIAlertController(title: "Bottom text", message: "Enter text for the top of the image", preferredStyle: .alert)
        ac.addTextField()
        let setText = UIAlertAction(title: "Set Text", style: .default) {
            [weak self, weak ac] action in
            guard let text = ac?.textFields?[0].text else { return }
            self?.setText(text, textPosition.bottom)
        }
        ac.addAction(setText)
        present(ac, animated: true)
    }
    
    func setText(_ text: String, _ position: textPosition) {
        let font = UIFont(name: "AvenirNextCondensed-Bold", size: 48)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .strokeWidth: -4.0,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: textAttributes)
        
        if position == textPosition.top {
            topLabel.attributedText = attributedString
            topText = attributedString
        } else {
            bottomLabel.attributedText = attributedString
            bottomText = attributedString
        }
    }
}
