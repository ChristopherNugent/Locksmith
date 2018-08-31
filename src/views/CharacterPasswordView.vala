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
using App.Passwords;

namespace App.Views {

    public class CharacterPasswordView : PasswordView {
    
        private Switch switch_alpha;
        private Switch switch_numeric;
        
        private bool allow_alpha {
            get { return switch_alpha.active; }
            set { switch_alpha.active = value; }
        }
        
        private bool allow_numeric {
            get { return switch_numeric.active; }
            set { switch_numeric.active = value; }
        }
        
        public CharacterPasswordView (PasswordGenerator password_generator) {
            base(password_generator);
            
            margin = 12;
            row_spacing = 18;
            
            max_length = 512;
             
            create_switches ();          
        
            apply_settings ();
        }
        
        private void create_switches () {
            create_switch_alpha ();
            create_switch_numeric ();
        }
        
        private void create_switch_alpha () {
            var switch_box = new Box (Orientation.HORIZONTAL, 12);
            switch_box.halign = Align.CENTER;

            var switch_label = new Label(_("Alphabet characters"));
            switch_alpha = new Switch ();    
            switch_alpha.state_set.connect ((state) => {
                settings.char_alpha = state;
                return false;
            });
            
            switch_box.add (switch_label);
            switch_box.add (switch_alpha);

            attach (switch_box, 0, 2);
        }
        
        private void create_switch_numeric () {
            var switch_box = new Box (Orientation.HORIZONTAL, 12);
            switch_box.halign = Align.CENTER;
            
            var switch_label = new Label(_("Numeric characters"));
            switch_numeric = new Switch ();
            switch_numeric.state_set.connect ((state) => {
                settings.char_numeric = state;
                return false;
            });
            
            switch_box.add (switch_label);
            switch_box.add (switch_numeric);
            
            attach (switch_box, 0, 3);
        }
        
        protected override void generate_password () {
            var generated_password = password_generator.generate_password (
                password_length, allow_alpha, allow_numeric);
            password = generated_password;
            settings.char_password = generated_password;
        }
        
        private void apply_settings () {
            password_length = settings.char_length;
            allow_alpha = settings.char_alpha;
            allow_numeric = settings.char_numeric; 
            
            var saved_password = settings.char_password;
            if (saved_password == "") {
                generate_password ();
            } else {
                password = saved_password;
            }
        }
    }
}
