/*
* Copyright (C) 2018  Christopher Nugent <awedeven+elementarydev@gmail.com>
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

using GLib;
using Gee;
using GLib.Environment;

namespace App.Passwords {

    public class PasswordGenerator : Object {

        private static Dictionary dictionary { get; default = new Dictionary.from_builtin_dictionary (); }

        public PasswordGenerator () {}

        public string generate_password (int length, bool allow_alpha, bool allow_numeric) {
            return RandomStringGenerator.get_random_string (length, allow_alpha, allow_numeric);
        }

        public string generate_password_from_words (int length,
                CapitalizationMode capitalization_mode) {
            string[] words = new string[length];
            for (var i = 0; i < length; i++) {
                words[i] = dictionary.get_random_word ();
            }
            return apply_capitalization_style (words, capitalization_mode);
        }

        private static string apply_capitalization_style (string[] words,
                CapitalizationMode capitalization_mode) {
            switch (capitalization_mode) {
                case CapitalizationMode.TITLE_CASE:
                    for (var i = 0; i < words.length; i++) {
                        words[i] = capitalize_word (words[i]);
                    }
                    return string.joinv ("", words);
                case CapitalizationMode.CAMEL_CASE:
                    for (var i = 1; i < words.length; i++) {
                        words[i] = capitalize_word (words[i]);
                    }
                    return string.joinv ("", words);
                case CapitalizationMode.LOWER_CASE:
                    return string.joinv ("_", words);
                default:
                    return "";
            }
        }

        private static string capitalize_word (string word) {
            if (word.length == 0) {
                return "";
            } else if (word.length == 1) {
                return word.up ();
            }
            return word.substring (0, 1).up () + word.substring (1);
        }
    }
}
