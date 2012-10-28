#coding: utf-8
#!/usr/bin/env python       
from gi.repository import Nautilus, GObject
from subprocess import call
import string
import os

class ColumnExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        pass

    def search_subtitles(self, menu, files):
        file_paths = ''
        for file in files:
            file_path = file.get_location().get_path()
            #evitar buscar nos diretórios???
            #if not os.path.isdir(file_path):
            file_paths += ' %s' % file_path

        #DEBUG
        print ' '
        print 'searching subtitles...'

        file_paths = file_paths[1:]
        print call(['/home/leandrost/.gem/ruby/1.9.1/bin/subdb', file_paths]) 
        call(['notify-send', 'Subtittles search DONE!'])

    def get_file_items(self, window, files):
        menuitem = Nautilus.MenuItem(name='SubtitleSearchMenuProvider::SearchSubtitle', 
            label='Search Subtitle', 
            tip='Search subtitles at SubDB',
            icon='')

        menuitem.connect('activate', self.search_subtitles, files)
        return menuitem,
