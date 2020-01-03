//
//  ColorSquareBlock.swift
//  Tasks
//
//  Created by Paul Thorsen on 1/1/20.
//  Copyright © 2020 Paul Thorsen. All rights reserved.
//

import SwiftUI

struct ColorSquareBlock: View {
    @Binding var taskColor: String
    
    var body: some View {
        HStack {
            ForEach(Colors.allCases, id: \.self) { color in
                HStack {
                    ColorButton(taskColor: self.$taskColor, color: color.rawValue).padding()
                }
            }
        }
    }
}

struct ColorButton: View {
    @Binding var taskColor: String
    var color: String
    
    var body: some View {
        Button(action: {self.taskColor = self.color}) {
            if self.taskColor == self.color {
                Rectangle()
                    .frame(width: COLOR_SELECTION_WIDTH, height: COLOR_SELECTION_WIDTH)
                    .cornerRadius(COLOR_SELECTION_CORNER_RADIUS)
                    .foregroundColor(Color(String(self.color)))
                    .overlay(Rectangle().stroke(Color(TASK_ICON_COLOR), lineWidth: COLOR_SELECTION_LINE_WIDTH)
                        .cornerRadius(COLOR_SELECTION_CORNER_RADIUS)
                        .clipShape(Rectangle())
                        .opacity(TASK_ICON_OPACITY))
            } else {
                Rectangle()
                    .cornerRadius(COLOR_SELECTION_CORNER_RADIUS)
                    .frame(width: COLOR_SELECTION_WIDTH, height: COLOR_SELECTION_WIDTH)
            }
        }
        .foregroundColor(Color(String(self.color)))
    }
}

struct ColorSquareBlock_Previews: PreviewProvider {
    static var previews: some View {
        ColorSquareBlock(taskColor: .constant("orange_color"))
    }
}
