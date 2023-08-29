# ConCurrency                  
<img src="https://github.com/mhmdatallaa/CurrenSee/assets/100219531/88bd3b5e-021c-41e8-8c31-0bcba7db9e4e" width="80">


The currency conversion app aims to provide users with real-time and accurate currency conversion rates using Google's open APIs. It will support a wide range of currencies and offer a user-friendly interface. 




## Fuctionalities
1. **Currency Conversion:** The core functionality of the app is to allow users to convert between different currencies. Users can enter the amount they want to convert, select the source currency, and choose the target currency. The app will display the converted amount based on the current exchange rate.

2. **Real-Time Exchange Rates:** The app will fetch real-time exchange rates from Google's open APIs to ensure accuracy. It should regularly update the rates to reflect the most recent changes in the currency market.

3. **Favorite Currencies:** Users can mark specific currencies as their favorites for quick access. The app will provide an option to save and manage a list of frequently used currencies.

4. **Currency Comparison:** The app will provide a side-by-side comparison of multiple currencies for easy analysis. Users can select multiple currencies and view their exchange rates simultaneously.
**Team Division:**




## Low-Level Design 
![image](https://github.com/mhmdatallaa/CurrenSee/assets/100219531/16bed704-4b9f-4aa2-a45a-8d59ee0f440c)

## Design Decisions
- **UI:**
    - UIKit
    - MVP Architecture

- **Dependencies Manager:**
    - Swift Package Manager (SPM)

- **Dependencies:**
    - [iOSDropDown](https://github.com/jriosdev/iOSDropDown): Supporting Drop Down menu in iOS
 

## Figma Design
[Concurrncy Figma Design](https://www.figma.com/file/IRr6V7fjVKaOHFtGLsWLuc/Con-Currency?type=design&node-id=2-818&mode=design&t=4iDXB64Yp9qfUCJP-0)

 
## App Preview
<img src="https://github.com/mhmdatallaa/ConCurrency/assets/100219531/be51d91b-0e41-47e6-b450-61599fa92978" width="400">     <img src="https://github.com/mhmdatallaa/ConCurrency/assets/100219531/a7a9a790-b0b6-40ba-a34a-45a6647bc7d3" width="400">     


## User experience (UX)
- **Showing an alert to the user when there's an error in network**
- ![image](https://github.com/mhmdatallaa/CurrenSee/assets/100219531/7ec40d3d-189f-4f04-9230-abb5969eca0f)

- **Showing toast message when user add or remove from the favorites**
- ![image](https://github.com/mhmdatallaa/CurrenSee/assets/100219531/477764fd-1bab-477b-810e-27226d83183b) ![image](https://github.com/mhmdatallaa/CurrenSee/assets/100219531/66d57c5b-cfad-448b-a4c0-a9e0e9300abe)

- **User can use only decimal pad keyboard & dismiss it when tab on any part of the scereen**

- **User can't enter more than one decimal seperator (.) into the Amount textField**

- Showing loading indicator while the user convert or compare currenies.
- ![image](https://github.com/mhmdatallaa/CurrenSee/assets/100219531/b8ba1072-2d47-4b41-b899-07b78a674d0e)





## App implementation : 
- Try to Follow **SOLID** & best pracitices Principles
- Use only one package dependency [iOSDropDown](https://github.com/jriosdev/iOSDropDown)
- Worked with :
   - UITableView
   - ARC, Memory Leaks, and Capture Lists [weak self] 
   - Network Call and Downloading Images 
   - Persistance useing `UserDefaults()`
   - Debugging techniques like: *Symbolic break points*

## Further Enhancements
According to **MVA** *Minimum Viable Architecture* : The main purpose was to implement the main features that make the app work (go to the realse phase).

- Add Splach Screen 
- Add more features ( Showing exhange rate charts, Support more currencies, ...)

## Squad Members
**Backend**
- Mahmoud Matar
- Farah AbuElazm

**iOS**
- [Mohamed Atallah](https://github.com/mhmdatallaa)
- [Manar Kamel](https://github.com/mnarkamel)

**Android**
- [Mahmoud](https://github.com/Mahmoudadel17)
- [Abdelrahman](https://github.com/abdelrahmanmohamed19)

**Web**
- [Saif Ashraf](https://github.com/SaifAshraf22)
- [Mohamed Fawzy](https://github.com/Mahmoud-Fawzi-Fayed)
