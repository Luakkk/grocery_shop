//
//  AccountView.swift
//  TolykSebet
//
//  Created by Alua Smanova on 12.05.2025.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                // MARK: - User Info
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Alua Merey")
                            .font(.headline)
                        Text("funnyduck@gmail.com")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Button {
                        // Edit profile
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)

                // MARK: - Options List
                List {
                    Section {
                        accountRow(title: "Orders", systemIcon: "bag")
                        accountRow(title: "My Details", systemIcon: "person.crop.circle")
                        accountRow(title: "Delivery Address", systemIcon: "mappin.and.ellipse")
                        accountRow(title: "Payment Methods", systemIcon: "creditcard")
                        accountRow(title: "Notifications", systemIcon: "bell")
                        accountRow(title: "About", systemIcon: "info.circle")
                    }

                    Section {
                        Button {
                            // Logout action
                        } label: {
                            HStack {
                                Image(systemName: "arrow.turn.down.left")
                                Text("Log Out")
                            }
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Account")
        }
    }

    // MARK: - Helper
    func accountRow(title: String, systemIcon: String) -> some View {
        HStack {
            Image(systemName: systemIcon)
                .foregroundColor(.gray)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Handle navigation for each section if needed
        }
    }
}
