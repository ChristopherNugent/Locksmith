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
    
        private PasswordGenerator _password_generator;
        private Label _password_text;
        private Scale _password_length_slider;
        private Switch _switch_alpha;
        private Switch _switch_numeric;
        
        public CharacterPasswordView (PasswordGenerator password_generator) {
            _password_generator = password_generator;
           
           row_homogeneous = false;
           
            create_password_text ();
            create_password_length_slider ();            
            create_switches ();          
            create_button ();              
            generate_password ();
        }
        

            
        private void create_password_text () {
            _password_text = new Label ("Password will be here");
            _password_text.selectable = true;
            _password_text.margin = 12;
            _password_text.wrap = true;
            _password_text.wrap_mode = Pango.WrapMode.CHAR;

            attach (_password_text, 0, 0);
        }
        
        private void create_password_length_slider () {
            
            _password_length_slider = new Scale.with_range (Orientation.HORIZONTAL, 1, 512, 1);
            _password_length_slider.set_value (128);
            _password_length_slider.hexpand = true;
            _password_length_slider.margin = 12;
            
            _password_length_slider.add_mark (  1, PositionType.TOP, "1");
            _password_length_slider.add_mark ( 64, PositionType.TOP, "64");
            _password_length_slider.add_mark (128, PositionType.TOP, "128");
            _password_length_slider.add_mark (256, PositionType.TOP, "256");
            _password_length_slider.add_mark (512, PositionType.TOP, "512");
            
            attach (_password_length_slider, 0, 1);
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
            var length = (int) _password_length_slider.get_value ();
            var allow_alpha = _switch_alpha.active;
            var allow_numeric = _switch_numeric.active;
            var generated_password = _password_generator.generate_password (
                length, allow_alpha, allow_numeric);
            _password_text.label = generated_password;
        }
    }
}
