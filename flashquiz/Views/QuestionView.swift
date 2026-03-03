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
        VStack(spacing: 20) {
            if let room = session.room, let question = room.currentQuestion {
                Text("Süre: \(viewModel.remainingSeconds)")
                    .font(.title.bold())
                    .foregroundStyle(viewModel.remainingSeconds <= 5 ? .red : .primary)

                Text("Soru \(room.currentQuestionIndex + 1) / \(room.questions.count)")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(question.text)
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

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
                                    .fill(viewModel.selectedOptionIndex == index ? Color.blue.opacity(0.2) : Color.gray.opacity(0.15))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(viewModel.selectedOptionIndex == index ? Color.blue : Color.clear, lineWidth: 2)
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
                        .foregroundStyle(.secondary)

                    ForEach(session.players) { player in
                        HStack {
                            Text(player.name)
                                .font(.footnote)
                            Spacer()
                            let hasAnswered = room.currentAnswers[player.id] != nil
                            Text(hasAnswered ? "CEVAPLADI" : "CEVAPLAMADI")
                                .font(.caption.bold())
                                .foregroundStyle(hasAnswered ? .green : .red)
                        }
                    }
                }

                if viewModel.hasSubmitted {
                    Text("Cevabın kaydedildi. Diğer oyuncular bekleniyor.")
                        .font(.footnote)
                        .foregroundStyle(.green)
                }
            } else {
                ProgressView("Soru yükleniyor...")
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
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
