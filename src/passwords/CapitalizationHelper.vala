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


namespace App.Passwords {

    public abstract class CapitalizationHelper : Object {

        /**
         * Apply the specified capitalization style to an array of strings.
         *
         * Apply the specified capitalization style to an array of strings,
         * joining the results however specified.
         *
         * For CAMEL_CASE and TITLE_CASE, there is no delimiter.
         *
         * For LOWER_CASE, the words are delimited with underscores.
         *
         * @param words an array of input words
         * @param capitalization_mode the capitalization style to use
         * @return The capitalized and joined string
         */
        public static string apply_capitalization_style (string[] words,
                CapitalizationMode capitalization_mode) {
            switch (capitalization_mode) {
                case CapitalizationMode.TITLE_CASE:
                    return apply_title_case(words);
                case CapitalizationMode.CAMEL_CASE:
                    return apply_camel_case(words);
                case CapitalizationMode.LOWER_CASE:
                    return string.joinv ("_", words);
                default:
                    return "";
            }
        }

        private static string apply_title_case(string[] words) {
            for (var i = 0; i < words.length; i++) {
                words[i] = capitalize_word (words[i]);
            }
            return string.joinv ("", words);
        }

        private static string apply_camel_case(string[] words) {
            for (var i = 1; i < words.length; i++) {
                words[i] = capitalize_word (words[i]);
            }
            return string.joinv ("", words);
        }

        /*
         * Just a dumb helper function to convert the first character
         * of a string to uppercase.
         *
         * There's probably a cleaner way to implement this but I'm not super
         * familiar with Vala.
         */
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
