//
//  FinishedView.swift
//  flashquiz
//

import SwiftUI

struct FinishedView: View {
    @ObservedObject var session: AppSession
    @StateObject private var viewModel: FinalResultsViewModel

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        _viewModel = StateObject(wrappedValue: FinalResultsViewModel(session: session, network: network))
    }

    var body: some View {
        VStack(spacing: 14) {
            Text("Oyun Sonu")
                .font(.largeTitle.bold())
                .foregroundStyle(.appTextPrimary)

            Text("Toplam Soru: \(viewModel.totalQuestionCount)")
                .font(.subheadline)
                .foregroundStyle(.appTextSecondary)

            List {
                ForEach(Array(viewModel.statsRows.enumerated()), id: \.element.id) { index, row in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(index + 1)) \(row.playerName)")
                            .font(.body.bold())
                        Text("Skor: \(row.score)")
                            .font(.subheadline.bold())
                            .foregroundStyle(.appAccent)
                        HStack(spacing: 12) {
                            Text("Doğru: \(row.correctCount)")
                                .foregroundStyle(.appSuccess)
                            Text("Yanlış: \(row.wrongCount)")
                                .foregroundStyle(.appDanger)
                            Text("Süre Bitti: \(row.timeoutCount)")
                                .foregroundStyle(.appWarning)
                        }
                        .font(.footnote)
                    }
                    .padding(.vertical, 2)
                    .listRowBackground(Color.appSurface)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .frame(height: 230)

            ChatPanelView(session: session, title: "Sohbet", height: 150)

            if viewModel.isHost {
                Button("Tekrar Oyna") {
                    viewModel.playAgain()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isRestarting)
            } else {
                Text("Oda sahibi tekrar oyna dediğinde lobiye dönüp tekrar hazır olabilirsiniz.")
                    .font(.footnote)
                    .foregroundStyle(.appTextSecondary)
                    .multilineTextAlignment(.center)
            }

            Button("Çıkış") {
                viewModel.exitRoom()
            }
            .buttonStyle(.bordered)

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
