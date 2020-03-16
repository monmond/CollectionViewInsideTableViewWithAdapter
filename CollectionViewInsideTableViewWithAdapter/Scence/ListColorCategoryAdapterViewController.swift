import UIKit

protocol ListColorCategoryAdapterViewDisplayLogic: class {
  
  func setTitle()
  func setCategorys()
  
}

class ListColorCategoryAdapterViewController: UIViewController {
  
  var tableView: UITableView!
  
  var xCollectionTableViewAdapter: XCollectionTableViewAdapter!
  var viewModel = ListColorCategoryAdapterViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()
    view.addSubview(tableView)
    snapToViewWithSafeAreaTop(tableView)
    
    view.backgroundColor = .black
    tableView.backgroundColor = UIColor.black
    
    xCollectionTableViewAdapter = XCollectionTableViewAdapter(tableView: tableView)
    xCollectionTableViewAdapter.dataSoruce = self
    xCollectionTableViewAdapter.delegate = self
    viewModel.viewController = self
    viewModel.fetchData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.snapSetup()
    navigationController?.setupLightContent()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.reverseSetup()
  }
  
}

extension ListColorCategoryAdapterViewController: ListColorCategoryViewDisplayLogic {
  
  func setTitle() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.navigationItem.title = self.viewModel.displayedTitle
    }
  }
  
  func setCategorys() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }
  
}

extension ListColorCategoryAdapterViewController: XCollectionTableViewAdapterDataSource {
  
  var xCollectionTableViewAdapterDataSource: DisplayedXCollectionTableViewAdapter {
    return viewModel.displayedColor
  }
  
}

extension ListColorCategoryAdapterViewController: XCollectionTableViewCellDelegate {
  
  func tableViewCell(_ tableViewCell: XCollectionTableViewCell, didSelectCollectionViewItemAt indexPath: IndexPath) {
    guard let xCollectionTableViewCellIndexPath = tableView.indexPath(for: tableViewCell) else { return }
    let displayed = viewModel.displayedColor.sections[xCollectionTableViewCellIndexPath.section].rows[xCollectionTableViewCellIndexPath.row]
    print("displayed", displayed.title, displayed.displayedColors[indexPath.row].title)
    let model = viewModel.listColorCategory?.list[xCollectionTableViewCellIndexPath.section]
    print("model", model?.subcategory[xCollectionTableViewCellIndexPath.row] ?? "", model?.colors[xCollectionTableViewCellIndexPath.row][indexPath.row].name ?? "")
  }
  
}
