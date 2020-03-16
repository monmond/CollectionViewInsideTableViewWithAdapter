import UIKit

struct DisplayedMainCollectionViewCell: ReusableCell {
  
  var identifier: String
  var color: UIColor
  var title: String
  
}

class MainCollectionViewCell: UICollectionViewCell {
  
  var colorStackView: UIStackView!
  var colorView: UIView!
  var titleLabel: UILabel!
  var bottomSpacingView: UIView!
  
  var displayed: ReusableCell? {
    didSet {
      if let displayed = displayed as? DisplayedMainCollectionViewCell {
        colorView.backgroundColor = displayed.color
        titleLabel.text = displayed.title
      } else {
        colorView.backgroundColor = UIColor.darkGray
        titleLabel.text = nil
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    colorStackView = UIStackView()
    colorView = UIView()
    titleLabel = UILabel()
    bottomSpacingView = UIView()
    contentView.addSubview(colorStackView)
    colorStackView.addArrangedSubview(colorView)
    colorStackView.addArrangedSubview(titleLabel)
    contentView.snapToView(colorStackView)
    colorView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor, multiplier: 1),
      bottomSpacingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
    ])
    
    contentView.backgroundColor = UIColor.black
    colorStackView.axis = .vertical
    colorStackView.distribution = .fill
    colorStackView.alignment = .center
    colorView.backgroundColor = UIColor.black
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    bottomSpacingView.backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    displayed = nil
  }
  
}
