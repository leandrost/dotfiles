/*
 * Copyright (C) 2011-2012 Marco Barisione <marco@barisione.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

const ExtensionUtils = imports.misc.extensionUtils;
const GLib = imports.gi.GLib;
const Lang = imports.lang;
const Main = imports.ui.main;
const Meta = imports.gi.Meta;
const MessageTray = imports.ui.messageTray;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;
const St = imports.gi.St;

const Me = ExtensionUtils.getCurrentExtension();
const Convenience = Me.imports.convenience;

const openMenuSettingId = "show-message-notifier";

let originalUpdateCount = null;
let indicator = null;
let settings = null;

let debugEnabled = false;
//let debugEnabled = true;
let alwaysShow = false;

function debug(message) {
    if (debugEnabled)
        log ("MESSAGE-NOTIFIER: " + message);
}

const Indicator = new Lang.Class({
    Name: "Indicator",
    Extends: PanelMenu.Button,

    _init: function() {
        this.parent(0.0, "Message notifier");

        this._countLabel = new St.Label({style_class: 'message-label'});

        this.actor.visible = false;
        this.actor.add_actor(this._countLabel);

        this.updateCount();

        debug("using keybinding '" + settings.get_strv(openMenuSettingId)[0] +
            "' to show the menu");
        global.display.add_keybinding(openMenuSettingId, settings,
                Meta.KeyBindingFlags.NONE,
                Lang.bind(this, function () {
                    if (this.menu.firstMenuItem) {
                        debug("menu activated through a keybinding");
                        this.menu.open();
                        this.menu.firstMenuItem.setActive(true);
                    }
                    else
                        debug("menu activated through a keybinding, " +
                            "but no items available");
                }));
    },

    destroy: function() {
        debug("unregistering keybindings");
        global.display.remove_keybinding(openMenuSettingId);

        this.parent();
    },

    _addItem: function(title, count, openFunction) {
        this._count += 1;

        if (count > 0)
            title += " (" + count.toString() + ")";

        let menuItem = new PopupMenu.PopupMenuItem(title);
        menuItem.connect('activate', openFunction);
        this.menu.addMenuItem(menuItem);

        debug("added item '" + title + "'");
    },

    _addItemWithSource: function(title, count, item) {
        this._addItem(title, count, Lang.bind(item, item.open));
    },

    _handleGeneric: function(item, sourceCount) {
        // Easiest case: every notification item represents a single chat.
        this._addItemWithSource(item.title, sourceCount, item);
    },

    _handleGenericWithNotifications: function(item, sourceCount, showCount, messageFilter) {
        // A single notification icon represents more conversations. We try
        // to split them based on the title.
        // If showCount is true it means that the application generates a
        // notification per new message, so we can count them (like in the
        // case of XChat-GNOME without libnotify).
        // Otherwise, the application (Pidgin for instance) just generates
        // a notification for the first message, so we cannot rely on
        // counting the notifications.

        if (!item.notifications)
            return;

        let countMap = {}
        for (let i = 0; i < item..notifications.length; i++) {
            let title = item.notifications[i].title;
            if (messageFilter)
                title = messageFilter(title);

            let count = countMap[title];
            if (count == undefined)
                count = 0;

            countMap[title] = count + 1;
        }

        for (let title in countMap)
            this._addItemWithSource(title, showCount ? countMap[title] : -1, item);
    },

    _startHandlingNotifySend: function() {
        this._pendingNotifySend = {}
    },

    _handleNotifySend: function(item, sourceCount) {
        // notify-send is invoked once per new message, so we need to go
        // through all the notifications icons, group them and then add
        // the items.
        // Note that notify-send is rubbish with gnome-shell as it ends
        // up just piling up notification icons in the tray and clicking
        // on them cannot open the corresponding application. By grouping
        // the notifications with the same title together we try to improve
        // things as a single click can get rid of multiple notifications.

        if (!item.notifications)
            return;

        // I really don't think there can be multiple ones, but...
        for (let i = 0; i < item.notifications.length; i++) {
            let title = item.notifications[i].title;
            let existing = this._pendingNotifySend[title];
            if (existing == undefined) {
                existing = new Array();
                debug("delaying addition of item '" + title + "'");
            }
            else {
                debug("updating the sources for delayed item '" + title + "'");
            }
            existing.push(item);
            this._pendingNotifySend[title] = existing;
        }
    },

    _finishHandlingNotifySend: function() {
        if (debugEnabled) {
            let pendingCount = Object.keys(this._pendingNotifySend).length;
            if (pendingCount > 0)
                debug("adding " + pendingCount + " pending notify-send items");
        }

        for (let title in this._pendingNotifySend) {
            let notifications = this._pendingNotifySend[title];
            this._addItem(title, notifications.length, function() {
                // We call open on all of the notifications, but I don't think it
                // can do anything in the notify-send case (except for dismissing
                // the notification).
                for (let i = 0; i < notifications.length; i++)
                    notifications[i].open();
            });
        }

        this._pendingNotifySend = undefined;
    },

    _handleXChat: function(item, sourceCount) {
        // Both XChat and XChat-GNOME use notifications in the same way.
        // Notice that XChat falls back to notify-send if it cannot use libnotify.
        this._handleGenericWithNotifications(item, sourceCount, true);
    },

    _handlePidgin: function(item, sourceCount) {
        this._handleGenericWithNotifications(item, sourceCount, false,
                function(message) {
                    // The title of pidgin-libnotify's notifications is
                    // "%s says:", but having that in the menu would be ugly.
                    // The string is marked for translation in the source
                    // code, but it's not actually translated.
                    return message.replace(/\s+says:$/, "");
                });
    },
 
    updateCount: function() {
        debug("updating count");

        let app_map = {
            'telepathy':                    this._handleGeneric, /* Chat notifications */
            'notify-send':                  this._handleNotifySend,
            'xchat-gnome.desktop':          this._handleXChat,
            'fedora-xchat-gnome.desktop':   this._handleXChat,
            'xchat.desktop':                this._handleXChat,
            'pidgin.desktop':               this._handlePidgin
        };

        this._count = 0;
        this._startHandlingNotifySend();
        this.menu.removeAll();

        let items = Main.messageTray.getSources();

        for (let i = 0; i < items.length; i++) {
            let item = items[i];
            let source = item;
            debug(item)

            // make sure we have item._mainIcon
            let sourceCount = 0;
            if(item) {
            	item._ensureMainIcon();
            	sourceCount = parseInt(item._mainIcon._counterLabel.get_text(), 10);
						}
            if (item.notifications && item.notifications.length > 0) {
                debug("processing item '" + item.title + "' with " +
                      item.notifications.length + " notifications:");
                for (let i = 0; i < item.notifications.length; i++)
                    debug ("    " + item.notifications[i].title);
            }
            else {
                debug("processing item '" + item.title + "' with " +
                      "no notifications");
            }

            if (!isNaN(sourceCount) && sourceCount > 0) {
                let key = null;
                if (item.isChat)
                    key = 'telepathy';
                else if (item.title == 'notify-send')
                    key = 'notify-send'
                else if (item.app)
                    key = item.app.get_id();
                if (key != null) {
                    let app_cb = app_map[key];
                    if (app_cb != null) {
                        debug ("processing with handler for key '" + key +
                               "', the item count is " + sourceCount);
                        app_cb.call(this, item, sourceCount);
                    }
                    else {
                        debug ("ignoring as there is no associated handler " +
                               "for key '" + key + "':");
                        debug ("    item title: '" + item.title + "'");
                        if (item.app) {
                            debug ("    app ID: '" + item.app.get_id() + "'");
                            debug ("    app name: '" + item.app.get_name() + "'");
                        }
                        else {
                            debug ("    app: null");
                        }
                    }
                }
            }
            else {
                debug ("ignoring as the count is " + sourceCount);
            }
        }

        this._finishHandlingNotifySend();

        debug ("the new total count is " + this._count);

        this._countLabel.set_text(this._count.toString());
        this.actor.visible = alwaysShow || this._count > 0;
    },
});

function customUpdateCount() {
    originalUpdateCount.call(this);
    try {
        indicator.updateCount();
    }
    catch (err) {
        /* If the extension is broken I don't want to break everything.
         * We just catch the extension, print it and go on */
        logError (err, err);
    }
}

function init() {
    if (GLib.getenv("MESSAGE_NOTIFIER_DEBUG")) {
        debugEnabled = true;
        debug ("initialising");
    }

    if (GLib.getenv("MESSAGE_NOTIFIER_ALWAYS_SHOW")) {
        alwaysShow = true;
        debug ("always showing the icon");
    }
}

function enable() {
    debug ("enabling");

    settings = Convenience.getSettings();

    originalUpdateCount = MessageTray.SourceActor.prototype._updateCount;
    MessageTray.SourceActor.prototype._updateCount = customUpdateCount;

    indicator = new Indicator();
    Main.panel.addToStatusArea('message-notifier', indicator, 0);
}

function disable() {
    debug ("disabling");

    MessageTray.SourceActor.prototype._updateCount = originalUpdateCount;
    originalUpdateCount = null;

    indicator.destroy();
    indicator = null;

    settings = null;
}
