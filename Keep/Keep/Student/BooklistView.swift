//
//  BooklistView.swift
//  Keep
//
//  Created by bibiga on 4/8/24.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import UserNotifications

struct Book: Codable, Identifiable {
    let id: Int
    let bookName: String
    let writer: String
    let registrationDate: String
    let state: String
    let imageUrl: String?
    let rentDate: String
    let borrower: Borrower
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookName
        case writer
        case registrationDate
        case state
        case imageUrl
        case rentDate
        case borrower
    }
    
    struct Borrower: Codable {
        let id: Int
        let email: String
        let name: String
        let teacher: Bool
    }
}

// 서버 응답 데이터 모델
struct ResponseData: Codable {
    let httpStatus: String
    let message: String
    let data: [Book]
    
    enum CodingKeys: String, CodingKey {
        case httpStatus
        case message
        case data
    }
}

// 책 데이터를 관리하고 네트워크 요청을 처리하는 ViewModel
class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchBooks() {
        isLoading = true
        
        guard let token = TokenManager.shared.token else {
            print("토큰을 찾을 수 없습니다")
            isLoading = false
            return
        }
        
        let apiUrl = Storage().mybooklendlistapiKehy
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(apiUrl, headers: headers).responseData { response in
            self.isLoading = false
            
            switch response.result {
            case .success(let data):
                // 받은 데이터 출력 (디버깅용)
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(ResponseData.self, from: data)
                    DispatchQueue.main.async {
                        self.books = decodedResponse.data
                        self.scheduleReturnNotifications() // 알림 예약
                        print("받은 책 목록: \(self.books)")
                    }
                } catch {
                    self.error = error
                    print("JSON 디코딩 실패: \(error.localizedDescription)")
                }
            case .failure(let error):
                self.error = error
                print("네트워크 요청 실패: \(error.localizedDescription)")
            }
        }
    }
    
    // 반납 예정일에 알림 예약
    func scheduleReturnNotifications() {
        for book in books {
            scheduleNotification(for: book)
        }
    }
    
    // 반납 알림을 특정 날짜에 예약 (반납일 전날 오후 5시 55분에 알림)
    private func scheduleNotification(for book: Book) {
        guard let returnDateComponents = calculateReturnDate(book.rentDate) else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "반납 알림"
        content.body = "\(book.bookName)의 반납일이 다가오고 있습니다. 내일까지 책을 반납하세요."
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: returnDateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 예약 실패: \(error.localizedDescription)")
            } else {
                print("알림 예약 성공")
            }
        }
    }
    
    func calculateReturnDate(_ rentDate: String) -> DateComponents? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        guard let rentDateObj = dateFormatter.date(from: rentDate) else { return nil }
        guard let returnDate = Calendar.current.date(byAdding: .day, value: 7, to: rentDateObj) else { return nil }
        
        var notificationDate = Calendar.current.date(byAdding: .day, value: -1, to: returnDate)!
        notificationDate = Calendar.current.date(bySettingHour: 18, minute: 18, second: 0, of: notificationDate)!
        
        print("Notification Date: \(notificationDate)")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)
        
        return components
    }
}



// 책 목록을 보여주는 SwiftUI 뷰
struct BooklistView: View {
    @StateObject private var viewModel = BookViewModel()
    
    var body: some View {
        VStack {
            Text("나의 대출 목록")
                .font(.system(size: 28, weight: .bold))
                .padding(.trailing, 155)
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.gray)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.books) { book in
                        BookRowView(book: book)
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(maxHeight: 600)
        }
        .onAppear {
            viewModel.fetchBooks()
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                }
            }
        )
    }
}

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 30) {
            WebImage(url: URL(string: book.imageUrl ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .background(Color.gray.opacity(0.1))
                .offset(x:-30)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(book.bookName)
                        .font(.system(size: 20, weight: .semibold))
                    Text(book.writer)
                        .font(.system(size: 12))
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("대출일")
                        .font(.system(size: 12))
                    Text(formatDate(book.rentDate))
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("반납 예정일")
                        .font(.system(size: 12))
                    Text(calculateReturnDateString(book.rentDate))
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        Rectangle()
            .frame(width: 500, height: 0.3)
            .foregroundColor(.gray)
    }
    
    private func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let dateObj = dateFormatter.date(from: date) {
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "yyyy-MM-dd"
            return newFormatter.string(from: dateObj)
        }
        
        // 날짜 변환 실패 시 원래 문자열 반환
        return date.components(separatedBy: "T").first ?? date
    }
    
    private func calculateReturnDateString(_ rentDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let dateObj = dateFormatter.date(from: rentDate) {
            let returnDate = Calendar.current.date(byAdding: .day, value: 7, to: dateObj)!
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "yyyy-MM-dd"
            return newFormatter.string(from: returnDate)
        }
        
        // 날짜 변환 실패 시 원래 문자열 반환
        return rentDate.components(separatedBy: "T").first ?? rentDate
    }
}



#Preview {
    BooklistView()
}

