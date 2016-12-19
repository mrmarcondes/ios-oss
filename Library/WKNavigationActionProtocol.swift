#if os(iOS)
  import WebKit

  public struct WKNavigationActionData {
    public let navigationAction: WKNavigationAction
    public let navigationType: WKNavigationType
    public let request: URLRequest
    public let sourceFrame: WKFrameInfoData
    public let targetFrame: WKFrameInfoData?

    public init(navigationAction: WKNavigationAction) {
      self.navigationAction = navigationAction
      self.navigationType = navigationAction.navigationType
      self.request = navigationAction.request as URLRequest
      self.sourceFrame = .init(frameInfo: navigationAction.sourceFrame)
      self.targetFrame = navigationAction.targetFrame.map(WKFrameInfoData.init(frameInfo:))
    }

    internal init(navigationType: WKNavigationType,
                  request: URLRequest,
                  sourceFrame: WKFrameInfoData,
                  targetFrame: WKFrameInfoData?) {
      self.navigationAction = WKNavigationAction()
      self.navigationType = navigationType
      self.request = request
      self.sourceFrame = sourceFrame
      self.targetFrame = targetFrame
    }
  }

  public struct WKFrameInfoData {
    public let frameInfo: WKFrameInfo
    public let mainFrame: Bool
    public let request: URLRequest

    public init(frameInfo: WKFrameInfo) {
      self.frameInfo = frameInfo
      self.mainFrame = frameInfo.isMainFrame
      self.request = frameInfo.request as URLRequest
    }

    public init(mainFrame: Bool, request: URLRequest) {
      self.frameInfo = WKFrameInfo()
      self.mainFrame = mainFrame
      self.request = request
    }
  }

  // Deprecated stuff

  @available(*, deprecated, message: "Use WKNavigationActionData to handle navigation actions")
  public protocol WKNavigationActionProtocol {
    var navigationType: WKNavigationType { get }
    var request: URLRequest { get }
  }

  @available(*, deprecated, message: "Use WKNavigationActionData to handle navigation actions")
  extension WKNavigationAction: WKNavigationActionProtocol {}

  @available(*, deprecated, message: "Use WKNavigationActionData to handle navigation actions")
  internal struct MockNavigationAction: WKNavigationActionProtocol {
    internal let navigationType: WKNavigationType
    internal let request: URLRequest
  }
#endif
