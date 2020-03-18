//
//  AddToDoView.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import SwiftUI

struct AddToDoView: View {
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var deadline: Date = Date()
    @ObservedObject var viewModel: AddToDoViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Required")) {
                        TextField("Title", text: $title)
                    }
                    Section(header: Text("Optional")) {
                        TextField("Content", text: $content)
                    }
                    
                    Section(header: Text("Deadline")) {
                        DatePicker(selection: $deadline, displayedComponents: .date) {
                            Text("Complete ToDo by...")
                        }
                    }
                }
                Button(action: {
                    print(self.deadline)
                }) {
                    Text("登録").font(.system(size: 24)).bold()
                }
            }.navigationBarTitle("Add ToDo", displayMode: .inline)
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(viewModel: AddToDoViewModel())
    }
}
