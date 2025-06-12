//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

import Foundation
import SwiftUI
import Domain

public struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    
    let localizationService: LocalizationService

    @Binding var selectedStatus: String?
    @Binding var selectedGender: String?

    @State private var tempStatus: String?
    @State private var tempGender: String?

    public init(selectedStatus: Binding<String?>, selectedGender: Binding<String?>, localizationService: LocalizationService) {
        self._selectedStatus = selectedStatus
        self._selectedGender = selectedGender
        self.localizationService = localizationService
    }

    public var body: some View {
        NavigationView {
            Form {
                statusSection
                genderSection
                clearFiltersSection
            }
            .navigationTitle(localizationService.localized("filters_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(localizationService.localized("filters_cancel")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(localizationService.localized("filters_apply")) {
                        applyFilters()
                        dismiss()
                    }
                }
            }
            .onAppear {
                tempStatus = selectedStatus
                tempGender = selectedGender
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifier.CharacterList.filtersView)
    }

    private var statusSection: some View {
        Section(header: Text(localizationService.localized("filters_status"))) {
            ForEach(statusOptions, id: \.self) { option in
                Button {
                    tempStatus = option
                } label: {
                    HStack {
                        Text(localizedStatus(option))
                        Spacer()
                        if tempStatus == option {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }

    private var genderSection: some View {
        Section(header: Text(localizationService.localized("filters_gender"))) {
            ForEach(genderOptions, id: \.self) { option in
                Button {
                    tempGender = option
                } label: {
                    HStack {
                        Text(localizedGender(option))
                        Spacer()
                        if tempGender == option {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    
    private var clearFiltersSection: some View {
        Group {
            if hasActiveFilters {
                Section {
                    Button(role: .destructive) {
                        clearFilters()
                    } label: {
                        HStack {
                            Spacer()
                            Text(localizationService.localized("filters_clear"))
                            Spacer()
                        }
                    }
                }
            }
        }
    }

    private let statusOptions: [String?] = [nil, "alive", "dead", "unknown"]

    private let genderOptions: [String?] = [nil, "female", "male", "genderless", "unknown"]

    private func localizedStatus(_ status: String?) -> String {
        switch status {
        case nil: return localizationService.localized("filters_all")
        case "alive": return localizationService.localized("filters_alive")
        case "dead": return localizationService.localized("filters_dead")
        case "unknown": return localizationService.localized("filters_unknown")
        default: return status ?? ""
        }
    }

    private func localizedGender(_ gender: String?) -> String {
        switch gender {
        case nil: return localizationService.localized("filters_all")
        case "female": return localizationService.localized("filters_female")
        case "male": return localizationService.localized("filters_male")
        case "genderless": return localizationService.localized("filters_genderless")
        case "unknown": return localizationService.localized("filters_unknown")
        default: return gender ?? ""
        }
    }
    
    private func applyFilters() {
        selectedStatus = tempStatus
        selectedGender = tempGender
    }
    
    private func clearFilters() {
        tempStatus = nil
        tempGender = nil
    }
    
    private var hasActiveFilters: Bool {
        tempStatus != nil || tempGender != nil
    }
}

