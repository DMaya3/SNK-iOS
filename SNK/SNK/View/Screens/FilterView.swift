//
//  FilterView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var statusFiltered: Status = .none
    @State private var seasonFiltered: Seasons = .none
    @State private var keyboardOffset: CGFloat = 0
    var isCharacter: Bool = false
    var receivedData: (String, Status, Seasons) -> Void
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Text(self.localization.filter_title_header)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.trailing, 100)
                        Button {
                            self.dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .foregroundStyle(.gray)
                        .padding()
                    }
                    .padding()
                    
                    SearchTextFieldView(text: $name, label: self.localization.filter_name_hint)
                    
                    if self.isCharacter {
                        Picker(self.localization.filter_status_header, selection: $statusFiltered) {
                            ForEach(Status.allCases) { status in
                                Text(self.localization.filter_status_value(status: status.rawValue)).tag(status)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .colorMultiply(Color(.filter).opacity(0.8))
                    } else {
                        Picker(self.localization.filter_season_header, selection: $seasonFiltered) {
                            ForEach(Seasons.allCases) { season in
                                Text(self.localization.filter_season_title(season: season.rawValue)).tag(season)
                            }
                        }
                        .pickerStyle(.wheel)
                        .cornerRadius(12)
                        .shadow(radius: 8)
                        .frame(height: 120)
                        .colorMultiply(Color(.filter).opacity(0.8))
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(.backFilter)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                            .opacity(0.3)
                        Image(.attackOnTitanTitle)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 30, height: 140)
                            .padding(.top, -30)
                            .opacity(0.3)
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        Button {
                            if !self.name.isEmpty || self.statusFiltered != .none || self.seasonFiltered != .none {
                                self.receivedData(self.name, self.statusFiltered, self.seasonFiltered)
                            }
                            self.dismiss.callAsFunction()
                        } label: {
                            ButtonView(titleLabel: self.localization.filter_btn_apply,
                                       foregroundColor: .white,
                                       backgroundColor: Color(.filter))
                        }
                        .padding()
                        
                        Button {
                            if self.name.isEmpty && self.statusFiltered == .none && self.seasonFiltered == .none {
                                self.dismiss.callAsFunction()
                            } else {
                                withAnimation {
                                    self.name = ""
                                    self.statusFiltered = .none
                                    self.seasonFiltered = .none
                                }
                            }
                        } label: {
                            if self.name.isEmpty && self.statusFiltered == .none && self.seasonFiltered == .none {
                                ButtonView(titleLabel: self.localization.filter_btn_cancel,
                                           foregroundColor: .white,
                                           backgroundColor: .gray)
                            } else {
                                ButtonView(titleLabel: self.localization.filter_btn_clear,
                                           foregroundColor: .white,
                                           backgroundColor: Color(.filter))
                            }
                        }
                    }
                }
                .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .onAppear {
                    self.addKeyboardObservers()
                }
                .onDisappear {
                    self.removeKeyboardObservers()
                }
                .onChange(of: geometry.safeAreaInsets.bottom) { _, bottomInset in
                    withAnimation {
                        self.keyboardOffset = bottomInset
                    }
                }
            }
        }
    }
}

extension FilterView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                withAnimation {
                    self.keyboardOffset = keyboardFrame.height
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            withAnimation {
                self.keyboardOffset = 0
            }
        }
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
