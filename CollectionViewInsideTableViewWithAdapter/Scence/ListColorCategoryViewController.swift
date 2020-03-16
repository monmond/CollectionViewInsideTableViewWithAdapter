import UIKit

protocol ListColorCategoryViewDisplayLogic: class {
  
  func setTitle()
  func setCategorys()
  
}

class ListColorCategoryViewController: UIViewController {
  
  var tableView: UITableView!
  
  var viewModel = ListColorCategoryViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()
    view.addSubview(tableView)
    snapToViewWithSafeAreaTop(tableView)
    
    view.backgroundColor = .black
    tableView.backgroundColor = UIColor.black
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.sectionHeaderHeight = 50
    tableView.rowHeight = 220
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "MainTableViewHeaderView")
    tableView.register(XCollectionTableViewCell.self, forCellReuseIdentifier: "XCollectionTableViewCell")
    
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

extension ListColorCategoryViewController: ListColorCategoryViewDisplayLogic {
  
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

extension ListColorCategoryViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.displayedCategorys.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.displayedCategorys[section].displayedSubcategorys.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainTableViewHeaderView") as! MainTableViewHeaderView
    view.displayed = viewModel.displayedCategorys[section].header
    return view
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "XCollectionTableViewCell", for: indexPath) as! XCollectionTableViewCell
    cell.displayed = viewModel.displayedCategorys[indexPath.section].displayedSubcategorys[indexPath.row]
    cell.delegate = self
    return cell
  }
  
}

extension ListColorCategoryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}

extension ListColorCategoryViewController: XCollectionTableViewCellDelegate {
  
  func tableViewCell(_ tableViewCell: XCollectionTableViewCell, didSelectCollectionViewItemAt indexPath: IndexPath) {
    guard let XCollectionTableViewCellIndexPath = tableView.indexPath(for: tableViewCell) else { return }
    let displayed = viewModel.displayedCategorys[XCollectionTableViewCellIndexPath.section].displayedSubcategorys[XCollectionTableViewCellIndexPath.row]
    print("displayed", displayed.title, displayed.displayedColors[indexPath.row].title)
    let model = viewModel.listColorCategory?.list[XCollectionTableViewCellIndexPath.section]
    print("model", model?.subcategory[XCollectionTableViewCellIndexPath.row] ?? "", model?.colors[XCollectionTableViewCellIndexPath.row][indexPath.row].name ?? "")
  }
  
}
