class CaptureController < UIViewController

  def viewDidAppear(animated)

    session = AVCaptureSession.new
    session.setSessionPreset(AVCaptureSessionPresetHigh)

    device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

    input = AVCaptureDeviceInput.deviceInputWithDevice(device, error: nil)

    session.addInput(input) if session.canAddInput(input)

    av_layer = AVCaptureVideoPreviewLayer.layerWithSession(session)
    av_layer.setVideoGravity(AVLayerVideoGravityResizeAspectFill)
    av_layer.frame = preview.bounds
    preview.layer.addSublayer(av_layer)

    output = AVCaptureVideoDataOutput.new
    output.videoSettings = {KCVPixelBufferPixelFormatTypeKey => KCVPixelFormatType_420YpCbCr8BiPlanarFullRange}

    output.setAlwaysDiscardsLateVideoFrames(true)

    session.addOutput(output) if session.canAddOutput(output)

    output.connections.each do |connection|
      if connection.isVideoOrientationSupported
        connection.setVideoOrientation(AVCaptureVideoOrientationPortrait)
      end
    end

    session.commitConfiguration

    queue = Dispatch::Queue.new("VideoQueue")
    output.setSampleBufferDelegate(self, queue: queue.dispatch_object)

    session.startRunning

  end

  def captureOutput(captureOutput, didOutputSampleBuffer: sampleBuffer, fromConnection: connection)
    NSLog '***************************************'
  end

  def preview
    @preview ||= begin
      preview = UIView.alloc.initWithFrame( CGRectMake(0, 0, 320, 480) )
      view.addSubview preview
      preview
    end
  end

end
