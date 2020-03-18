
//
//  ContentView.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/14.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var isPresenting: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isPresenting = true
                }, label: {
                    HStack {
                        Image(systemName: "plus").aspectRatio(contentMode: .fill)
                        Text("ToDoを追加").font(Font.callout)
                    }
                })
                List(viewModel.todos, id: \ToDo.id) { (todo: ToDo) in
                    Text(todo.content)
                }
            }.navigationBarTitle("ToDoList")
        }.sheet(isPresented: $isPresenting, content: {
            AddToDoView(viewModel: AddToDoViewModel())
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
