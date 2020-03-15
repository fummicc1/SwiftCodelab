
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
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AddToDoView()) {
                    HStack {
                        Image(systemName: "plus").aspectRatio(contentMode: .fill).aspectRatio(contentMode: .fill)
                        Text("ToDoを追加").font(Font.callout)
                    }
                }
                List(viewModel.todos, id: \ToDo.id) { (todo: ToDo) in
                    Text(todo.content)
                }
            }.navigationBarTitle("ToDoList")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
