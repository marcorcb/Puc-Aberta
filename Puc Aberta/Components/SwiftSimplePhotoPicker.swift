//
//  SwiftSimplePhotoPicker.swift
//  SwiftSimplePhotoPickerExample
//
//  Created by Marco Braga on 11/08/17.
//  Copyright © 2017 Marco Braga. All rights reserved.
//

import UIKit

class SwiftSimpleImagePickerController: UIImagePickerController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class SwiftSimplePhotoPicker: NSObject {
    static let shared = SwiftSimplePhotoPicker()

    var imagePickerController: SwiftSimpleImagePickerController
    var completionBlock: ((UIImage) -> Void)?

    override init() {
        self.imagePickerController = SwiftSimpleImagePickerController()

        super.init()

        self.imagePickerController.navigationBar.isTranslucent = false
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true
    }

    func showPicker(in viewController: UIViewController, completion: @escaping (UIImage) -> Void) {
        self.completionBlock = completion

        let actionSheet = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Escolher foto", style: .default, handler: { (_) in
            self.imagePickerController.sourceType = .photoLibrary
            viewController.present(self.imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Tirar foto", style: .default, handler: { (_) in
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraDevice = .front
            self.imagePickerController.cameraFlashMode = .off

            viewController.present(self.imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = viewController.view
            popoverPresentationController.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                                              y: viewController.view.bounds.midY,
                                                              width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }

        viewController.present(actionSheet, animated: true, completion: nil)
    }

    func fixOrientation(for image: UIImage) -> UIImage {
        if image.imageOrientation == .up {
            return image
        }

        var transform: CGAffineTransform = .identity

        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = CGAffineTransform(translationX: image.size.width, y: image.size.height)
            transform = CGAffineTransform(rotationAngle: .pi)

        case .left, .leftMirrored:
            transform = CGAffineTransform(translationX: image.size.width, y: 0.0)
            transform = CGAffineTransform(rotationAngle: .pi / 2)

        case .right, .rightMirrored:
            transform = CGAffineTransform(translationX: 0, y: image.size.height)
            transform = CGAffineTransform(rotationAngle: -(.pi / 2))

        case .up, .upMirrored:
            break
        @unknown default:
            break
        }

        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = CGAffineTransform(translationX: image.size.width, y: 0.0)
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        case .leftMirrored, .rightMirrored:
            transform = CGAffineTransform(translationX: image.size.height, y: 0.0)
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }

        let context: CGContext = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height),
                                           bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                           space: image.cgImage!.colorSpace!,
                                           bitmapInfo: image.cgImage!.bitmapInfo.rawValue)!

        context.concatenate(transform)

        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(image.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: image.size.height, height: image.size.width))
        default:
            context.draw(image.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
        }

        let cgImage: CGImage = context.makeImage()!
        let fixedImage: UIImage = UIImage(cgImage: cgImage)

        return fixedImage
    }
}

extension UIAlertController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SwiftSimplePhotoPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        let editedImage: UIImage = fixOrientation(for: info[UIImagePickerController.InfoKey.editedImage]
            as? UIImage ?? UIImage())
        if self.completionBlock != nil {
            DispatchQueue.main.async {
                self.completionBlock!(editedImage)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
