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

    /**
     * The {@code AppView} class.
     *
     * @since 1.0.0
     */
    public class AppView : Box {

         Box _root_box;
         Label _password_text;
         Scale _password_length_slider;
         Switch _switch_alpha;
         Switch _switch_numeric;
         
         PasswordGenerator _password_generator;
        /**
         * Constructs a new {@code AppView} object.
         */
        public AppView () {
 		    _root_box = new Box (Orientation.VERTICAL, 1);
            
            _password_generator = new PasswordGenerator ();
            
            create_password_text ();
            create_password_length_slider ();            
            create_switches ();          
            create_button ();              
            generate_password ();
         
            this.add (_root_box);        
        }
        
        private void create_password_text () {
            _password_text = new Label ("Password will be here");
            _password_text.selectable = true;
            _password_text.margin = 12;
            _password_text.wrap = true;
            _password_text.wrap_mode = Pango.WrapMode.CHAR;
            _root_box.add (_password_text);
        }
        
        private void create_password_length_slider () {
            _password_length_slider = new Scale.with_range (Orientation.HORIZONTAL, 1, 512, 1);
            _password_length_slider.set_value (128);
            _password_length_slider.hexpand = true;
            _password_length_slider.margin = 12;
            
            _root_box.add (_password_length_slider);        
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
            _root_box.add (switch_box);
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
            _root_box.add (switch_box);
        }
        
        private void create_button () {
            var button_generate_password = new Button.with_label (_("Generate Password"));
            button_generate_password.margin = 12;
            button_generate_password.clicked.connect (() => {
                generate_password ();
            });       
            _root_box.add (button_generate_password);
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
