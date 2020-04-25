//
//  ColorSquareBlock.swift
//  Tasks
//
//  Created by Paul Thorsen on 1/1/20.
//  Copyright © 2020 Paul Thorsen. All rights reserved.
//

import SwiftUI

struct AddColorSquareBlock: View {
    @Binding var selection: String
    
    var body: some View {
        HStack(spacing: LIST_SPACING) {
            ForEach(Colors.allCases, id: \.self) { color in
                AddColorButton(selection: self.$selection, color: color.rawValue)
            }
        }
    }
}

struct AddColorButton: View {
    @Binding var selection: String
    var color: String
    
    var body: some View {
        Button(action: {self.selection = self.color}) {
            ZStack {
                Rectangle()
                    .frame(width: ADD_COLOR_BUTTON_WIDTH, height: COLOR_SELECTION_WIDTH)
                    .opacity(0.25)
                Image(ADD_ICON)
                    .renderingMode(.template)
                    .foregroundColor(Color(self.color))
//                    .blendMode(.multiply)
            }
        }
        .foregroundColor(Color(String(self.color)))
    }
}

struct AddColorSquareBlock_Previews: PreviewProvider {
    static var previews: some View {
        AddColorSquareBlock(selection: .constant(""))
    }
}
