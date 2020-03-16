import Foundation

class ListColorCategoryViewModel {
  
  struct DisplayedCategory {
    
    var header: DisplayedMainTableViewHeaderView?
    var displayedSubcategorys: [DisplayedXCollectionTableViewCell] = []
    
  }
  
  var listColorCategory: ListColorCategory?
  
  var displayedTitle: String = ""
  var displayedCategorys: [DisplayedCategory] = []
  
  weak var viewController: ListColorCategoryViewDisplayLogic?
  
  func fetchData() {
    ColorApi().fetchColors { [weak self] colors in
      guard let self = self else { return }
      self.listColorCategory = colors
      self.displayedTitle = "Colors #First"
      self.viewController?.setTitle()
      guard let colors = self.listColorCategory else {
        self.displayedCategorys = []
        self.viewController?.setCategorys()
        return
      }
      self.displayedCategorys = colors.list.map { self.mapCategory($0) }
      self.viewController?.setCategorys()
    }
  }
  
}

fileprivate extension ListColorCategoryViewModel {
  
  func mapCategory(_ color: ColorCategory) -> DisplayedCategory {
    
    return DisplayedCategory(header: DisplayedMainTableViewHeaderView(identifier: "", title: color.category),
                             displayedSubcategorys: color.subcategory.enumerated().map {
                              mapSubCategory($0.element, colors: color.colors[$0.offset])
    })
  }
  
  func mapSubCategory(_ subcategory: String, colors: [Color]) -> DisplayedXCollectionTableViewCell {
    return DisplayedXCollectionTableViewCell(identifier: "",
                                             title: subcategory,
                                             displayedColors: colors.map {
                                              DisplayedMainCollectionViewCell(identifier: "", color: $0.color, title: $0.name)
    })
  }
  
}

