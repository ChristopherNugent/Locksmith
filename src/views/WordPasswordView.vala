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

    public class WordPasswordView : Grid {
    
        private CapitalizationMode capitalization_mode;
        private PasswordGenerator password_generator;
        private App.Configs.Settings settings;
        
        private Entry password_text;
        private SpinButton password_length_entry;
        
        private RadioButton[] radios;
        
       private string password {
           get { return password_text.text; }
           set { password_text.text = value; }
       }

       private int password_length { 
           get { return (int) password_length_entry.value; }
           set { password_length_entry.value = value; }
       }
        
        public WordPasswordView (PasswordGenerator password_generator) {
            settings = App.Configs.Settings.get_instance ();
            this.password_generator = password_generator;
           
            margin = 12;
            row_spacing = 12;
            
            create_password_text ();
            create_password_length_entry ();
            create_radio ();
            create_button ();              
            
            apply_settings ();
        }
        
       private void create_password_text () {
           password_text = new Entry ();
           password_text.max_width_chars = 64;
           password_text.editable = false;
           //password_text.margin = 12;

           attach (password_text, 0, 0);
       }
       
       private void create_password_length_entry () {
           var box = new Box (Orientation.HORIZONTAL, 12);
           box.halign = Align.CENTER;
           
           var label = new Label (_("Password Length"));
           
           password_length_entry = new SpinButton.with_range (0, 512, 64);
           password_length_entry.hexpand = false;
           password_length_entry.value_changed.connect (() => {
               settings.word_length = password_length;
           });
           
           
           box.add (label);
           box.add (password_length_entry);

           attach (box, 0, 1);
       }
            
        private void create_button () {
            var button_generate_password = new Button.with_label (_("Generate Password"));
            button_generate_password.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            button_generate_password.clicked.connect (() => {
                generate_password ();
            });
            attach (button_generate_password, 0, 4);   
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
        
        private void generate_password () {
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
