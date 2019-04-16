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

    public abstract class CapitalizationHelper : Object {

        public static string apply_capitalization_style (string[] words,
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

        public static string capitalize_word (string word) {
            if (word.length == 0) {
                return "";
            } else if (word.length == 1) {
                return word.up ();
            }
            return word.substring (0, 1).up () + word.substring (1);
        }
    }
}
