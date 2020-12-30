//
//  CreateLessonVC.swift
//  Udemy
//
//  Created by Phúc Lý on 25/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

protocol CreateLessonVCDelegate: class {
    func didCreateLessonSuccess(lesson: Lesson)
    func didUpdateLessonSuccess(lesson: Lesson, indexPath: IndexPath)
}

class CreateLessonVC: UIViewController {

    // Components UI
    var addBarBtn: UIBarButtonItem?
    @IBOutlet weak var tfTitle: UITextField!
    
    @IBOutlet weak var addDocumentBtn: UIButton!
    @IBOutlet weak var addVideoBtn: UIButton!
    @IBOutlet weak var imgViewVideoFile: UIImageView!
    @IBOutlet weak var imgViewDocFile: UIImageView!
    
    var id: String?
    var titleCourse: String?
    var video: Data?
    var document: Data?
    var documentName: String?
    var idCourse: String?
    var order: Int?
    
    var isEditForm: Bool?
    var indexPath: IndexPath?
    
    // Delegate
    weak var delegate: CreateLessonVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEditForm == true {
            addDocumentBtn.isEnabled = false
            addDocumentBtn.isHidden = true
            addVideoBtn.isEnabled = false
            addVideoBtn.isHidden = true
            tfTitle.text = titleCourse
        }
        
        // Navigation Bar
        addBarBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(CreateLessonVC.addBarBtnPressed(_:)))
        addBarBtn?.isEnabled = false
        navigationItem.rightBarButtonItem = addBarBtn
        
        // Text Field
        tfTitle.delegate = self
        
    }

    @IBAction func addDocumentBtnPressed(_ sender: UIButton) {
        showPickerDocument()
    }
    
    @IBAction func addVideoBtnPressed(_ sender: UIButton) {
        showPickerVideoActionSheet()
    }
    
    @objc func addBarBtnPressed(_ sender: UIBarButtonItem) {
        if isEditForm == true, let indexPath = self.indexPath {
            RequestAPI.shared.updateLesson(by: id, idCourse: idCourse, order: order, title: tfTitle.text) { (lesson) in
                self.delegate?.didUpdateLessonSuccess(lesson: lesson, indexPath: indexPath)
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            if let documentName = documentName {
                RequestAPI.shared.createLesson(title: tfTitle.text, idCourse: idCourse, order: order, video: video, document: document, documentName: documentName) { (lesson) in
                    self.delegate?.didCreateLessonSuccess(lesson: lesson)
                }
            }
        }
    }
    
    func isValidCreateLesson() -> Bool {
        guard let title = tfTitle.text else {
            return false
        }
        if title.isEmptyOrSpacing() {
            return false
        }
        if order == nil {
            return false
        }
        if idCourse == nil {
            return false
        }
        
        if isEditForm == true {
            return true
        }
        
        if video == nil {
            return false
        }
        if document == nil {
            return false
        }
        
        return true
    }
}



// MARK: Pick Video
extension CreateLessonVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showPickerVideoActionSheet() {
        
        let alert = UIAlertController(title: "Videos", message: "Choose an option to continue" , preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.getVideo(fromSourceType: .camera)
        })
        let libraryAction = UIAlertAction(title: "Library", style: .default , handler:{ (UIAlertAction)in
            self.getVideo(fromSourceType: .photoLibrary)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
        })
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getVideo(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let videoUrl = info[.mediaURL] as? URL else {
            return
        }
        do {
            video = try Data(contentsOf: videoUrl)
            imgViewVideoFile.isHidden = false
        } catch  {
            print(error)
            imgViewVideoFile.isHidden = true
        }
        
        // Update add bar button
        addBarBtn?.isEnabled = isValidCreateLesson()
        
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Pick Document
extension  CreateLessonVC: UIDocumentPickerDelegate {
    func showPickerDocument() {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import  )
        picker.delegate = self
        picker.modalPresentationStyle = .formSheet
        present(picker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileUrl = urls.first else {
            return
        }
        
        do {
            document = try Data(contentsOf: selectedFileUrl)
            documentName = selectedFileUrl.lastPathComponent.split(separator: " ").joined(separator: "%20")
            imgViewDocFile.isHidden = false
            
            // Update add bar button
            addBarBtn?.isEnabled = isValidCreateLesson()
            
        } catch {
            print(error)
        }
    }
}


// MARK: TextField Delegate
extension CreateLessonVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Update add bar button
        addBarBtn?.isEnabled = isValidCreateLesson()
    }
}
