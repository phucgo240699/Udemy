////
////  Document.swift
////  Udemy
////
////  Created by Phúc Lý on 25/12/2020.
////  Copyright © 2020 Phúc Lý. All rights reserved.
////
//
//import UIKit
//import MobileCoreServices
//import UniformTypeIdentifiers
//
//
//public enum SourceType: Int {
//    case files
//    case folder
//}
//
//protocol DocumentDelegate: class {
//    func didPickDocuments(documents: [Document]?)
//}
//
//class Document: UIDocument {
//    var data: Data?
//    override func contents(forType typeName: String) throws -> Any {
//        guard let data = data else { return Data() }
//        return try NSKeyedArchiver.archivedData(withRootObject:data,
//            requiringSecureCoding: true)
//    }
//    override func load(fromContents contents: Any, ofType typeName:
//        String?) throws {
//        guard let data = contents as? Data else { return }
//        self.data = data
//    }
//}
//
//open class DocumentPicker: NSObject {
//    private var pickerController: UIDocumentPickerViewController?
//    private weak var presentationController: UIViewController?
//    private weak var delegate: DocumentDelegate?
//    private var folderURL: URL?
//    private var sourceType: SourceType!
//    private var documents = [Document]()
//    init(presentationController: UIViewController,
//        delegate:   DocumentDelegate) {
//        super.init()
//        self.presentationController = presentationController
//        self.delegate = delegate
//    }
//    
//    public func present(from sourceView: UIView) {
//        let alertController = UIAlertController(title:
//        "Select From",message: nil, preferredStyle: .actionSheet)
//        if let action = self.fileAction(for: .files, title: "Files") {
//            alertController.addAction(action)
//        }
//        if let action = self.folderAction(for: .folder, title:
//            "Folder") {
//            alertController.addAction(action)
//        }
//        alertController.addAction(UIAlertAction(title:
//            "Cancel", style: .cancel, handler: nil))
//        self.presentationController?.present(alertController,
//             animated: true)
//    }
//    
//    public func folderAction(for type: SourceType,
//        title: String) -> UIAlertAction? {
//        return UIAlertAction(title: title, style: .default) {
//        [unowned   self] _ in
//        self.pickerController = UIDocumentPickerViewController(
//                                documentTypes: [kUTTypeFolder as String]
//                                , in .open)
//        self.pickerController!.delegate = self
//        self.sourceType = type
//        self.presentationController?.present(self.pickerController!,
//                                             animated: true)
//        }
//    }
//    
//    public func fileAction(for type: SourceType,
//        title: String) -> UIAlertAction? {
//        return UIAlertAction(title: title, style: .default) {
//        [unowned self] _ in
//        self.pickerController = UIDocumentPickerViewController(
//                                documnetTypes: [kUTTypeMovie as String,
//                                kUTTypeImage as String, in: .open)
//        self.pickerController!.delegate = self
//        self.pickerController!.allowsMultipleSelection = true
//        self.sourceType = type
//        self.presentationController?.present(self.pickerController!,
//                                             animated: true)
//        }
//    }
//    
//    private func documentFromURL(pickedURL: URL) {
//        let shouldStopAccessing =
//         pickedURL.startAccessingSecurityScopedResource()
//         defer {
//            if shouldStopAccessing {
//                pickedURL.stopAccessingSecurityScopedResource()
//         }
//     
//         NSFileCoordinator().coordinate(readingItemAt: pickedURL, error:
//         NSErrorPointer.none) { (folderURL) in
//            do {
//                let keys: [URLResourceKey] = [.nameKey, .isDirectoryKey]
//                let fileList = try FileManager.default.enumerator(at:
//                pickedURL, includingPropertiesForKeys: keys)
//                switch sourceType {
//                     case .files:
//                          let document = Document(fileURL: pickedURL)
//                          documents.append(document)
//                     case .folder:
//                          for case let fileURL as URL in fileList! {
//                             if !fileURL.isDirectory {
//                             let document = Document(fileURL: fileURL)
//                             documents.append(document)
//                             }
//                           }
//                     case .none: break
//                }
//              } catch let error {
//                  print("error: ", error.localizedDescription)
//              }
//         }
//    }
//    
//}
//    
//extension URL {
//    var isDirectory: Bool! {
//        return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory
//    }
//}
//
//extension DocumentPicker: UIDocumentPickerDelegate {
//    
//    public func documentPicker(_ controller:
//        UIDocumentPickerViewController,
//        didPickerDocumentsAt urls: [URL] {
//        guard let url = urls.first else { return }
//        documentFromURL(pickedURL: url)
//        delegate?.didPickDocuments(documents: documents)
//    }
//    public func documentPicker WasCancelled(_ controller:
//        UIDocumentPickerViewController) {
//        delegate?.didPickDocuments(documents: nil)
//    }
//}
