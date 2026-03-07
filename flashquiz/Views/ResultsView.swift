//
//  ResultsView.swift
//  flashquiz
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var session: AppSession
    @StateObject private var viewModel: ResultsViewModel

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        _viewModel = StateObject(wrappedValue: ResultsViewModel(session: session, network: network))
    }

    var body: some View {
        VStack(spacing: 16) {
            if let question = session.room?.currentQuestion {
                Text("Sonuçlar")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.appTextPrimary)

                Text(question.text)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.appTextPrimary)

                Text("Doğru Cevap: \(OptionLabel.prefixed(question.correctOptionIndex)) \(question.options[question.correctOptionIndex])")
                    .font(.subheadline.bold())
                    .foregroundStyle(.appSuccess)
                    .multilineTextAlignment(.center)
            }

            List(viewModel.rankedPlayers) { ranked in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(ranked.rank)) \(ranked.player.name)")
                            .font(.body.bold())
                        Text(viewModel.labelForSelection(of: ranked.player))
                            .font(.footnote)
                            .foregroundStyle(.appTextSecondary)
                        Text("Skor: \(ranked.score)")
                            .font(.caption)
                            .foregroundStyle(.appTextSecondary)
                    }
                    Spacer()
                    if viewModel.isCorrectSelection(of: ranked.player) {
                        Text("Doğru")
                            .font(.caption.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.appSuccess.opacity(0.2))
                            .clipShape(Capsule())
                    } else if viewModel.isWrongSelection(of: ranked.player) {
                        Text("Yanlış")
                            .font(.caption.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.appDanger.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
                .listRowBackground(Color.appSurface)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .frame(height: 220)

            ChatPanelView(session: session, title: "Sohbet", height: 150)

            if viewModel.isHost {
                Button {
                    viewModel.moveToNextQuestion()
                } label: {
                    Text(viewModel.isLastQuestion ? "Oyunu Bitir" : "Sonraki Soru")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isAdvancing)
            } else {
                Text("Oda sahibi sonraki soruya geçtiğinde oyun devam edecek.")
                    .font(.footnote)
                    .foregroundStyle(.appTextSecondary)
                    .multilineTextAlignment(.center)
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.appDanger)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(Color.appBackground.ignoresSafeArea())
        .dismissKeyboardOnTap()
    }
}
