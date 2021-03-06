import VisionKit
import PDFKit

final class ScannerViewController: UIViewController {
        
    fileprivate func setupNewDocumentCameraViewController() {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.view.translatesAutoresizingMaskIntoConstraints = false
        documentCameraViewController.willMove(toParent: self)
        view.addSubview(documentCameraViewController.view)
        addChild(documentCameraViewController)
        documentCameraViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            documentCameraViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            documentCameraViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            documentCameraViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            documentCameraViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        documentCameraViewController.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Scan"
        
        setupNewDocumentCameraViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ScannerViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount >= 1 else {
            controller.dismiss(animated: true)
            return
        }
        
        DispatchQueue.main.async { [weak self] in

            guard let self = self else {
                return
            }
            
            let pdfVC = ScannedDocumentViewController(scannedDocument: scan)
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
        
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        
        setupNewDocumentCameraViewController()
    }

}
