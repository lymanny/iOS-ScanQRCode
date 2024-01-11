//
//  ViewController.swift
//  ScanQRCode
//
//  Created by lymanny on 2024/01/11.
//

import AVFoundation
import UIKit

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //MARK: - Properties & Variable
    var captureSession      : AVCaptureSession!
    var previewLayer        : AVCaptureVideoPreviewLayer!
    var rectOfInterestArea  = UIView()
    var darkView            = UIView()
    
    var scanRect:CGRect     = CGRect(x: 0, y: 0, width: 0, height: 0)
    let metadataOutput      = AVCaptureMetadataOutput()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.rectOfInterestArea.layer.addSublayer(self.createFrame())
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    //MARK: - Function
    func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        let size          = 280
        let screenWidth   = self.view.frame.size.width
        let screenHeight  = self.view.frame.size.height - 280 //280 size of camera frame
        let topConstraint = screenHeight / 2 //2: top & bottom
        let xPos = (CGFloat(screenWidth) / CGFloat(2)) - (CGFloat(size) / CGFloat(2))
        scanRect = CGRect(x: Int(xPos), y: Int(topConstraint), width: size, height: size)
        
        rectOfInterestArea.frame = scanRect
        
        view.addSubview(rectOfInterestArea)
        
        print(rectOfInterestArea.frame.size.height, " ", rectOfInterestArea.frame.size.width )
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        
        print(previewLayer.frame.size.height, " ", previewLayer.frame.size.width )
        
        view.addSubview(rectOfInterestArea)
        
        
        captureSession.startRunning()
        metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanRect)
        
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func createFrame() -> CAShapeLayer {
        let height: CGFloat = self.rectOfInterestArea.frame.size.height
        let width: CGFloat = self.rectOfInterestArea.frame.size.width
        print(height, " " , width)
        //let h = previewLayer.frame.size.height
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5, y: 50))
        path.addLine(to: CGPoint(x: 5, y: 5))
        path.addLine(to: CGPoint(x: 50, y: 5))
        path.move(to: CGPoint(x: height - 55, y: 5))
        path.addLine(to: CGPoint(x: height - 5, y: 5))
        path.addLine(to: CGPoint(x: height - 5, y: 55))
        path.move(to: CGPoint(x: 5, y: width - 55))
        path.addLine(to: CGPoint(x: 5, y: width - 5))
        path.addLine(to: CGPoint(x: 55, y: width - 5))
        path.move(to: CGPoint(x: width - 55, y: height - 5))
        path.addLine(to: CGPoint(x: width - 5, y: height - 5))
        path.addLine(to: CGPoint(x: width - 5, y: height - 55))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 5
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }
    
    func found(code: String) {
        print("===>", code)
    }
    
}
