//
//  Constants.swift
//  Reader
//
//  Created by Terminal-1 on 15/05/19.
//  Copyright © 2019 AscendPsychology. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let readModeSwitchScaleX: CGFloat = 0.75
    static let readModeSwitchScaleY: CGFloat = 0.75
    
    struct userDefaultsKey {
        static let darkMode = "DarkMode"
    }
    
    struct mode {
        struct dark{
            static let color1 = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            static let color2 = UIColor.darkText
            static let color3 = UIColor.black
        }
        struct light{
            static let color1 = UIColor.white
        }
    }
    
    struct animations{
        struct duration {
            static let statusBarHide = 0.5
            static let toolBarHide = 0.5
        }
    }
    
    struct storyBoard{
        static let main = "Main"
    }
    
    static let bottomBarHeight: CGFloat = 34
    static let scrollViewContentOffsetY = -40
    
    static let readModeSettingsWidth = 240.0
    static let readModeSettingsHeight = 160.0
    
    static let minFontSize: CGFloat = 12
    static let maxFontSize: CGFloat = 36
    
    
    static let article = "Swami and Friends, set in British-colonial India in the year 1930, begins with an introduction to Swaminathan and his four principal friends: Somu, Sankar, Mani, and the Pea. Swaminathan appreciates his friends’ dramatically different personalities, and these differences only strengthen their powerful bond.\nThe arrival of Rajam, who is the son of Malgudi’s new police superintendent, changes everything. Initially, Swaminathan and Mani despise Rajam, but the three boys become best friends after confronting him. Likewise, Swaminathan’s friendship with Rajam also initially infuriates Somu, Sankar, and the Pea, but Rajam convinces all six of the boys to be friends, becoming the de-facto leader of their group in the process.\nWhen Swaminathan joins a mob protesting the recent arrest of a prominent Indian politician in Malgudi, his life changes forever. Inflamed and intoxicated by the mob’s nationalist fervor, Swaminathan shatters the windows of his headmaster’s office with a thrown rock. Though the crowd is dispersed by Rajam’s father, there are grave consequences. Several people are injured in the violence, and Swaminathan’s participation in the violence not only forces him to switch schools, but upsets Rajam, creating a rift in their friendship. Ultimately, Swaminathan atones for his regretful actions, earning Rajam’s forgiveness. Seeking a less destructive means to channel his passions, Swaminathan decides to join Rajam in founding a new cricket team, called the M.C.C.\nA match is scheduled between the M.C.C. and another local youth team called the Y.M.U, but new tensions mount between Rajam and Swaminathan in the buildup to the match. Swaminathan misses several practices due to the heavy homework load at his new school, and his truancy infuriates Rajam, who threatens to never speak to him again if he misses the Y.M.U. match.\nSwaminathan fails to persuade his stern headmaster at the new school into allowing him an early dismissal to attend M.C.C’s practices. Forbidden from participating with M.C.C., Swaminathan loses his cool, and throws his headmaster’s cane out the window. Terrified of the consequences, Swaminathan decides to flee Malgudi for good.\nSwaminathan becomes lost during his from Malgudi. By the time he is rescued, he has already missed the M.C.C.’s match and ruined his friendship with Rajam. He learns from Mani that Rajam’s father has been transferred to a new city, and that the boy will be departing for good on the following morning. Swaminathan decides to say goodbye to Rajam at the train station, and plans to give him a book as a parting gift\nUnfortunately, on the morning of Rajam’s departure, the train station is hectic and Swaminathan cannot reach Rajam before he boards the train. As the train prepares to depart, Mani pulls Swaminathan through the crowd, and up to the window of Rajam’s compartment. When Rajam refuses to speak to Swaminathan, Mani hands Swaminathan’s book to Rajam as the train departs. Mani attempts to console Swaminathan, reassuring him that Rajam intends to write and that he accepted his book; however, Swaminathan does not believe Mani, and the novel ends on a note of ambiguity and uncertainly, represented by Mani’s indecipherable facial expression."
}

