//
//  AddToDoView.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import SwiftUI

struct AddToDoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: AddToDoViewModel
    
    var body: some View {
        NavigationView {
            judgetOutputState().navigationBarTitle("Add ToDo", displayMode: .inline)
        }
    }
    
    var readyState: some View {
        VStack {
            Form {
                Section(header: Text("Required")) {
                    TextField("Title", text: $viewModel.title)
                }
                Section(header: Text("Optional")) {
                    TextField("Content", text: $viewModel.content)
                }
                
                Section(header: Text("Deadline")) {
                    DatePicker(selection: $viewModel.deadline, displayedComponents: .date) {
                        Text("Complete ToDo by...")
                    }
                }
            }
            Button(action: {
                self.viewModel.createToDo()
            }) {
                Text("登録").font(.system(size: 24)).bold()
            }
        }
    }
    
    var processingState: some View {
        VStack {
            Spacer()
            Text("Processing").font(.system(size: 24)).bold()
            Spacer()
        }
    }
    
    var successState: some View {
        presentationMode.wrappedValue.dismiss()
        return VStack {
            Spacer()
            Text("DONE").bold()
            Spacer()
        }
    }
    
    func failState(error: Error) -> some View {        
        return VStack {
            Spacer()
            Text(error.localizedDescription).bold()
            Spacer()
        }
    }
    
    func judgetOutputState() -> AnyView {
        switch viewModel.outputResult {
        case .ready:
            return AnyView(readyState)
            
        case .processing:
            return AnyView(processingState)
                        
        case .success:
            return AnyView(successState)
            
        case .fail(let error):
            return AnyView(failState(error: error))
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(viewModel: AddToDoViewModel())
    }
}
