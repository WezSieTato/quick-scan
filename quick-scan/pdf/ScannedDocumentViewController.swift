import UIKit
import VisionKit
import PDFKit

final class ScannedDocumentViewController: UIViewController {
    let scannedDocument: VNDocumentCameraScan
    
    var scannedPdfView: ScannedDocumentView {
        view as! ScannedDocumentView
    }

    init(scannedDocument: VNDocumentCameraScan) {
        self.scannedDocument = scannedDocument
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScannedDocumentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannedPdfView.pdfView.document = scannedDocument.pdfDocument

        let shareItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(share))
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(settings))
        
        navigationItem.rightBarButtonItems = [shareItem, settingsItem]
    }
    
    @objc
    private func share() {
        if let pdfData = scannedDocument.pdfDocument.dataRepresentation() {
            let objectsToShare = [pdfData]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc
    private func settings() {
        
    }
}
