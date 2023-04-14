//
//  Settings.swift
//  GeoCacheApp
//
//  Created by iosdev on 14.4.2023.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        List{
            LocaleSelect()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
