import Foundation

struct ColorApi {
  
  func fetchColors(_ completionHandler: @escaping (Colors) -> ()) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(1)) {
      completionHandler(Colors())
    }
  }
  
}
