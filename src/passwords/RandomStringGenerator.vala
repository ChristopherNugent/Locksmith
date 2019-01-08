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

        public static string get_random_string (int length, bool allowAlpha, bool allowNumeric) {
            var allowed_characters = "";
            if (allowAlpha) {
                allowed_characters += ALPHA_CHARS;
            }
            if (allowNumeric) {
                allowed_characters += NUMERIC_CHARS;
            }
            var password_builder = new StringBuilder ();
            for (var i = 0; i < length; i++) {
                var random_index = Random.int_range(0, allowed_characters.length);
                password_builder.append_c (allowed_characters[random_index]);
            }
            return password_builder.str;
        }
    }
}