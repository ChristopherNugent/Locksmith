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

namespace App {

    public class PasswordGenerator {
    
        
        public PasswordGenerator () {}
        
        public string generate_password (int length, bool allowAlpha, bool allowNumeric) {
            if (length == 0) {
                return _("Well... Okay?");
            } else if (!(allowAlpha || allowNumeric)) {
                return _("I'm not sure what you want me to do.'");
            }           

            var allowed_characters = "";
            if (allowAlpha) {
                allowed_characters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                allowed_characters += "abcdefghijklmnopqrstuvwxyz";
            }
            if (allowNumeric) {
                allowed_characters += "1234567890";
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
