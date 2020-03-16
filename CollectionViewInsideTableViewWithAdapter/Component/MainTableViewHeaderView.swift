import UIKit

struct DisplayedMainTableViewHeaderView: ReusableCell {
  
  var identifier: String
  var title: String
  
}

class MainTableViewHeaderView: UITableViewHeaderFooterView {
  
  var titleLabel: UILabel!
  
  var displayed: ReusableCell? {
    didSet {
      if let displayed = displayed as? DisplayedMainTableViewHeaderView {
        titleLabel?.text = displayed.title
      } else {
        titleLabel?.text = nil
      }
    }
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    titleLabel = UILabel()
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8)
    ])
    
    contentView.backgroundColor = UIColor.black
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    displayed = nil
  }
  
}
