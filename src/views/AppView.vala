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

namespace App.Views {

    /**
     * The {@code AppView} class.
     *
     * @since 1.0.0
     */
    public class AppView : Gtk.Box {

        /**
         * Constructs a new {@code AppView} object.
         */
        public AppView () {
 		    var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 1);
            box.hexpand = true;
        
            var password_box = new Gtk.TextView ();
            password_box.margin = 12;
            password_box.buffer.text = "Lorem Ipsum";
            password_box.editable = false; 
            password_box.hexpand = true;
            
            var password_length = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 256, 1);
            password_length.margin = 12;
            
            var button_hello = new Gtk.Button.with_label ("Click me!");
            button_hello.margin = 12;
            button_hello.clicked.connect (() => {
                button_hello.label = "Hello World!";
                button_hello.sensitive = false;
            });
            
            
           
            box.add (password_box);
            box.add (password_length);
            box.add (button_hello);
            
            this.add (box);
        }
    }
}
