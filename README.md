# Stock Quote App - Documentation

## 1. Introduction
A simple Flutter app to fetch and display real-time stock market data using the Twelve Data API. Users can search for stocks, view detailed charts and info, and maintain a wishlist of favorite stocks.

## 2. Features
- Real-time stock list
- Search functionality by symbol
- Detailed chart and info page with price and performance data
- Wishlist with local persistence (heart icon toggle)

## 3. Technologies Used
- Flutter
- Provider (state management)
- Twelve Data API
- HTTP package for API calls
- Syncfusion Flutter Charts for stock chart visualization
- Shared Preferences for wishlist persistence

## 4. App Architecture
Follows the MVVM (Model-View-ViewModel) pattern:
- **Models**
  - `StockQuote`: represents stock symbol, name, and price data
  - `StockData`: represents chart data (price vs. time)
- **Providers**
  - `StockProvider`: handles API interaction and state for stock data
- **Views**
  - `HomeScreen`: displays list of stocks
  - `DetailsScreen`: shows stock info and chart
  - `WishlistScreen`: displays wishlisted stocks
- **Services**
  - `StockService`: manages HTTP calls to Twelve Data API
- **Utils**
  - `wishlist_manager.dart`: manages add/remove wishlist functionality with Shared Preferences

## 5. API Integration
- API: [Twelve Data](https://twelvedata.com/)
- Endpoints:
  - `/quote` for current price and details
  - `/time_series` for historical chart data
- API Key is securely stored and passed with each request

## 6. Testing
- ✅ Unit Tests: For data fetching logic and wishlist toggle
- ✅ Widget Tests: For verifying UI rendering of stock lists and details page

## 7. Limitations
- Free API tier has rate limits
- Error handling is basic (e.g., connection issues)

## 8. Future Improvements
- Add stock news feed
- Integrate Firebase for cloud-based wishlist syncing
- Add user authentication (login/signup with Firebase)

