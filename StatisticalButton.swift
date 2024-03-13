import UIKit

class StatisticalButton: UIButton {
    private let percentage = UILabel()
    private let statisticType = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        percentage.textAlignment = .center
        percentage.font = UIFont.systemFont(ofSize: 22)
        percentage.accessibilityLabel = "accessibility %."
        addSubview(percentage)
   
        statisticType.textAlignment = .center
        statisticType.font = UIFont.systemFont(ofSize: 16)
        statisticType.textColor = UIColor.gray
        statisticType.accessibilityLabel = "Category"
        addSubview(statisticType)

        percentage.translatesAutoresizingMaskIntoConstraints = false
        statisticType.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            percentage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            percentage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            statisticType.topAnchor.constraint(equalTo: percentage.bottomAnchor, constant: 0),
            statisticType.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
            print("Tapped")
        }

    func setMainText(_ text: String) {
        percentage.text = text
    }
    
    func setAdditionalText(_ text: String) {
        statisticType.text = text
    }
}
