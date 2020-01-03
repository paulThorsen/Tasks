//
//  Constants.swift
//  Hours
//
//  Created by Paul Thorsen on 12/28/19.
//  Copyright © 2019 Paul Thorsen. All rights reserved.
//

import Foundation
import SwiftUI

let screenSize = UIScreen.main.bounds

// CGFloat
let DIVIDER_WIDTH: CGFloat = 1
let CELL_HEIGHT: CGFloat = 68
let ICON_SPACER_TITLE: CGFloat = 15
let TASK_SPACING: CGFloat = 0
let LIST_SPACING: CGFloat = 0
let COLOR_SELECTION_WIDTH: CGFloat = 52
let COLOR_SELECTION_CORNER_RADIUS: CGFloat = 4
let COLOR_SELECTION_LINE_WIDTH: CGFloat = 12
let TASK_DELETE_TRIGGER: CGFloat = -(screenSize.width / 2.5)
let TASK_MARK_TRIGGER: CGFloat = screenSize.width / 2.5
let DELETE_ICON_OFFSET: CGFloat = 40
let MARK_ICON_OFFSET: CGFloat = 65
let ADD_COLOR_BUTTON_WIDTH: CGFloat = screenSize.width / 4
let SECTION_WIDTH: CGFloat = 3
let EXP_ALG_BASE: CGFloat = 0.9
let EXP_ALG_EXP_OFFSET: CGFloat = 0.095
let EXTRA_DELETE_OFFSET: CGFloat = 15

// Double
let TASK_ICON_OPACITY: Double = 0.5
let TASK_DIVIDER_OPACITY: Double = 0.25

// String - Colors
let ACTION_ICON_COLOR = "white"
let ICON_BLACK_COLOR = "black"
let DELETE_COLOR = "delete_color"
let DIVIDER_COLOR = "divider_color"
let COMPLETED_TASK_BG_COLOR = "completed_task_bg"
let TASK_ICON_COLOR = "task_icon_color"
let BLACK_DIVIDER_COLOR = "black"
let TASK_TITLE_NOT_COMPLETED_COLOR  = "task_title_color_not_completed"
let TASK_TITLE_COMPLETED_COLOR  = "task_title_color_completed"
let MARK_COLOR = "mark_color"

// String - Icons
let SHOW_MORE_ICON = "more"
let DELETE_ICON = "delete"
let DELETE_WIDE_ICON = "delete_wide"
let COMPLETED_STATUS_ICON = "completed"
let NOT_COMPLETED_STATUS_ICON = "not_completed"
let MARK_ICON = "mark"
let ADD_ICON = "add"

enum Colors: String, CaseIterable {
    case red = "red_color"
    case green = "green_color"
    case orange = "orange_color"
    case gray = "purple_color"
}
