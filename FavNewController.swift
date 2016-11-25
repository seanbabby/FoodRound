//
//  FavNewController.swift
//  FoodRound
//
//  Created by Chang sean on 2016/10/19.
//  Copyright © 2016年 Chang sean. All rights reserved.
//

import UIKit
import Photos

class FavNewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate{
    
    var imageContainer: UIView!
    var imageView: UIImageView!
    var tableView: UITableView!
    
    var insertContainer: UIScrollView!
    
    var nameLabel: UILabel!
    var typeLabel: UILabel!
    var locationLabel: UILabel!
    var phoneLabel: UILabel!
    
    var nameText: UITextField!
    var typeText: UITextField!
    var typePick: UIPickerView!
    var locationText: UITextField!
    var phoneText: UITextField!
    
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupImage()
        setupInsert()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(handleBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(handleNew))
        
        navigationItem.title = "新增"
    }
    
    func setupInsert() {
        insertContainer = UIScrollView()
        insertContainer.translatesAutoresizingMaskIntoConstraints = false
        insertContainer.backgroundColor = UIColor.white
        insertContainer.clipsToBounds = true
        insertContainer.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        insertContainer.showsHorizontalScrollIndicator = false // 是否顯示水平滑動條
        insertContainer.showsVerticalScrollIndicator = true
        insertContainer.isScrollEnabled = true
        insertContainer.delegate = self
        
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.contentMode = .left
        
        nameText = UITextField()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.borderStyle = .line
        
        typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Type"
        typeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        typeLabel.contentMode = .left
        
        typeText = UITextField()
        typeText.translatesAutoresizingMaskIntoConstraints = false
        typeText.borderStyle = .line
        
        typePick = UIPickerView()
        
        locationLabel = UILabel()
        phoneLabel = UILabel()
        
        view.addSubview(insertContainer)
        insertContainer.addSubview(nameLabel)
        insertContainer.addSubview(nameText)
        insertContainer.addSubview(typeLabel)
        insertContainer.addSubview(typeText)
        
        insertContainer.contentMode = .center
        
        insertContainer.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        insertContainer.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.6).isActive = true
        insertContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor).isActive = true
        insertContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: insertContainer.leftAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 10).isActive = true
        
        nameText.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.95).isActive = true
        nameText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameText.leftAnchor.constraint(equalTo: insertContainer.leftAnchor, constant: 10).isActive = true
        nameText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        
        typeLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: insertContainer.leftAnchor, constant: 10).isActive = true
        typeLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 10).isActive = true
        
        typeText.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.95).isActive = true
        typeText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        typeText.leftAnchor.constraint(equalTo: insertContainer.leftAnchor, constant: 10).isActive = true
        typeText.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        insertContainer.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    func setupImage() {
        imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageContainer)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "photoalbum.png")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        imageView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        imageView.clipsToBounds = true
        imageContainer.addSubview(imageView)
        
        imageContainer.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4).isActive = true
        imageContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        imageContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4).isActive = true
        imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: imageContainer.leftAnchor).isActive = true
    }
    
    func handleSelectProfileImage() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let photosAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default, handler: {ACTION in self.takePhoto()})
        let snapActiion = UIAlertAction(title: "相簿", style: UIAlertActionStyle.default, handler: {ACTION in self.photoAlbum()})
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        //{(alert:UIAlertAction!) in print("Cancel")}
        alertController.addAction(photosAction)
        alertController.addAction(snapActiion)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            imageView.contentMode = .scaleAspectFill
            imageView.image = selectedImage
        }
        
        
//        if let selectedImage = selectedImageFromPicker {
//            uploadToFirebaseStorageUsinImage(image: selectedImage)
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadToFirebaseStorageUsinImage(image: UIImage) {
//        let imageName = NSUUID().uuidString
//        let ref = FIRStorage.storage().reference().child("message_images").child(imageName)
//        
//        if let uploadData = UIImagePNGRepresentation(image) {
//            ref.put(uploadData, metadata: nil, completion: { (metadata, error) in
//                
//                if error != nil {
//                    print("Failed to upload image :", error)
//                    return
//                }
//                
//                if let imageUrl = metadata?.downloadURL()?.absoluteString {
//                    self.sendMessageWithUrl(imageUrl, image: image)
//                }
//            })
//        }
        print("upload!!!!")
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "警告", message: "無法開啟相機", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func photoAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            
            present(picker, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "警告", message: "無法開啟相簿", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleNew() {
        
    }
    
    
}
