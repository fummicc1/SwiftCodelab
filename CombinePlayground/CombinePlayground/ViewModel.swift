//
//  ViewModel.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    @Published private var todos: [String] = []
}
