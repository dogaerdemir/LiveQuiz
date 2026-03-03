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
                    Text("Gerçek zamanlı bilgi yarışması")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
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
                                .foregroundStyle(.secondary)

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
                                .foregroundStyle(.secondary)

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
                    .padding()
                    .background(Color.gray.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
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
                    .padding()
                    .background(Color.gray.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }

                if viewModel.isLoading {
                    ProgressView("Bağlanıyor...")
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    let session = AppSession(network: .shared)
    let viewModel = HomeViewModel(session: session, network: .shared)
    HomeView(viewModel: viewModel)
}
