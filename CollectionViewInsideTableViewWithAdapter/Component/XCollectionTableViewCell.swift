import UIKit

protocol XCollectionTableViewCellDelegate: class {
  
  func tableViewCell(_ tableViewCell: XCollectionTableViewCell, didSelectCollectionViewItemAt indexPath: IndexPath)
  
}

struct DisplayedXCollectionTableViewCell: ReusableCell {
  
  var identifier: String
  var title: String
  var displayedColors: [DisplayedMainCollectionViewCell]
  
}

class XCollectionTableViewCell: UITableViewCell {
  
  var titleLabel: UILabel!
  var collectionViewFlowLayout: UICollectionViewFlowLayout!
  var collectionView: UICollectionView!
  
  var displayed: ReusableCell? {
    didSet {
      if let display = displayed as? DisplayedXCollectionTableViewCell {
        titleLabel.text = display.title
      } else {
        titleLabel.text = nil
      }
      collectionView.reloadData()
    }
  }
  weak var delegate: XCollectionTableViewCellDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    titleLabel = UILabel()
    collectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    contentView.addSubview(titleLabel)
    contentView.addSubview(collectionView)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 190)
    ])
                                 
    contentView.backgroundColor = UIColor.black
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    collectionViewFlowLayout.scrollDirection = .horizontal
    collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    collectionViewFlowLayout.minimumLineSpacing = 2.0
    collectionViewFlowLayout.minimumInteritemSpacing = 5.0
    collectionViewFlowLayout.itemSize = CGSize(width: 150, height: 180)
    collectionView.backgroundColor = UIColor.black
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    displayed = nil
  }
  
}

extension XCollectionTableViewCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let displayed = displayed as? DisplayedXCollectionTableViewCell else { return 0 }
    return displayed.displayedColors.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
      guard let displayed = displayed as? DisplayedXCollectionTableViewCell else { return UICollectionViewCell() }
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
      cell.displayed = displayed.displayedColors[indexPath.row]
      return cell
  }
  
}

extension XCollectionTableViewCell: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.tableViewCell(self, didSelectCollectionViewItemAt: indexPath)
  }
  
}
