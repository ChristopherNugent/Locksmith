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

    public class PasswordGenerator {
    
        private const string ALPHA_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        private const string NUMERIC_CHARS = "1234567890";
        
        private ArrayList<string> _words;
        
        public PasswordGenerator () {
            _words = new ArrayList<string> ();

            try {            
                var dictionary_file = File.new_for_uri("resource:///data/words_alpha.txt");
                var dis = new DataInputStream (dictionary_file.read ());
                string line;
                while ((line = dis.read_line (null)) != null) {
                    _words.add (line.strip ().down ());
                }
            } catch (Error e) {}
        }
        
        public string generate_password (int length, bool allowAlpha, bool allowNumeric) {
            if (length == 0) {
                return _("Well... Okay?");
            } else if (!(allowAlpha || allowNumeric)) {
                return _("I'm not sure what you want me to do.'");
            }           

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
        
        public string generate_password_from_words (int length, 
                CapitalizationMode capitalization_mode) {
            if (length == 0) {
                return _("Here ya go!");
            } else if (_words.size == 0) {
                return _("Empty Dictionary");
            }
            string[] words = new string[length];
            for(var i = 0; i < length; i++) {
                var random_index = Random.int_range(0, _words.size);
                words[i] = _words[random_index];
            }
            
            switch (capitalization_mode) {
                case CapitalizationMode.TITLE_CASE:
                    for (var i = 0; i < length; i++) {
                        words[i] = capitalize_word(words[i]);
                    }
                    return string.joinv("", words);
                case CapitalizationMode.CAMEL_CASE:
                    for (var i = 1; i < length; i++) {
                        words[i] = capitalize_word(words[i]);
                    }
                    return string.joinv("", words);
                case CapitalizationMode.LOWER_CASE:
                    return string.joinv("_", words);    
            }           
            return "";
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