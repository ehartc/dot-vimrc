Vim’s basics are fairly simple, but in combination the simple commands become powerful.
This is my Vim configuration tree, used and tweaked over a year.  Most of the time I'm writing code. So it's focused on faster writing, completion and navigation.

Although a vimrc is a very personal thing, I believe there are some settings/configs that you could use to improve your Vim setup, so I have commented most settings.
Feel free to explore it and use pieces from it (or use it in it's entirety, but I don't think that would really be useful).

In particular, there's a nice config for Neocomplete. These days it's somewhat geared towards Linux and Windows, but it is known to also work on MacOS X. 

How to update to latest version?
--------------------------------
Simply just do a git rebase!

    cd ~/.vimrc
    git pull --rebase

Manually install on Windows
---------------------------
1. Check out from github

        cd C:\Program Files\Vim   (or your installed path to Vim)
        rmdir /s vimfiles         (This deletes your old vim configurations. If you want to keep it, use move instead of rmdir.)
        git clone git://github.com/ehartc/dot-vimrc.git vimfiles
        git submodule update --init

2. Install vimrc. Add the following line at the end of C:\Program Files\Vim\vimrc

        source $VIM/vimfiles/vimrc

That's it.
