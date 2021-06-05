//
//  ContentView.swift
//  CatalystPrefsWindow
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import SwiftUI

struct PreferencesContentView2: View {
	
	@State var homepage = "https://www.apple.com"
	
	var newTabOptions = ["Empty Page", "Home Page"]
	@State private var selectedNewTabOption = "Empty Page"
	
	var spacer: some View {
		Spacer(minLength: 0)
			.frame(height:UIFloat(32))
	}
	
	var body: some View {
		VStack {
			GroupBox {
				VStack {
					HStack {
						Text("Homepage:")
							.frame(width:UIFloat(200), alignment: .trailing)
						
						TextField("", text: $homepage)
							.textFieldStyle(RoundedBorderTextFieldStyle())
					}
					.frame(maxWidth:UIFloat(500))
					
					HStack {
						Spacer(minLength: 0)
							.frame(width:UIFloat(200), alignment: .trailing)
						
						Button("Set to Current Page") {
							
						}
						.padding(.horizontal, UIFloat(12))
						Spacer(minLength: 0)
					}
					.frame(maxWidth:UIFloat(500))
					
					spacer
					
					HStack {
						Text("New tabs open with:")
							.frame(width:UIFloat(200), alignment: .trailing)
						
						Picker(selection: $selectedNewTabOption, label:Group{}) {
							ForEach(newTabOptions, id: \.self) {
								Text($0)
							}
						}
					}
					.frame(maxWidth:UIFloat(500))
					
					Spacer(minLength: 0)
					
					Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
						.font(.caption)
					
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding()
			}
			.padding()
		}
	}
}

struct PreferencesContentView: View {
	
	@State var first = false
	@State var second = true
	
	var mailboxes = ["Trash", "Junk"]
	@State private var selectedMailbox = "Trash"
	
	var colors = ["Red", "Blue", "Green"]
	@State private var selectedColor = "Red"
	
	var spacer: some View {
		Spacer(minLength: 0)
			.frame(height:UIFloat(32))
	}
	
	var body: some View {
		
		VStack {
			GroupBox {
				VStack(alignment: .leading) {
					Toggle(isOn: $first) {
						Text("Enable junk mail filtering")
						Spacer(minLength: 0)
					}
					
					spacer
					
					Group {
						
						Text("The following types of mail are exempt from junk mail filtering:")
						
						Toggle(isOn: $second) {
							Text("Sender of message is in Contacts")
							Spacer(minLength: 0)
						}
						
						Toggle(isOn: $second) {
							Text("Message is addressed using my full name")
							Spacer(minLength: 0)
						}
					}
					
					spacer
					
					HStack {
						Text("Move currently selected messages into:")
							.frame(minWidth:UIFloat(320), alignment: .leading)
						
						Picker("", selection: $selectedMailbox) {
							ForEach(mailboxes, id: \.self) {
								Text($0)
							}
						}
					}
					
					spacer
					
					Group {
						Text("Please choose a color")
						Picker(selection: $selectedColor, label:Group{}) {
							ForEach(colors, id: \.self) {
								Text($0)
							}
						}
						.pickerStyle(InlinePickerStyle())
					}
					
					spacer
					
					Button("Advanced") {
						
					}
					
					Spacer(minLength: 0)
				}
				.padding()
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			
			
		}
		.padding()
	}
}

struct PreferencesContentView_Previews: PreviewProvider {
	static var previews: some View {
		PreferencesContentView()
			.previewLayout(.fixed(width: UIFloat(600), height: UIFloat(480)))
	}
}
