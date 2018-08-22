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

        
        private Stack _stack;
        private StackSwitcher _stack_switcher;
        
         
        private Box _root_box_w;
        private Label _password_text_w;
         
        PasswordGenerator _password_generator;
        /**
         * Constructs a new {@code AppView} object.
         */
        public AppView () {
            _password_generator = new PasswordGenerator ();
            
            create_stack ();
            _stack.add_titled (new CharacterPasswordView (_password_generator),
                    "character", _("Character Based"));
            create_word_ui ();
            
            
        }
        
        private void create_stack () {
            var root_box = new Box (Orientation.VERTICAL, 1);
            _stack_switcher = new StackSwitcher();
            _stack_switcher.halign = Align.CENTER;
            _stack = new Stack ();
            
            _stack_switcher.stack = _stack;
            
            root_box.add (_stack_switcher);
            root_box.add (_stack);
            
            this.add (root_box);
        }
 
        private void create_word_ui () {
 		    _root_box_w = new Box (Orientation.VERTICAL, 1);
            _password_text_w = new Label ("Password will be here");
            
            _root_box_w.add (_password_text_w);
            
            _stack.add_titled (_root_box_w, "word", _("Word Based")); 
        }
    }
}
