# 阿嬤血糖幫手 

阿嬤血糖幫手是一款 iOS 血糖管理應用，幫助使用者方便記錄每日血糖數據，並提供可視化圖表分析。

## 預覽圖 📱
![示例圖片]([[https://user-images.githubusercontent.com/12345678/abcdefg1234567.png](https://private-user-images.githubusercontent.com/137172221/409476968-56215947-e5f5-4cdd-857b-582ed0d8acdb.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg2NjA0MjUsIm5iZiI6MTczODY2MDEyNSwicGF0aCI6Ii8xMzcxNzIyMjEvNDA5NDc2OTY4LTU2MjE1OTQ3LWU1ZjUtNGNkZC04NTdiLTU4MmVkMGQ4YWNkYi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA0JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwNFQwOTA4NDVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zNWFmODg5ODg0ZGZkNTIyZmJiMmI5MTgwNzc5Yzg4NDdkZGMyOWJiN2VkNTEzMjA2ZDJlNTJmM2Y1MTYxM2I2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.u3nWJUGU-cW-WWX2728SPlVJAB3jEi5QrVXTgscDiHY)])

## 功能特色 
- **血糖記錄**：App會讀取蘋果健康內的血糖數值，並可輸入食物選擇時間（如早餐前、午餐後等）上傳至Firebase。
- **AI分析血糖數值**：透過 Gemini AI分析血糖數據，提供個人化的健康建議。
- **血糖趨勢圖**：以折線圖呈現最近 10 次血糖變化，方便追蹤血糖狀況。
- **血糖新聞**：提供最新血糖新聞報導供參考。
- **數值燈號指示**：根據血糖數值提供顏色標示，提醒使用者注意血糖異常情況。
  
- 超過 160 mg/dL：橘色（偏高）
- 130 ~ 160 mg/dL：棕色（需注意）
- 80 ~ 130 mg/dL：綠色（正常範圍）
- 低於 80 mg/dL：紅色（過低）

## 技術架構 🛠️
- **技術**：使用 Swift純code 建立 UIKit，利用 Firebase 儲存使用者飲食，開發 iOS App。
- **架構**：使用 Combine 建立 MVVM 架構
- **資料來源**：整合蘋果健康app 血糖數據，New API新聞數據，Gemini AI API。
