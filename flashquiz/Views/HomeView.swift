//
//  HomeView.swift
//  flashquiz
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text("FlashQuiz")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.appTextPrimary)
                    Text("Gerçek zamanlı bilgi yarışması")
                        .font(.subheadline)
                        .foregroundStyle(.appTextSecondary)
                        .multilineTextAlignment(.center)
                }

                TextField("Kullanıcı adın", text: $viewModel.playerName)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()

                Picker("Mod", selection: $viewModel.mode) {
                    ForEach(HomeMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)

                if viewModel.mode == .create {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Soru sayısı")
                                .font(.footnote)
                                .foregroundStyle(.appTextSecondary)

                            Picker("Soru sayısı", selection: $viewModel.selectedQuestionCount) {
                                ForEach(viewModel.questionCountOptions, id: \.self) { count in
                                    Text("\(count)").tag(count)
                                }
                            }
                            .pickerStyle(.segmented)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Kategori")
                                .font(.footnote)
                                .foregroundStyle(.appTextSecondary)

                            Picker("Kategori", selection: $viewModel.selectedCategory) {
                                ForEach(viewModel.categoryOptions) { category in
                                    Text(category.title).tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                        }

                        Button {
                            viewModel.createRoom()
                        } label: {
                            Text("Oda Oluştur")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isLoading)
                    }
                    .appCardStyle()
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        TextField("Oda kodu", text: $viewModel.roomCodeInput)
                            .textInputAutocapitalization(.characters)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: viewModel.roomCodeInput) { _, newValue in
                                viewModel.roomCodeInput = newValue.uppercased()
                            }

                        Button {
                            viewModel.joinRoom()
                        } label: {
                            Text("Koda Göre Katıl")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isLoading)
                    }
                    .appCardStyle()
                }

                if viewModel.isLoading {
                    ProgressView("Bağlanıyor...")
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.appDanger)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding()
            .background(Color.appBackground.ignoresSafeArea())
        }
    }
}

#Preview {
    let session = AppSession(network: .shared)
    let viewModel = HomeViewModel(session: session, network: .shared)
    HomeView(viewModel: viewModel)
}
