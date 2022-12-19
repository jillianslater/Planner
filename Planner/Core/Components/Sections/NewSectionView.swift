//
//  NewSectionView.swift
//  Planner
//
//  Created by Jillian Slater on 11/28/22.
//

import SwiftUI

struct NewSectionView: View {
    @Binding var section: Section
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack (alignment : .leading, spacing: 30) {
                Text("Add New Section")
                    .font(.title)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                
                TextField(
                    "Section Name: ",
                    text: $section.title
                )
                
                VStack {
                    Text("Section Type:")
                        .font(.headline)
                    
                    Picker(selection: $section.type, label: Text("Section Type:")) {
                        Text("Checklist").tag(0)
                        Text("Timed").tag(1)
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                
                VStack {
                    Text("Color:")
                        .font(.headline)
                    
                    Picker(selection: $section.color, label: Text("Color:")) {
                        Text("1").tag(1)
                        Text("2").tag(2)
                        Text("3").tag(3)
                        Text("4").tag(4)
                        Text("5").tag(5)
                        Text("6").tag(6)
                        Text("7").tag(7)
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.75, green: 0.37, blue: 0.40))
                                .frame(height: 40)
                            Text("1")
                                .foregroundColor(.white)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.60, green: 0.17, blue: 0.02))
                                .frame(height: 40)
                            Text("2")
                                .foregroundColor(.white)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.83, green: 0.53, blue: 0.17))
                                .frame(height: 40)
                            Text("3")
                                .foregroundColor(.white)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.35, green: 0.56, blue: 0.63))
                                .frame(height: 40)
                            Text("4")
                                .foregroundColor(.white)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.16, green: 0.42, blue: 0.55))
                                .frame(height: 40)
                            Text("5")
                                .foregroundColor(.white)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.01, green: 0.25, blue: 0.36))
                                .frame(height: 40)
                            Text("6")
                                .foregroundColor(.white)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.0, green: 0.19, blue: 0.28))
                                .frame(height: 40)
                            Text("7")
                                .foregroundColor(.white)
                        } // ZStack
                    } // HStack
                } // VStack - Color

            } // VStack - all text
            .padding(.bottom, 200)
            .padding(.horizontal)
        } // NavigationView
    }
}

struct NewSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSectionView(section: .constant(Section(title: "", type: 0, color: 0)))
    }
}
