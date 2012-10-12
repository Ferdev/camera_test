class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    capture_controller = CaptureController.new
    capture_controller.wantsFullScreenLayout = true

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = capture_controller
    @window.makeKeyAndVisible
    true
  end
end
