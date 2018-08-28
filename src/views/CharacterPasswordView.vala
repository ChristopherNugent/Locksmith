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

using App.Configs;
using App.Widgets;
using App;
using Gtk;

namespace App.Views {

    public class CharacterPasswordView : Grid {
    
        private App.Configs.Settings _settings;
        private PasswordGenerator _password_generator;
        private Entry _password_text;
        private SpinButton password_length_entry;
        private Switch _switch_alpha;
        private Switch _switch_numeric;
        
        
        public CharacterPasswordView (PasswordGenerator password_generator) {
            _settings = App.Configs.Settings.get_instance ();

            _password_generator = password_generator;
           
            row_homogeneous = false;
           
            create_password_text ();
            create_password_length_slider ();            
            create_switches ();          
            create_button ();              

            apply_settings ();
            
            
        }
        

            
        private void create_password_text () {
            _password_text = new Entry ();
            _password_text.max_width_chars = 64;
            _password_text.editable = false;
            _password_text.margin = 12;

            attach (_password_text, 0, 0);
        }
        
        private void create_password_length_slider () {
            var box = new Box (Orientation.HORIZONTAL, 12);
            box.halign = Align.CENTER;
            
            var label = new Label (_("Password Length"));
            
            password_length_entry = new SpinButton.with_range (0, 512, 64);
            password_length_entry.hexpand = false;
            password_length_entry.value_changed.connect (() => {
                _settings.char_length = password_length;
            });
            
            
            box.add (label);
            box.add (password_length_entry);

            attach (box, 0, 1);
        }
        
        private void create_switches () {
            create_switch_alpha ();
            create_switch_numeric ();
        }
        
        private void create_switch_alpha () {
            var switch_box = new Box (Orientation.HORIZONTAL, 0);
            switch_box.halign = Align.CENTER;

            var switch_label = new Label(_("Alphabet characters"));
            _switch_alpha = new Switch ();    
            _switch_alpha.margin = 12;
            _switch_alpha.active = true;
            _switch_alpha.activate.connect (() => {
                _settings.char_alpha = _switch_alpha.active;
            });
            
            switch_box.add (switch_label);
            switch_box.add (_switch_alpha);

            attach (switch_box, 0, 2);
        }
        
        private void create_switch_numeric () {
            var switch_box = new Box (Orientation.HORIZONTAL, 0);
            switch_box.halign = Align.CENTER;
            
            var switch_label = new Label(_("Numeric characters"));
            _switch_numeric = new Switch ();
            _switch_numeric.margin = 12;
            _switch_numeric.active = true;
            _switch_numeric.activate.connect (() => {
                _settings.char_numeric = _switch_numeric.active;
            });
            
            switch_box.add (switch_label);
            switch_box.add (_switch_numeric);
            
            attach (switch_box, 0, 3);
        }
        
        private void create_button () {
            var button_generate_password = new Button.with_label (_("Generate Password"));
            button_generate_password.margin = 12;
            button_generate_password.clicked.connect (() => {
                generate_password ();
            });       
            
            attach (button_generate_password, 0, 4);
        }
        
        private void generate_password () {
            var allow_alpha = _switch_alpha.active;
            var allow_numeric = _switch_numeric.active;
            var generated_password = _password_generator.generate_password (
                password_length, allow_alpha, allow_numeric);
            _password_text.text = generated_password;
            _settings.char_password = generated_password;
        }
        
        
        private void apply_settings () {
                        
            //_password_length_slider.set_value (_settings.char_length);
            password_length_entry.value = _settings.char_length;
            _switch_alpha.active = _settings.char_alpha;
            _switch_numeric.active = _settings.char_numeric; 
            
            var password = _settings.char_password;
            if (password == "") {
                generate_password ();
            } else {
                _password_text.text = password;
            }
        }
        
        private int password_length { 
            get {
               return (int) password_length_entry.value; 
            }
        }
    }
}
