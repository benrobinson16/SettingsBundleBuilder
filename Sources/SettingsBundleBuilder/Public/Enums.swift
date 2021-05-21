// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// Enums.swift

public enum KeyboardType: String {
    case alphabet = "Alphabet"
    case numbersAndPunctuation = "NumbersAndPunctuation"
    case numberPad = "NumberPad"
    case url = "URL"
    case emailAddress = "EmailAddress"
}

public enum AutocapitalizationType: String {
    case none = "None"
    case sentences = "Sentences"
    case words = "Words"
    case allCharacters = "AllCharacters"
}

public enum AutocorrectionType: String {
    case `default` = "Default"
    case no = "No"
    case yes = "Yes"
}

public enum UIIdiom: String {
    case phone = "Phone"
    case pad = "Pad"
}
