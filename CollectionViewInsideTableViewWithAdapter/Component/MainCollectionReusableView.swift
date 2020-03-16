import UIKit

struct DisplayedMainCollectionReusableView: ReusableCell {
  
  var identifier: String
  var title: String
  
}

class MainCollectionReusableView: UICollectionReusableView {
  
  var titleLabel: UILabel!
  
  var displayed: DisplayedMainCollectionReusableView? {
    didSet {
      if let displayed = displayed {
        titleLabel?.text = displayed.title
      } else {
        titleLabel?.text = nil
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    titleLabel = UILabel()
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
    ])

    backgroundColor = UIColor.black
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
