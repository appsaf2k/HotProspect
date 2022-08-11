//
//  ImageInterpolation.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//
/// Управление интерполяцией изображений в SwiftUI



import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        Image("alienYellow_hurt")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)

    }
}

struct ImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolation()
    }
}
