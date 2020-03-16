import UIKit

protocol ReusableCell {
  
  var identifier: String { get }
  
}

extension UIView {
  
  func snapToView(_ attachView: UIView) {
    attachView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      attachView.topAnchor.constraint(equalTo: topAnchor),
      attachView.rightAnchor.constraint(equalTo: rightAnchor),
      attachView.bottomAnchor.constraint(equalTo: bottomAnchor),
      attachView.leftAnchor.constraint(equalTo: leftAnchor)
    ])
  }
  
}

extension UINavigationController {
  
  func setupLightContent() {
    navigationBar.barStyle = .black
    navigationBar.barTintColor = .black
    navigationBar.tintColor = .white
    navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.white
    ]
    navigationBar.isTranslucent = false
  }
  
  static var snapedBarStyle: UIBarStyle = .black
  static var snapedBarTintColor: UIColor? = .black
  static var snapedTintColor: UIColor? = .white
  static var snapedTitleTextAttributes: [NSAttributedString.Key : Any]? = [
    .foregroundColor: UIColor.white
  ]
  static var snapedIsTranslucent: Bool = false
  
  func snapSetup() {
    Self.snapedBarStyle = navigationBar.barStyle
    Self.snapedBarTintColor = navigationBar.barTintColor
    Self.snapedTintColor = navigationBar.tintColor
    Self.snapedTitleTextAttributes = navigationBar.titleTextAttributes
    Self.snapedIsTranslucent = navigationBar.isTranslucent
  }
  
  func reverseSetup() {
    navigationBar.barStyle = Self.snapedBarStyle
    navigationBar.barTintColor = Self.snapedBarTintColor
    navigationBar.tintColor = Self.snapedTintColor
    navigationBar.titleTextAttributes = Self.snapedTitleTextAttributes
    navigationBar.isTranslucent = Self.snapedIsTranslucent
  }
  
}

extension UIViewController {
  
  func snapToViewWithSafeAreaTop(_ attachView: UIView) {
    attachView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      attachView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      attachView.rightAnchor.constraint(equalTo: view.rightAnchor),
      attachView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      attachView.leftAnchor.constraint(equalTo: view.leftAnchor)
    ])
  }
  
}

extension UIColor {
  
  static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
  }
  
  static func colorFromHex(_ hex: String) -> UIColor {
    var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if hexString.hasPrefix("#") {
      hexString.remove(at: hexString.startIndex)
    }
    if hexString.count != 6 {
      return UIColor.magenta
    }
    
    var rgb: UInt64 = 0
    Scanner(string: hexString).scanHexInt64(&rgb)
    
    return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
                   green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                   blue: CGFloat(rgb & 0x0000FF) / 255,
                   alpha: 1.0)
  }
  
}

extension UIBarButtonItem {

  func setBackButtonTitleHidden() {
    setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0.0), for: .default)
  }
  
}





