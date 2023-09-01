// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

extension Font {
	/// Create a custom font with the given name and size that scales relative to the given textStyle.
	///
	/// Font is static in iOS 13.0
	static func promptDynamic(_ style: PromptStyle, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
		if #available(iOS 14.0, *) {
			return Font.custom(style.rawValue, size: size, relativeTo: textStyle)
		} else {
			return Font.custom(style.rawValue, size: size)
		}
	}

	/// Create a custom font with the given name and size that scales with the body text style.
	static func prompt(_ style: PromptStyle, size: CGFloat) -> Font {
		return Font.custom(style.rawValue, size: size)
	}

	/// Create a custom font with the given name and a fixed size that does not scale with Dynamic Type.
	@available(iOS 14.0, *)
	static func prompt(_ style: PromptStyle, fixedSize: CGFloat) -> Font {
		return Font.custom(style.rawValue, fixedSize: fixedSize)
	}

	/// Create a custom font with the given name and size that scales relative to the given textStyle.
	@available(iOS 14.0, *)
	static func prompt(_ style: PromptStyle, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
		return Font.custom(style.rawValue, size: size, relativeTo: textStyle)
	}

	enum PromptStyle: String {
		case bold = "Prompt-Bold"
		case boldItalic = "Prompt-BoldItalic"
		case extraBold = "Prompt-ExtraBold"
		case extraBoldItalic = "Prompt-ExtraBoldItalic"
		case italic = "Prompt-Italic"
		case medium = "Prompt-Medium"
		case mediumItalic = "Prompt-MediumItalic"
		case regular = "Prompt-Regular"
		case semiBold = "Prompt-SemiBold"
		case semiBoldItalic = "Prompt-SemiBoldItalic"
	}
}
