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

using Gtk;
using App.Configs;
using App.Passwords;
using App.Widgets;

namespace App.Views {

    public class WordPasswordView : PasswordView {
    
        private CapitalizationMode capitalization_mode;
        
        private RadioButton[] radios;
        
        public WordPasswordView (PasswordGenerator password_generator) {
            base (password_generator);
            
            max_length = 10;
            
            create_radio ();
         
            apply_settings ();
        }
        
        private void create_radio () {
            radios = new RadioButton[3];
            
            var radio_box = new Box (Orientation.HORIZONTAL, 12);
            //radio_box.margin = 12;
            radio_box.halign = Align.CENTER;           
            
                           
            var camel_case_radio = new RadioButton.with_label_from_widget (null,
                    _("camelCase"));
            camel_case_radio.toggled.connect (() => {
                if (camel_case_radio.active) {
                    capitalization_mode = CapitalizationMode.CAMEL_CASE;
                    settings.word_mode = 0;
                }
            });
            camel_case_radio.active = true;
            radios[0] = camel_case_radio;
            radio_box.add (camel_case_radio);
            
            var title_case_radio = new RadioButton.with_label_from_widget (camel_case_radio,
                    _("TitleCase"));
            title_case_radio.toggled.connect (() => {
                if (title_case_radio.active) {
                    capitalization_mode = CapitalizationMode.TITLE_CASE;
                    settings.word_mode = 1;
                }
            });
            radios[1] = title_case_radio;
            radio_box.add (title_case_radio);
            
            var lower_case_radio = new RadioButton.with_label_from_widget (camel_case_radio,
                    _("lower_case"));
            lower_case_radio.toggled.connect (() => {
                if (lower_case_radio.active) {
                    capitalization_mode = CapitalizationMode.LOWER_CASE;
                    settings.word_mode = 2;
                }
            });
            radios[2] = lower_case_radio;
            radio_box.add (lower_case_radio);
            attach (radio_box, 0, 3);
        }
        
        protected override void generate_password () {
            var generated_password = password_generator.generate_password_from_words (
                password_length, capitalization_mode);
            password = generated_password;
            settings.word_password = generated_password;
        }
        
        private void apply_settings () {
            radios[settings.word_mode].active = true;
            password_length = settings.word_length;
            
            var saved_password = settings.word_password;
            if (saved_password == "") {
                generate_password ();
            } else {
                password = saved_password;
            }
        }
    }
}
