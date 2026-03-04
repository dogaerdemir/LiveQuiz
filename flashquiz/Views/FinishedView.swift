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

            Text("Toplam Soru: \(viewModel.totalQuestionCount)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            List {
                ForEach(Array(viewModel.statsRows.enumerated()), id: \.element.id) { index, row in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(index + 1)) \(row.playerName)")
                            .font(.body.bold())
                        Text("Skor: \(row.score)")
                            .font(.subheadline.bold())
                            .foregroundStyle(.blue)
                        HStack(spacing: 12) {
                            Text("Doğru: \(row.correctCount)")
                                .foregroundStyle(.green)
                            Text("Yanlış: \(row.wrongCount)")
                                .foregroundStyle(.red)
                            Text("Süre Bitti: \(row.timeoutCount)")
                                .foregroundStyle(.orange)
                        }
                        .font(.footnote)
                    }
                    .padding(.vertical, 2)
                }
            }
            .listStyle(.plain)

            if viewModel.isHost {
                Button("Tekrar Oyna") {
                    viewModel.playAgain()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isRestarting)
            } else {
                Text("Oda sahibi tekrar oyna dediğinde lobiye dönüp tekrar hazır olabilirsiniz.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button("Çıkış") {
                viewModel.exitRoom()
            }
            .buttonStyle(.bordered)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
