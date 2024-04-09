//
//  HabitView.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.screenState {
                ProgressView()
            }  else {
                NavigationView {
                    ScrollView {
                        VStack(spacing: 12) {
                            Notification
                            addHabitButton
                            
                            if case HabitUIState.emptyList = viewModel.screenState {
                                Spacer(minLength: 60)
                                
                                VStack {
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhum hábito encontrado :(")
                                }
                            } else if case HabitUIState.fullList(let rows) = viewModel.screenState {
                                LazyVStack {
                                    ForEach(rows, content: HabitCardView.init(viewModel:))
                                }.padding(.horizontal, 14)
                            } else if case HabitUIState.error(let msg) = viewModel.screenState {
                                Text("").alert(isPresented: .constant(true)) {
                                    Alert(
                                        title: Text("Ops! \(msg)"),
                                        message: Text("Tentar novamente?"),
                                        primaryButton: .default(Text("Sim")) {
                                            // func chamada caso for sim
                                            viewModel.onAppear()
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                            }
                        }
                    }.navigationTitle("Meus Hábitos")
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }
        
    }
}

extension HabitView {
    var addHabitButton: some View {
        NavigationLink(destination: Text("Tela de adicionar")) {
            Label("Criar Hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(.horizontal, 16)
    }
}

extension HabitView {
    var Notification: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(Color.orange)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("TextColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.subheadline))
                .foregroundColor(Color("TextColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32) // modifica o VStack
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)// modifica o overlay
        .padding(.top, 16)
        
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            homeRouter.makeHabitView()
                .previewDevice("iPhone 11")
                .preferredColorScheme($0)
        }
    }
}
