// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Action {
    /// Localizable.strings
    ///   Amby
    /// 
    ///   Created by syan on 29/03/2024.
    internal static let cancel = L10n.tr("Localizable", "action.cancel", fallback: "Cancel")
    /// Close
    internal static let close = L10n.tr("Localizable", "action.close", fallback: "Close")
    /// Delete
    internal static let delete = L10n.tr("Localizable", "action.delete", fallback: "Delete")
    /// Add to favorites
    internal static let favorite = L10n.tr("Localizable", "action.favorite", fallback: "Add to favorites")
    /// Remove from favorites
    internal static let unfavorite = L10n.tr("Localizable", "action.unfavorite", fallback: "Remove from favorites")
  }
  internal enum Contact {
    /// contact@syan.me
    internal static let address = L10n.tr("Localizable", "contact.address", fallback: "contact@syan.me")
    /// Copy email address to pasteboard
    internal static let copy = L10n.tr("Localizable", "contact.copy", fallback: "Copy email address to pasteboard")
    /// About Amby %@ (%@)
    internal static func subject(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "contact.subject", String(describing: p1), String(describing: p2), fallback: "About Amby %@ (%@)")
    }
    /// Choose your messaging app
    internal static let title = L10n.tr("Localizable", "contact.title", fallback: "Choose your messaging app")
  }
  internal enum Error {
    /// Operation cancelled
    internal static let cancelled = L10n.tr("Localizable", "error.cancelled", fallback: "Operation cancelled")
    /// Couldn't decode content of type %@: %@
    internal static func decoding(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "error.decoding", String(describing: p1), String(describing: p2), fallback: "Couldn't decode content of type %@: %@")
    }
    /// You seem to be offline, retry when you have access to the internet
    internal static let offline = L10n.tr("Localizable", "error.offline", fallback: "You seem to be offline, retry when you have access to the internet")
    /// The request couldn't finish
    internal static let request = L10n.tr("Localizable", "error.request", fallback: "The request couldn't finish")
  }
  internal enum Favorites {
    /// Favorites
    internal static let title = L10n.tr("Localizable", "favorites.title", fallback: "Favorites")
  }
  internal enum Map {
    /// Map
    internal static let title = L10n.tr("Localizable", "map.title", fallback: "Map")
    /// Last update on %@
    internal static func updatedAt(_ p1: Any) -> String {
      return L10n.tr("Localizable", "map.updated_at", String(describing: p1), fallback: "Last update on %@")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
