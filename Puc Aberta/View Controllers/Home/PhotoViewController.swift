//
//  PhotoViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 06/05/19.
//  Copyright © 2019 Marco Braga. All rights reserved.
//

import UIKit

class PhotoViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shareButton: UIButton!

    // MARK: - Properties

    private var dataSource = [UIImage]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    // MARK: - Private

    func setupUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isHidden = true
        self.shareButton.isEnabled = false
        self.dataSource = [#imageLiteral(resourceName: "filter01"), #imageLiteral(resourceName: "filter02"), #imageLiteral(resourceName: "filter03"), #imageLiteral(resourceName: "filter04")]
    }

    // MARK: - Actions

    @IBAction func takePhoto(_ sender: Any) {
        SwiftSimplePhotoPicker.shared.showPicker(in: self) { (photo) in
            self.photoImageView.image = photo
            self.collectionView.isHidden = false
            self.shareButton.isEnabled = true
            self.collectionView.reloadData()
        }
    }

    @IBAction func share(_ sender: Any) {
        guard let image = self.photoImageView.image,
            let cell = self.collectionView.visibleCells.first as? FilterCollectionViewCell,
            let filterImage = cell.imageView.image,
            let imageToShare = image.overlayed(with: filterImage) else {
                return
        }

        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath)
            as? FilterCollectionViewCell {
            cell.imageView.image = self.dataSource[indexPath.row]
            return cell
        }

        return UICollectionViewCell()
    }
}
