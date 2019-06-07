# DataPickerLib2

[![CI Status](https://img.shields.io/travis/antony@123789.org/DataPickerLib2.svg?style=flat)](https://travis-ci.org/antony@123789.org/DataPickerLib2)
[![Version](https://img.shields.io/cocoapods/v/DataPickerLib2.svg?style=flat)](https://cocoapods.org/pods/DataPickerLib2)
[![License](https://img.shields.io/cocoapods/l/DataPickerLib2.svg?style=flat)](https://cocoapods.org/pods/DataPickerLib2)
[![Platform](https://img.shields.io/cocoapods/p/DataPickerLib2.svg?style=flat)](https://cocoapods.org/pods/DataPickerLib2)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DataPickerLib2 is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DataPickerLib2'
```
## Use
```
- Use custom classes for textfield and buttons
- manage data format in array of array
- copy viewcontroller containg pickerview from storyboard and pase in yourstoryboard

    var selectedTextF: PickerInpuTF!
    var selectedButton: PickerInpuB!

    override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                customTextF.parentData = dataArr
                customTextF.data = [Any](repeating: 0, count: customTextF.parentData.count)
                dateTextF.data = [Any](repeating: 0, count: 1)
                committedStoredData = [Any](repeating: 0, count: 1)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextF = (textField as! PickerInpuTF)
        self.performSegue(withIdentifier: "select_data", sender: self)
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destination.
                // Pass the selected object to the new view controller.
            if segue.identifier == "select_data" {

            let selectCountryVC = segue.destination as! SelectViewController
            selectCountryVC.providesPresentationContextTransitionStyle = true
            selectCountryVC.definesPresentationContext = true
            selectCountryVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            selectCountryVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            selectCountryVC.delegate = self
            if selectedTextF == self.dateTextF {
                selectCountryVC.type = PickerType.DateOpt
            }
            //selectCountryVC.dataArray = [["England","India","Afghanistan","South Africa","Pakistan","Bangladesh","West Indies","Australia"],["Asia","Africa","Europe","Australia"],["Warm","Cold"]]
            selectCountryVC.dataArray = self.selectedTextF.parentData as! [[String]]
            selectCountryVC.committedStoredData = self.selectedTextF.data
            print("Segue Performing")
        }
    }
```
## Author

antony@123789.org

## License

DataPickerLib2 is available under the MIT license. See the LICENSE file for more info.
