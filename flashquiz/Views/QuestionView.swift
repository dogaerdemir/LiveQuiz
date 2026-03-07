//
//  QuestionView.swift
//  flashquiz
//

import SwiftUI

struct QuestionView: View {
    @ObservedObject var session: AppSession
    @StateObject private var viewModel: QuestionViewModel

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        _viewModel = StateObject(wrappedValue: QuestionViewModel(session: session, network: network))
    }

    var body: some View {
        VStack(spacing: 10) {
            if let room = session.room, let question = room.currentQuestion {
                ScrollView {
                    VStack(spacing: 14) {
                        Text("Süre: \(viewModel.remainingSeconds)")
                            .font(.title.bold())
                            .foregroundStyle(viewModel.remainingSeconds <= 5 ? .appDanger : .appTextPrimary)

                        Text("Soru \(room.currentQuestionIndex + 1) / \(room.questions.count)")
                            .font(.headline)
                            .foregroundStyle(.appTextSecondary)

                        Text(question.text)
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.appTextPrimary)

                        VStack(spacing: 10) {
                            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                                Button {
                                    viewModel.selectOption(index)
                                } label: {
                                    HStack {
                                        Text(OptionLabel.prefixed(index))
                                            .bold()
                                        Text(option)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 14)
                                    .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(viewModel.selectedOptionIndex == index ? Color.appAccent.opacity(0.24) : Color.appSurfaceAlt)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(viewModel.selectedOptionIndex == index ? Color.appAccent : Color.appBorder, lineWidth: viewModel.selectedOptionIndex == index ? 2 : 1)
                                    )
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity)
                                .disabled(viewModel.hasSubmitted)
                            }
                        }

                        Button {
                            viewModel.submitAnswer()
                        } label: {
                            Text(viewModel.hasSubmitted ? "Cevap Gönderildi" : "Cevabı Gönder")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.hasSubmitted || viewModel.isSubmitting)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Oyuncu Durumu")
                                .font(.footnote.bold())
                                .foregroundStyle(.appTextSecondary)

                            ForEach(session.players) { player in
                                HStack {
                                    Text(player.name)
                                        .font(.footnote)
                                        .foregroundStyle(.appTextPrimary)
                                    Spacer()
                                    let hasAnswered = room.currentAnswers[player.id] != nil
                                    Text(hasAnswered ? "CEVAPLADI" : "CEVAPLAMADI")
                                        .font(.caption.bold())
                                        .foregroundStyle(hasAnswered ? .appSuccess : .appDanger)
                                }
                            }
                        }

                        if viewModel.hasSubmitted {
                            Text("Cevabın kaydedildi. Diğer oyuncular bekleniyor.")
                                .font(.footnote)
                                .foregroundStyle(.appSuccess)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                }

                ChatPanelView(session: session, title: "Sohbet", height: 150)
            } else {
                Spacer()
                ProgressView("Soru yükleniyor...")
                Spacer()
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.appDanger)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.appBackground.ignoresSafeArea())
        .dismissKeyboardOnTap()
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .onReceive(session.$room) { _ in
            viewModel.onRoomOrPlayersChanged()
        }
        .onReceive(session.$players) { _ in
            viewModel.onRoomOrPlayersChanged()
        }
    }
}
