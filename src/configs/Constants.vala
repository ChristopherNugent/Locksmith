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

namespace App.Configs {

    /**
     * The {@code Constants} class is responsible for defining all 
     * the constants used in the application.
     *
     * @since 1.0.0
     */
    public class Constants {
    
        public abstract const string ID = "com.github.christophernugent.locksmith";
        public abstract const string VERSION = "1.5.1";
        public abstract const string PROGRAME_NAME = ("Locksmith");
        public abstract const string APP_YEARS = "2018-2019";
        public abstract const string APP_ICON = "com.github.christophernugent.locksmith";
        public abstract const string ABOUT_COMMENTS = (_("Generate strong, secure passwords"));
        public abstract const string TRANSLATOR_CREDITS = (_("Translators"));
        public abstract const string MAIN_URL = "https://github.com/ChristopherNugent";
        public abstract const string BUG_URL = "{{ repo-url }}/issues";
        public abstract const string HELP_URL = "{{ repo-url }}/wiki";
        public abstract const string TRANSLATE_URL = "{{ repo-url }}";
        public abstract const string TEXT_FOR_ABOUT_DIALOG_WEBSITE = (_("Website"));
        public abstract const string TEXT_FOR_ABOUT_DIALOG_WEBSITE_URL = "https://github.com/ChristopherNugent";
        public abstract const string URL_CSS = "/com/github/christophernugent/locksmith/css/style.css";
        public abstract const string [] ABOUT_AUTHORS = { "Christopher Nugent <awedeven+elementarydev@gmail.com>" };
        public abstract const Gtk.License ABOUT_LICENSE_TYPE = Gtk.License.GPL_3_0;
    }
}
