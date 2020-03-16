import Foundation

class ListColorCategoryAdapterViewModel {
  
  var listColorCategory: ListColorCategory?
  
  var displayedTitle: String = ""
  var displayedColor = DisplayedXCollectionTableViewAdapter(sections: [])
  
  weak var viewController: ListColorCategoryAdapterViewController?
  
  func fetchData() {
    ColorApi().fetchColors { [weak self] colors in
      guard let self = self else { return }
      self.listColorCategory = colors
      self.displayedTitle = "Colors #Second"
      self.viewController?.setTitle()
      guard let colors = self.listColorCategory else {
        self.displayedColor = DisplayedXCollectionTableViewAdapter(sections: [])
        self.viewController?.setCategorys()
        return
      }
      self.displayedColor = DisplayedXCollectionTableViewAdapter(sections: colors.list.map { self.mapSection($0) })
      self.viewController?.setCategorys()
    }
  }
  
}

fileprivate extension ListColorCategoryAdapterViewModel {
  
  func mapSection(_ color: ColorCategory) -> DisplayedXCollectionTableViewAdapter.Section {
    return DisplayedXCollectionTableViewAdapter.Section(header: DisplayedMainTableViewHeaderView(identifier: "", title: color.category),
                                                        rows: color.subcategory.enumerated().map {
                                                          mapCollection($0.element, colors: color.colors[$0.offset])
    })
  }
  
  func mapCollection(_ subcategory: String, colors: [Color]) -> DisplayedXCollectionTableViewCell {
    return DisplayedXCollectionTableViewCell(identifier: "",
                                             title: subcategory,
                                             displayedColors: colors.map {
                                              DisplayedMainCollectionViewCell(identifier: "", color: $0.color, title: $0.name)
    })
  }
  
}
