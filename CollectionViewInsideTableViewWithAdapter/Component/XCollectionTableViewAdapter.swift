import UIKit

protocol XCollectionTableViewAdapterDataSource: class {
  
  var xCollectionTableViewAdapterDataSource: DisplayedXCollectionTableViewAdapter { get }
  
}

struct DisplayedXCollectionTableViewAdapter {
  
  struct Section {
    
    var header: DisplayedMainTableViewHeaderView?
    var rows: [DisplayedXCollectionTableViewCell] = []
    
  }
  
  var sections: [DisplayedXCollectionTableViewAdapter.Section]
  
}

class XCollectionTableViewAdapter: NSObject {
  
  private var tableView: UITableView!
  weak var dataSoruce: XCollectionTableViewAdapterDataSource?
  weak var delegate: XCollectionTableViewCellDelegate?
  
  var sections: [DisplayedXCollectionTableViewAdapter.Section] {
    return dataSoruce?.xCollectionTableViewAdapterDataSource.sections ?? []
  }
  
  init(tableView: UITableView) {
    self.tableView = tableView
    super.init()
    self.tableView.separatorStyle = .none
    self.tableView.showsVerticalScrollIndicator = false
    self.tableView.sectionHeaderHeight = 50
    self.tableView.rowHeight = 220
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "MainTableViewHeaderView")
    self.tableView.register(XCollectionTableViewCell.self, forCellReuseIdentifier: "XCollectionTableViewCell")
  }
  
}

extension XCollectionTableViewAdapter: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainTableViewHeaderView") as! MainTableViewHeaderView
    view.displayed = sections[section].header
    return view
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "XCollectionTableViewCell", for: indexPath) as! XCollectionTableViewCell
    cell.displayed = sections[indexPath.section].rows[indexPath.row]
    cell.delegate = delegate
    return cell
  }
  
}

extension XCollectionTableViewAdapter: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}
