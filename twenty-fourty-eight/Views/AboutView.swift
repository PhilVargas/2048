//
//  AboutView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/18/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.neutral.ignoresSafeArea()

            VStack(spacing: 48) {
                VStack(spacing: 24) {
                    Text("2048 by Philip A Vargas")
                        .font(.title)

                    Text("Built using SwiftUI and The Composable Architecture")

                    Text("[View Source Code](https://github.com/PhilVargas/2048)")
                }

                VStack(spacing: 16) {
                    Text("View Profiles")
                        .font(.title2)

                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Image("github-icon")
                                .resizable()
                                .frame(maxWidth: 20, maxHeight: 20)
                            Text("[@PhilVargas](https://github.com/PhilVargas)")
                        }

                        HStack(spacing: 4) {
                            Image("stack-overflow-icon")
                                .resizable()
                                .frame(maxWidth: 20, maxHeight: 20)
                            Text("[@PhilVarg](https://stackoverflow.com/users/3213605/philvarg)")
                        }
                    }
                }

                Spacer()
            }
            .foregroundColor(.textColor(.primary))
            .padding(.top, 48)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
