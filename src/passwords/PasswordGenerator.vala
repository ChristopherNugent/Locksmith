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

    public class PasswordGenerator : Object {

        private static Dictionary dictionary { get; default = new Dictionary.from_builtin_dictionary (); }

        public PasswordGenerator () { /* members constructed by property defaults */ }

        public string generate_password (int length, bool allow_alpha,
                bool allow_numeric, bool allow_special) {
            return RandomStringGenerator.get_random_string (length, allow_alpha, allow_numeric, allow_special);
        }

        public string generate_password_from_words (int length,
                CapitalizationMode capitalization_mode) {
            string[] words = new string[length];
            for (var i = 0; i < length; i++) {
                words[i] = dictionary.get_random_word ();
            }
            return CapitalizationHelper.apply_capitalization_style (words, capitalization_mode);
        }
    }
}
