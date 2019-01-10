/*
* Copyright (C) 2019  Christopher Nugent <awedeven+elementarydev@gmail.com>
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

    public abstract class RandomStringGenerator {

        private const string ALPHA_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        private const string NUMERIC_CHARS = "1234567890";
        // TODO Decide on a set of special characters, or make configureable.
        private const string SPECIAL_CHARS = "$%^&";

        public static string get_random_string (int length, bool allow_alpha,
                bool allow_numeric, bool allow_special=false) {
            var allowed_characters = "";
            if (allow_alpha) {
                allowed_characters += ALPHA_CHARS;
            }
            if (allow_numeric) {
                allowed_characters += NUMERIC_CHARS;
            }
            if (allow_special) {
                allowed_characters += SPECIAL_CHARS;
            }
            return get_random_string_from_characters (allowed_characters);
        }

        public static string get_random_string_from_characters (string allowed_characters) {
            var password_builder = new StringBuilder ();
            for (var i = 0; i < length; i++) {
                var random_index = Random.int_range (0, allowed_characters.length);
                password_builder.append_c (allowed_characters[random_index]);
            }
            return password_builder.str;
        }
    }
}
